assume cs:code,ds:data
data segment
	buffer db 255,255 dup (?),'$'
	numar db 13,10,16 dup(?),'$'
	handle db 'bogdanel.txt',0
	filename dw ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	lea dx,numar
	mov ah,9
	;int 21h
	mov ah,10
	lea dx,buffer
	int 21h
	xor si,si
	add si,2
	xor cx,cx
	mov ax,0
	mov bl,10
	mov dh,0
	conversie:
		cmp buffer[si],13
		jz gata
		inc si
		inc cx
		jmp conversie
	gata:
		mov si,1
		jmp next
	next:
		jcxz forward
		inc si
		mul bl
		mov dl,buffer[si]
		sub dl,'0'
		mov dh,0
		add ax,dx
		loop next
	forward:
		mov si,2
		rol ax,1
		jmp almost
	almost:
		;ax - numarul in baza 10
		cmp dh,16
		jz finish
		test ax,1
		jz aici
		mov dl,31h
		mov numar[si],dl
		inc si
		rol ax,1
		inc dh
		jmp almost
		aici:
		mov dl,30h
		mov numar[si],dl
		inc si
		rol ax,1
		inc dh
		jmp almost
	finish:
	mov ah,9
	lea dx,numar
	int 21h
	mov ah,3Ch
	mov cx,0
	lea dx,handle
	int 21h
	push ax
	lea dx,handle
	mov ah,3Dh
	mov al,1
	int 21h
	mov ah,40h
	pop	bx
	mov cx,16
	lea dx,numar
	int 21h
	mov ax,4C00h
	int 21h
code ends
end start