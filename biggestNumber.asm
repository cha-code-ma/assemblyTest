section .data
    array: dd 4, 10, 8, 12, 4 ;array values

section .text
global _start

_start:
    mov ESI, array
    mov ECX, 5 ;length
    mov EAX, 0
max:
    mov EBX, [ESI]
    add ESI, 4
    CMP EAX, EBX
    CMOVL EAX, EBX
    DEC ECX
    CMP ECX, 0
    JE end
    JMP max

end:
    mov EDI, EAX
    mov EAX, 60
    syscall
