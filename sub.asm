data segment
    
    msg1 db 'ENTER THE STRING$'
    msg2 db 'ENTER THE SUBSTRING$'
    msg3 db 0ah,0dh,'SUBSTRING$'
    msg4 db 0ah,0dh,'NOT SUBSTRING$'
    count1 dw 1 dup(0)
    count2 dw 1 dup(0)
    stri db 40 dup(?)
    subs db 40 dup(?)
    CR EQU 0DH


    disp macro msg
        mov ah,09h
        mov dx,offset msg
        int 21h
    endm


data ends
code segment
        assume cs:code ,ds:data
        start: mov ax,data  
               mov ds,ax
               mov cx,0000h
               mov bx,0000h
               mov si ,offset stri
               mov di, offset subs

                    disp msg1
        readstr:    mov ah,01h
                    int 21h
                    cmp al,CR
                    je aheadstr
                    mov [si],al
                    inc si
                    inc cx  
                    jmp readstr
        aheadstr:   mov count1, cx

                    disp msg2
        readsub:    mov ah,01h
                    int 21h
                    cmp al,CR
                    je aheadsub
                    mov [di],al
                    inc di
                    inc bx
                    jmp readsub
        aheadsub:    mov count2,bx

		   
                   
		
        
                       mov si,offset stri
           	       
		       
		       mov di,offset subs
		      
	     loo:      mov al,[si]
		       cmp al,[di]
		       jnz subno
		       inc di
		       dec bx
		       jnz subno
		       disp msg3
		       jmp srend
	      subno :  inc si
		       loop  loo
        	       disp msg4		

		      
           srend:     mov ah,4ch
                      int 21h
code ends
end start
