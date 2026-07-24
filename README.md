# BiggestNumber
In this repository I will try to write some assembly code for very simple tasks, to understand how assembly is writen.

## How to run an assembly program:
in LINUX, go to the terminal and write this:

sudo apt install nasm binutils

nasm -f elf64 file.asm -o file.o

ld file.o -o file

./file

echo $?

file stands for the file name you want to run and after this you will see the result.

## All tasks:
- `Biggestnumber.asm` is a progam where the biggest value is printed of an array.

- `divideDecimals.asm` is a program where 2 values get devided with a decimal accuracy of your choice.
