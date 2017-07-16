assume cs:code,ds:data
data segment
	maxFileName db 15
	fileSize db ?
	fileName db 15 dup(?)
	handle dw ?
	buffer db 250 dup(?)
	readen dw ?
	zece dw 10
data ends
code segment
print proc
	push ax
	push bx
	push cx
	push dx
	xor cx,cx
	repeta:
		cmp ax,0
		jz final
		mov dx,0
		div zece
		add dx,'0'
		push dx
		inc cx
		jmp repeta
	final:
		jcxz finish
		pop dx
		mov ah,2
		int 21h
		loop final
finish:
	pop dx
	pop cx
	pop bx
	pop ax
ret
endp
		
	
start:
	push data
	pop ds
	mov ah,10
	lea dx,maxFileName
	int 21h
	mov bx,0
	mov bl,fileSize
	mov fileName[bx],0;asciiz
	mov ah,3Dh
	lea dx,fileName
	mov al,2
	int 21h
	mov handle,ax
	mov ah,3Fh
	mov cx,250
	lea dx,buffer
	int 21h
	mov readen,ax
	xor ax,ax
	xor si,si
	cauta:
		cmp si,readen
		jz afisare
		cmp buffer[si],'a'
		jb next
		cmp buffer[si],'z'
		ja next
		inc ax
		inc si
		jmp cauta
		next:
			inc si
			jmp cauta
	afisare:
		call print
		mov ax,4c00h
		int 21h
code ends
end start
			
		