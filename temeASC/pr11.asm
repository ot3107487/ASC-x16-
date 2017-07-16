assume cs:code,ds:data
data segment
	n db 15
	sir db 30 dup(?)
data ends
code segment
afis10 proc
	push ax
	push bx
	push cx
	push dx
	mov dx,0
	mov cx,0
	mov bx,10
	calcul:
		cmp ax,0
		jz afis
		inc cx
		div bx
		add dx,'0'
		push dx
		mov dx,0
		jmp calcul
	afis:
		jcxz gata
		mov ah,2
		pop dx
		int 21h
		loop afis
gata:
	pop dx
	pop cx
	pop bx
	pop ax
ret
endp
start:
	push data
	pop ds
	mov bx,0
	mov bl,n
	;afisam 0 pe ecran
	mov ah,2
	mov dl,'0'
	int 21h
	mov ah,2
	mov dl,','
	int 21h
	xor si,si
	mov sir[si],0
	inc si
	haida:
		cmp si,bx
		jz endIt
		mov al,sir[si-1]
		add al,2
		mov sir[si],al
		mov ah,0
		call afis10
		push ax
		mov ah,2
		mov dl,','
		int 21h
		pop ax
		inc si
		jmp haida
	endit:
		add ax,2
		call afis10
		mov ax,4c00h
		int 21h
code ends
end start