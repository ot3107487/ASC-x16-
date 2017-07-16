assume cs:code,ds:data
data segment
	maxFileLen db 15
	fileLen db ?
	fileName db 15 dup(?)
	handle dw ?
	msg db 'sfarsit de fisier'
	msgLen dw $-msg
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
	lea dx,fileName
	mov al,2
	int 21h
	mov handle,ax
	mov bx,handle
	mov ah,42h
	mov cx,0
	mov dx,0
	mov al,2
	int 21h
	mov ah,40h
	mov bx,handle
	mov cx,msgLen
	lea dx,msg
	int 21h
	mov ax,4c00h
	int 21h
code ends
end start
	