nasm -f elf32 tpResolvente.asm -o tpResolvente.o
sudo gcc -m32  tpResolventeC.c tpResolventeC.o -o resolvente
./resolvente
