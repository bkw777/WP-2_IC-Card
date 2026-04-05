#define _CRT_SECURE_NO_WARNINGS
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

#define BAUD_RATE CBR_9600
#define BANK_SIZE 0x4000 // 16KB per bank (0x4000 to 0x7FFF)
#define START_ADDRESS 0x4000
#define ERASE_TIMEOUT_MS 100 // Timeout for erase ACK (20ms typical, padded for safety)

// Function to open and configure the COM port
HANDLE open_serial_port(const char* port_name) {
    wchar_t full_port_name[16];
    _swprintf(full_port_name, L"\\\\.\\COM%d", atoi(port_name)); // Use wide-character string

    HANDLE hSerial = CreateFileW(full_port_name, GENERIC_READ | GENERIC_WRITE, 0, NULL,
        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (hSerial == INVALID_HANDLE_VALUE) {
        fprintf(stderr, "Error opening COM port %ls: %ld\n", full_port_name, GetLastError());
        return INVALID_HANDLE_VALUE;
    }

    DCB dcbSerialParams = { 0 };
    dcbSerialParams.DCBlength = sizeof(dcbSerialParams);
    if (!GetCommState(hSerial, &dcbSerialParams)) {
        fprintf(stderr, "Error getting COM state: %ld\n", GetLastError());
        CloseHandle(hSerial);
        return INVALID_HANDLE_VALUE;
    }

    dcbSerialParams.BaudRate = BAUD_RATE;
    dcbSerialParams.ByteSize = 8;
    dcbSerialParams.StopBits = ONESTOPBIT;
    dcbSerialParams.Parity = NOPARITY;

    if (!SetCommState(hSerial, &dcbSerialParams)) {
        fprintf(stderr, "Error setting COM state: %ld\n", GetLastError());
        CloseHandle(hSerial);
        return INVALID_HANDLE_VALUE;
    }

    COMMTIMEOUTS timeouts = { 0 };
    timeouts.ReadIntervalTimeout = 50;
    timeouts.ReadTotalTimeoutConstant = 50;
    timeouts.ReadTotalTimeoutMultiplier = 10;
    timeouts.WriteTotalTimeoutConstant = 50;
    timeouts.WriteTotalTimeoutMultiplier = 10;

    if (!SetCommTimeouts(hSerial, &timeouts)) {
        fprintf(stderr, "Error setting COM timeouts: %ld\n", GetLastError());
        CloseHandle(hSerial);
        return INVALID_HANDLE_VALUE;
    }

    return hSerial;
}

// Function to send a command and read response
int send_command(HANDLE hSerial, const unsigned char* cmd, size_t cmd_len,
    unsigned char* response, size_t response_len, DWORD timeout_ms) {
    DWORD bytes_written, bytes_read;
    if (!WriteFile(hSerial, cmd, cmd_len, &bytes_written, NULL) || bytes_written != cmd_len) {
        fprintf(stderr, "Error writing to COM port: %ld\n", GetLastError());
        return -1;
    }

    Sleep(timeout_ms); // Wait for device to process

    if (!ReadFile(hSerial, response, response_len, &bytes_read, NULL)) {
        fprintf(stderr, "Error reading from COM port: %ld\n", GetLastError());
        return -1;
    }

    return bytes_read;
}

// Erase flash ROM
int erase_flash(HANDLE hSerial) {
    unsigned char cmd = 0x45; // 'E' for erase
    unsigned char response;
    int bytes_read = send_command(hSerial, &cmd, 1, &response, 1, ERASE_TIMEOUT_MS);
    if (bytes_read != 1 || response != 0x01) {
        fprintf(stderr, "Flash erase failed: Expected 0x01, got 0x%02X\n", response);
        return -1;
    }
    printf("Flash erased successfully\n");
    return 0;
}

// Read current bank using 'p' command
int read_bank(HANDLE hSerial, unsigned char* current_bank) {
    unsigned char cmd = 0x70; // 'p' to read bank control register
    int bytes_read = send_command(hSerial, &cmd, 1, current_bank, 1, 10);
    if (bytes_read != 1) {
        fprintf(stderr, "Failed to read current bank: Got %d bytes\n", bytes_read);
        return -1;
    }
    return 0;
}

// Set bank control register
int set_bank(HANDLE hSerial, unsigned char bank) {
    unsigned char cmd[] = { 0x50, bank }; // 'P' followed by bank number
    unsigned char response;
    int bytes_read = send_command(hSerial, cmd, 2, &response, 1, 10);
    if (bytes_read != 1 || response != 0x01) {
        fprintf(stderr, "Failed to set bank 0x%02X: Expected 0x01, got 0x%02X\n",
            bank, response);
        return -1;
    }

    // Verify the bank was set correctly using 'p' command
    unsigned char current_bank;
    if (read_bank(hSerial, &current_bank) != 0 || current_bank != bank) {
        fprintf(stderr, "Bank verification failed: Expected 0x%02X, got 0x%02X\n",
            bank, current_bank);
        return -1;
    }

    return 0;
}

// Read a byte from memory using 'R' command (for verification)
int read_memory(HANDLE hSerial, unsigned short address, unsigned char* data) {
    unsigned char cmd[] = { 0x52, (address >> 8) & 0xFF, address & 0xFF }; // 'R', high addr, low addr
    int bytes_read = send_command(hSerial, cmd, 3, data, 1, 10);
    if (bytes_read != 1) {
        fprintf(stderr, "Failed to read address 0x%04X: Got %d bytes\n", address, bytes_read);
        return -1;
    }
    return 0;
}

// Write a byte to memory
int write_memory(HANDLE hSerial, unsigned short address, unsigned char data) {
    unsigned char cmd[] = { 0x57, (address >> 8) & 0xFF, address & 0xFF, data }; // 'W', high addr, low addr, data
    unsigned char response;
    int bytes_read = send_command(hSerial, cmd, 4, &response, 1, 10);
    if (bytes_read != 1 || response != 0x01) {
        fprintf(stderr, "Failed to write 0x%02X to address 0x%04X: Expected 0x01, got 0x%02X\n",
            data, address, response);
        return -1;
    }

    // Optional: Verify the written byte using 'R' command
    /*
    unsigned char read_data;
    if (read_memory(hSerial, address, &read_data) != 0 || read_data != data) {
        fprintf(stderr, "Write verification failed at address 0x%04X: Expected 0x%02X, got 0x%02X\n",
                address, data, read_data);
        return -1;
    }
    */

    return 0;
}
int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <COM_PORT_NUMBER> <FILENAME>\n", argv[0]);
        return 1;
    }

    const char* port_num = argv[1];
    const char* filename = argv[2];

    // Open serial port
    HANDLE hSerial = open_serial_port(port_num);
    if (hSerial == INVALID_HANDLE_VALUE) {
        return 1;
    }

    // Open input file
    FILE* file = fopen(filename, "rb");
    if (!file) {
        fprintf(stderr, "Error opening file %s: %s\n", filename, strerror(errno));
        CloseHandle(hSerial);
        return 1;
    }

    // Erase flash
    if (erase_flash(hSerial) != 0) {
        fclose(file);
        CloseHandle(hSerial);
        return 1;
    }

    // Get file size
    fseek(file, 0, SEEK_END);
    long file_size = ftell(file);
    rewind(file);

    // Write file to memory
    unsigned short address = START_ADDRESS;
    unsigned char bank = 0x0F; // Start with bank 0
    long bytes_processed = 0;
    long bytes_written = 0;

    printf("Processing %ld bytes starting at bank 0x%02X, address 0x%04X\n",
        file_size, bank, address);

    // Set initial bank
    if (set_bank(hSerial, bank) != 0) {
        fclose(file);
        CloseHandle(hSerial);
        return 1;
    }

    // Process byte by byte
    unsigned char byte;
    while (fread(&byte, 1, 1, file) == 1) {
        // Check if we need to switch banks
        if (address > 0x7FFF) {
            bank++;
            address = START_ADDRESS;
            printf("Switching to bank 0x%02X\n", bank);
            if (set_bank(hSerial, bank) != 0) {
                fclose(file);
                CloseHandle(hSerial);
                return 1;
            }
        }

        // Skip writing if byte is 0xFF (erased flash state)
        if (byte != 0xFF) {
            // Write byte to memory
            if (write_memory(hSerial, address, byte) != 0) {
                fclose(file);
                CloseHandle(hSerial);
                return 1;
            }
            bytes_written++;
        }

        address++;
        bytes_processed++;
        if (bytes_processed % 1024 == 0) {
            printf("Processed %ld bytes (wrote %ld bytes)\n", bytes_processed, bytes_written);
        }
    }

    printf("Successfully processed %ld bytes (wrote %ld bytes) to memory\n",
        bytes_processed, bytes_written);

    // Clean up
    fclose(file);
    CloseHandle(hSerial);
    return 0;
}