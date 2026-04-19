HXVIEW23.PR is the actual compiled binary Ben provided in the Discord channel (@BennVenn #off-topic),
except manually binary edited to change the version number from 2.2 to 2.3 because Ben forgot to change it when he added the new raw & burst read & write commands.

Similarly, HexViewer_2.3.asm is the source Ben provided except with the version number changed to 2.3


To Compile:

  $ z88dk-z80asm -b HexViewer_2.3.asm

This produces HexViewer_2.3.bin

Verify that the generated .bin is identical to HXVIEW23.PR

  $ cmp -b HexViewer_2.3.bin HXVIEW23.PR && echo same || echo differ
  same
