

    disp macro msg
        mov ah,09h
        mov dx,offset msg
        int 21h
    endm



code segment
    assume cs:code , ds:data
    start:
            mov ax,data
            mov ds,ax
            mov si ,offset inp
            mov di,offset res
            disp msg1

            mov cx,0000h
        readchar:   mov ah,01h
                    int 21h
                    cmp al,CR  
                    je ahead
                    mov [si],al
                    inc si
                    inc cx
                    jmp readchar
        ahead:      
                    mov bx,cx
        revers:     dec si  
                    mov al,[si]
                    mov [di],al
                    inc di
                    loop revers
                mov al,'$'
                mov [di],al
                disp msg2
                disp res

                mov si,offset inp
                mov di,offset res
                mov cx,bx
            check:  mov al,[si]
                    cmp al,[di]
                    jne false
                    inc si
                    inc di
                    loop check
                    disp msg3
                    jmp exit
            false:  disp msg4
            exit:   mov ah,4ch
                    int 21h 
code ends

data segment

    inp db 40 dup(0)
    res db 40 dup(0)
    CR equ 0dh
    msg1 db 'ENTER THE STRING$'
    msg2 db 0ah,0dh,'REVERSE OF STRING$'
    msg3 db 0ah,0dh,'PALINDROME$'
    msg4 db 0ah,0dh,'NOT PALINDROME$'
data ends

end start
