assume cs:code,ds:data
data segment
	maxFileLen db 15
	fileLen db ?
	fileName db 15 dup(?)
	buffer db 11 dup(?),'$'
	handle dw ?
data ends
code segment
start:
	push data
	pop ds
	mov ah,0Ah
	lea dx,maxFileLen
	int 21h
	xor bx,bx
	mov bl,fileLen
	mov fileName[bx],0
	mov ah,3Dh
	mov al,0
	lea dx,fileName
	int 21h
	mov handle,ax
	mov ah,42h
	mov bx,handle
	mov cx,0
	mov dx,20
	mov al,0
	int 21h
	mov ah,3Fh
	mov bx,handle
	mov cx,11
	lea dx,buffer
	int 21h
	mov ah,09h
	lea dx,buffer
	int 21h
	mov ax,4c00h
	int 21h
code ends
end start