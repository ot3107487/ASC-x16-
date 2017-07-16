;Ioan Bogdan , Grupa 214/1 , Lab8p8
;Sa se scrie un program care citeste numele unui fisier de la tastatura si apoi va afisa liniile de ordin impar din acest fisier.
ASSUME cs: code, ds:data 

data SEGMENT
	maxFilel db 20
	mia db 'Saluuut'
	len db ?
	NameFile db 20 dup (?)
	newl db 13, 10, '$'
	newBuffer db 100 dup (?)
	buffer db 100 dup (?), '$'
	firstLine db 100 dup(?)
data ENDS

code SEGMENT 
	; in proc puneEndl punem endl la finalul unei linii
	puneEndl proc
	mov newBuffer[bp], 13
	inc bp
	mov newBuffer[bp], 10
	inc bp
	inc di
	ret
	puneEndl endp

start: 
	
	mov ax,data 
	mov ds,ax

	;citim numele fisierului
	mov ah, 10
	mov dx, offset maxFilel
	int 21h

	mov ah, 9
	lea dx, newl
	int 21h

	;transformam numele in ASCIIZ
	xor bx, bx
	mov bl, len
	mov NameFile[bx], '$'

	mov ah, 3dh
	mov al, 0
	lea dx, NameFile
	int 21h
	mov bx, ax ; salvam handle-ul fisierului

	mov ah, 3fh
	;am salvat in BX handle-ul
	mov cx, 100 ; citim maxim 100 de caractere
	lea dx, buffer
	int 21h
	
	;afisam ce este in buffer
	mov cx, 100
	mov si, 0 ; contor pt pozitia in buffer
	mov di, 0 ; contor pt numarul de endl
	mov bp, 0 ; contor pentru pozitia in newBuffer
	mov newBuffer[bp],13
	copy:
		;comparam cu ASCII 13
		cmp buffer[si], 13
		je aici
		jmp treciPeste
		aici:
		cmp buffer[si+1], 10 ; comparam cu ASCI 10
		jne treciPeste
		cmp di,0; daca e primul \n, salvam prima linie
		jz primaLinie
		inc di ;numaram de cate ori a aparut endl;
		;daca e par , copiem din buffer pana la urmatorul endl
		test di, 1 
		jz checkEnd; ; verificam daca numarul de endl-uri e par
		jmp treciPeste
	
	checkEnd: ; copiem tot ce e intre endl-uri
		add si, 2
		cmp buffer[si], 13
		jne aici1

	aici1:
		cmp buffer[si], 13
		je next

		mov al, buffer[si]
		mov newBuffer[bp], al
		inc bp
		inc si
		cmp si, 50
		je afiseaza
		jmp aici1
	next:
		cmp buffer[si+1], 10
		je puneInSir

		mov al, buffer[si]
		mov newBuffer[bp], al
		inc bp
		inc si
		jmp aici1

	puneInSir:
		call puneEndl
		inc si
	treciPeste:
		inc si
		loop copy
		jmp afiseaza
	primaLinie:
		; in caz ca e prima linie , eticheta se comporta ca si treciPeste
		;in plus, incrementeaza di , si salveaza pe stiva primul \n 
		push si
		inc si
		inc di
		loop copy
	afiseaza:
		mov ah,buffer
		mov firstLine,ah
		pop si
		mov buffer[si+1],10
		mov buffer[si+2],'$'
		mov ah,9
		lea dx,buffer
		int 21h
		mov ah,9
		mov newBuffer[100], '$'
		lea dx, newBuffer		;functia de afisare
		int 21h

	exit:


	mov ax,4C00h 
	int 21h 
code ENDS 
END start