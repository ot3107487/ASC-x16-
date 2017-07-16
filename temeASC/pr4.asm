assume cs:code,ds:data
data segment
	maxLenSir1 db 255
	lenSir1 db ?
	sir1 db 255 dup(?)
	maxLenSir2 db 255
	lenSir2 db ?
	sir2 db 255 dup(?)
	sirRez db 255 dup(?),'$'
data ends
code segment
start:
	push data
	pop ds
	mov ah,0Ah
	lea dx,maxLenSir1
	int 21h
	mov ah,0Ah
	lea dx,maxLenSir2
	int 21h
	mov ch,0
	mov cl,lenSir1
	add cl,cl
	xor si,si;sir1
	xor di,di;sir2
	xor bx,bx;rez
	concat:
		cmp bx,cx
		jz final
		test bx,1
		jz sirul1
		mov al,sir2[di]
		mov sirRez[bx],al
		inc di
		inc bx
		jmp concat
		sirul1:
			mov al,sir1[si]
			mov sirRez[bx],al
			inc si
			inc bx
			jmp concat
	final:
		mov sirRez[bx],'$'
		mov ah,09h
		lea dx,sirRez
		int 21h
		mov ax,4C00h
		int 21h
code ends
end start
		