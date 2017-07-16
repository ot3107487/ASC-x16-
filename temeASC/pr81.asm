assume cs:code,ds:data
data segment
	sir db 10,24,11,23,5
	lungsir dw $-sir
data ends
code segment
afis2 proc
	push ax
	push bx
	push cx
	push dx
	mov cx,0
	mov dx,0
	mov bx,2
	calcul:
		cmp ax,0
		jz gata
		div bx
		add dx,'0'
		push dx
		inc cx
		xor dx,dx
		jmp calcul
	gata:
		jcxz final
		pop dx
		mov ah,2
		int 21h
		loop gata
final:
	mov ah,2
	mov dl,13
	int 21h
	mov ah,2
	mov dl,10
	int 21h
	pop dx
	pop cx
	pop bx
	pop ax
ret
endp	
start:
	push data
	pop ds
	xor si,si
	treaba:
		cmp si,lungsir
		jz magyarorszag
		mov al,sir[si]
		mov ah,0
		call afis2
		inc si
		jmp treaba
magyarorszag:
	mov ax,4c00h
	int 21h
code ends
end start
	
	