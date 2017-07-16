assume cs:code , ds:data
data segment
	handle dw ?
	msg db 13,10,'Introduceti numele fisierului:',13,10,'$'
	maxlen db 15
	len db ?
	filename db 15 dup(?)
	startpoz dd 0
	endpoz dd 0
	sizeoffile dd ?
data ends
code segment
start:
	push data
	pop ds
	mov ah,0Ah
	lea dx,maxlen
	int 21h
	;asciiz
	xor bx,bx
	mov bl,len
	mov filename[bx],0
	;openfile
		lea dx,filename
		mov ah,3Dh
		mov al,0
		int 21h
		mov handle,ax
	;read bytes
		mov bx,handle
		mov ah,42h
		mov cx,0
		mov dx,0
		mov al,2
		int 21h
		mov word ptr sizeoffile,ax
		mov word ptr sizeoffile+2,dx
		mov bx,handle
		mov ah,42h
		mov cx,0
		mov dx,0
		mov al,0
		int 21h
		sub word ptr sizeoffile,ax
		sbb word ptr sizeoffile+2,dx
		jmp finish
	finish:
		mov ax,4C00h
		int 21h
code ends
end start
		
		
		
		
		
	
	
	