assume cs:code,ds:data
data segment
	msg db 'Introduceti sirul de caractere',13,10,'$'
	maxStringSize db 255
	stringSize db ?
	string db 255 dup(?)
	zece db 10
data ends
code segment
baza10 proc
	push bx
	push cx
	push dx
	xor cx,cx
	repet:
		cmp al,0
		jz final
		mov ah,0
		div zece
		add ah,'0'
		mov bl,ah
		mov bh,0
		inc cx
		push bx
		jmp repet
	final:
		jcxz finish1
		mov ah,02
		pop bx
		mov dl,bl
		int 21h
		loop final
finish1:
	pop dx
	pop cx
	pop bx
ret		
endp
start:
	push data
	pop ds
	mov ah,09h
	lea dx,msg
	int 21h
	mov ah,0Ah
	lea dx,maxStringSize
	int 21h
	mov ax,0
	xor bx,bx
	cauta:
		cmp bl,stringSize
		jz finish
		cmp string[bx],'X'
		jz creste
		inc bx
		jmp cauta
		creste:
			inc bx
			inc ax
			jmp cauta
		finish:
			call baza10
			mov ax,4c00h
			int 21h
code ends
end start