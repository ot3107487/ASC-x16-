assume cs:code,ds:data
data segment
	msg1 db 'Introduceti primul numar$'
	msg2 db 'Introduceti al doilea numar$'
	lungnr1 db 7
	lung1 db ?
	nr1 db 7 dup(?)
	lungnr2 db 7
	lung2 db ?
	nr2 db 7 dup(?)
	suma dw 0
data ends
code segment
start:
	push data
	pop ds
	mov ah,09h
	lea dx,msg1
	int 21h
	mov ah,10
	lea dx,lungnr1
	int 21h
	mov ah,9
	lea dx,msg2
	int 21h
	mov ah,10
	lea dx,lungnr2
	int 21h
	mov dl,lung1
	mov dh,0
	mov si,0
	mov bl,10
	mov ax,0 ; va fi folosit pentru primul nr in baza 10
	nmr1:
		cmp si,dx
		jz nmr2
		mov ch,0
		mov cl,nr1[si]
		sub cl,'0'
		mul bl
		add ax,cx
		inc si
		jmp nmr1
	nmr2:
		add suma,ax
		mov dl,lung2
		mov dh,0
		mov si,0
		mov ax,0
		aduna:
			cmp si,dx
			jz final
			mov ch,0
			mov cl,nr2[si]
			sub cl,'0'
			mul bl
			add ax,cx
			inc si
			jmp aduna
	final:
		add suma,ax
		mov ax,4C00h
		int 21h
code ends
end start
			
		
		
		
	
	