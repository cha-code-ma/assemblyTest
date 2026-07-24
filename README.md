# BiggestNumber
In this repository I will try to write some assembly code for very simple tasks, to understand how assembly is writen. Like dividing with decimals and functions on a given list.

## How to run an assembly program:
in LINUX, go to the terminal and write this:

sudo apt install nasm binutils

- For biggestNumber:

nasm -f elf64 biggestNumber.asm -o biggestNumber.o

ld biggestNumber.o -o biggestNumber

./biggestNumber

echo $?

- For divideDecimals: in the code, set a, b to desired values.

nasm -f elf64 divideDecimals.asm -o divideDecimals.o

ld divideDecimals.o -o divideDecimals

./divideDecimals


## All tasks:
- `Biggestnumber.asm` is a progam where the biggest value is printed of an array.

- `divideDecimals.asm` is a program where 2 values get devided with an accuracy of your choice.
