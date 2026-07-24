section .data
    a: dd 7
    b: dd 6
    accuracy: dd 5
    ;The calculation will  be a/b with 'accuracy' decimals.
    text: dd 'Resultaat: '
    len equ $ - text
section .bss
    buffer: resb 10 ;reseveert 10 bytes
section .text
    global _start


_start:
    MOV ECX, [accuracy] ;accuracy in ECX, amount of digits
    MOV EDX, 0 ; this is where the rest comes
    MOV EBX, 10 ;this is a factor
    MOV EDI, [a] ;this is the teller
    MOV ESI, [b] ;this is the noemer, doesnt change
    MOV EBP, 0 ;the SUM

startLoop:
    MOV EAX, EDI ;set teller in right register
    MOV EBX, ESI ;set noemer in right register

    DIV EBX ;divide
    MOV EDI, EDX ;save rest in EDI
    MOV EBX, 10 ;factor
    ADD EAX, EBP ;add sum to answer
    CMP ECX, 1
    JE skip
    MUL EBX ;multiply sum x10
    skip:
    MOV EDX, EDI ;rest back in EDX
    MOV EBX, 10 ;stays at 10
    MOV EBP, EAX ;returns sum to EBP

    MOV EAX, EDX ;move rest to EAX
    MUL EBX ;multiplies rest x10
    MOV EBX, 10 ;stays at 10
    MOV EDI, EAX ;moves rest to EDI, next teller

    DEC ECX ;dec count
    CMP ECX, 0 ;if count ==0 :done
    JNE startLoop
    CALL convertNumber ;sum is in  EBP

    JMP printText


convertNumber:
    CALL determineDotPlace
    PUSH RDI
    MOV EAX, EBP ; mov sum to EAX
    MOV EBP, ECX
    MOV ECX, [accuracy] ;move length to ECX
    INC ECX
    MOV EBX, 10 ;NUMBER 10
    MOV ESI, buffer+9 ;last
    MOV BYTE [ESI], 10
    convertNumber_loop:
    POP RDI
    CMP EDI, ECX ;if we are at the right index

    JNE skipDot
    PUSH RDI
    DEC ESI ;decrese buffer position
    MOV EDX, 46 ;this is the '.' ASCII code
    MOV [ESI], DL ;sets character into buffers
    DEC ECX
    CMP ECX, 0 ;compare for jump

    JNZ convertNumber_loop ;0 means done
    POP RDI
    RET ;done
    skipDot:
    PUSH RDI
    MOV EBX, 10 ;set to 10 again
    DEC ESI ;decrese buffer position
    XOR EDX, EDX ;set edx 0
    DIV EBX ;divide by 10
    ADD EDX, '0' ;so it will be ascii text instead of number
    MOV [ESI], DL ;sets character into buffers

    DEC ECX ;decrese count
    CMP ECX, 0 ;comapre, for jump
    JNZ convertNumber_loop
    POP RDI
    RET

printText:
    PUSH RSI
    MOV RSI, text
    MOV EAX, 1 ;syscall nummer write
    MOV EDI, 1 ;file descripter 1 stdout
    MOV EDX, len
    SYSCALL

    POP RSI


    ;in RSI is the text
    MOV RSI, RSI
    MOV EAX, 1 ;syscall nummer write
    MOV EDI, 1 ;file descripter 1 stdout
    MOV EDX, [accuracy] ;len massage :amount byes
    ADD EDX, 2 ;add 1 for the '.' character, and 1 for '\n'
    SYSCALL ;write


    MOV EAX, 60;exit-syscall
    MOV EDI, 0 ;argument exitcode, 0, goed gedaan
    SYSCALL


determineDotPlace:
    MOV EAX, [a] ;teller
    MOV EBX, [b] ;noemer
    XOR EDX, EDX
    DIV EBX ;divide
    MOV EDI, 0 ;count amount of digits whole number

loopie:
    INC EDI ;inc count
    XOR EDX, EDX
    MOV EBX, 10 ; number 10
    DIV EBX ;divide by 10
    CMP EAX, 0
    JZ endie ;if 0, then, the size of whole number is done
    JMP loopie

endie:
    INC EDI
    RET
