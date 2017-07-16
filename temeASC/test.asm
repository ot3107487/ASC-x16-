assume cs:code,ds:data
data segment
	A db 18
	B dw 24
	C dw ?
	D dd 47
	E dd 12
	Aux dw 2
	Aux2 db 4
	Aux3 db 1
	Aux4 equ 10
	Aux5 db 2
	Aux6 db 1
	data ends
	code segment
start:
	mov ax,data
	mov ds,ax
	Mov al, 7
	Mov bx, ax
	Mov aux, ax
	Mov al, 0
	Mov ah, a
	Mov cl, 5
	mov aux3, cl
	cbw 
	add aux, ax
	sub cx, ax
	mov bx, 2
	mov ax, b
	mov dl, 2
	div aux5
	add dl, aux5
	add ax, aux4
	mov cx, 0
	mov bx, 2
	sub cx, ax
	sbb dx, bx
	mov cl, 5
	cbw 
	sub cx, cx
	mov al, 4
	mov dl, 5
	mul aux6
	mul dl
	cwd
	add ax, word ptr d
	adc dx, word ptr d+2
	mov al, 4
	add bx, bx
	mov ax, 3
	mul bl
	mov ax,4C00h
	int 21h
code ends
end start