assume cs:code,ds:data
data segment
	a db 45
	b db 2
	c db 15
	zece EQU 10 ;constanta - EQU
	e dw ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,a
	mul b
	mov bx,ax
	mov al,c
	cbw ; convert byte to word . Extindem valoarea lui c pe dimensiunea unui cuvant
	add bx,ax
	mov al,zece
	mul b
	sub bx,ax
	mov e,bx
mov ax,4C00h
int 21h
code ends
end start
	
