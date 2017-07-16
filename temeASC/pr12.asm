assume cs:code,ds:data
data segment
	maxFileName db 15
	nameLen	 db ?
	fileName db 15 dup(?)
	buffer db 255 dup(?)
	bytesRead dw ?
	handle dw ?
	
data ends
code segment
afis10 proc
	push ax
	push bx
	push cx
	push dx
	xor cx,cx
	mov dx,0
	mov bx,10
	go:
		cmp ax,0
		jz goOn
		inc cx
		div bx
		add dx,'0'
		push dx
		mov dx,0
		jmp go
	goOn:
		jcxz finish
		pop dx
		mov ah,2
		int 21h
		loop goOn
	finish:
		pop dx
		pop cx
		pop bx
		pop ax
ret
endp
start:
	push data
	pop ds
	mov ah,10
	lea dx,maxFileName
	int 21h
	;asciiz
	mov bl,nameLen
	mov bh,0
	mov fileName[bx],0
	;openfile
	mov ah,3Dh
	mov al,2
	lea dx,fileName
	int 21h
	mov handle,ax
	;readFromFile
	mov ah,3Fh
	mov bx,handle
	mov cx,200
	lea dx,buffer
	int 21h
	mov bytesRead,ax
	;mutam pointerul la inceputul fisierului cu 42h
	mov ah,42h
	mov bx,handle
	mov cx,0
	mov dx,0
	mov al,0
	int 21h
	xor ax,ax;in ax salvam nr de inlocuiri
	xor si,si
	cauta:
		cmp si,bytesRead
		jz final
		cmp buffer[si],'a'
		jz a
		cmp buffer[si],'e'
		jz e
		cmp buffer[si],'i'
		jz i
		cmp buffer[si],'o'
		jz o
		cmp buffer[si],'u'
		jz u
		inc si
		jmp cauta
		a:
			mov buffer[si],'1'
			inc si
			inc ax
			jmp cauta
		e:
			mov buffer[si],'2'
			inc si
			inc ax
			jmp cauta
		i:
			mov buffer[si],'3'
			inc si
			inc ax
			jmp cauta
		o:
			mov buffer[si],'4'
			inc si
			inc ax
			jmp cauta
		u:
			mov buffer[si],'5'
			inc si
			inc ax
			jmp cauta
	final:
	;modificam fisierul si afisam pe ecran nr de modificari
	push ax;salvam nr de modif pe stiva
	mov ah,40h
	mov bx,handle
	mov cx,bytesRead
	lea dx,buffer
	int 21h
	pop ax;scoatem de pe stiva nr de modif
	call afis10 ; afisam in baza 10 nr de modif
	mov ax,4c00h
	int 21h
code ends
end start
	
	
	