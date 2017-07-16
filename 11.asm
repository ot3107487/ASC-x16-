assume ds:data,cs:code
data segment
a db 15
b db 22
c db 30
d db 45
e dw ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,a
	add al,b
	mov bl,al
	mov al,c
	add al,d
	sub bl,al
	mov e,bx
	mov ax,4C00h
	int 21h
code ends
end start
	