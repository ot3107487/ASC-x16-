assume cs:code,ds:data
data segment
	msg1 db 'Introduceti sirul:',13,10,'$'
	msg2 db 'Introduceti caracterul:',13,10,'$'
	maxStringSize db 255
	stringSize db ?
	string db 255 dup(?)
	win db 'Da $'
	lose db 'Nu $'
	chr db ?
data ends
code segment
start:
	push data
	pop ds
	mov ah,09h
	lea dx,msg1
	int 21h
	mov ah,0Ah
	lea dx,maxStringSize
	int 21h
	mov ah,09h
	lea dx,msg2
	int 21h
	mov ah,01h
	int 21h
	mov chr,al
	mov bh,0
	mov bl,stringSize
	xor si,si
	seekanddestroy:
		cmp si,bx
		jz lost
		mov al,chr
		cmp string[si],al
		jz winner
		inc si
		jmp seekanddestroy
	lost:
		mov ah,09h
		lea dx,lose
		int 21h
		jmp finish
	winner:
		mov ah,09h
		lea dx,win
		int 21h
		jmp finish
	finish:
		mov ax,4c00h
		int 21h
code ends
end start
	
	