assume cs:code ,ds:data
data segment
	msg db 'Numele fisierului: $'
	maxFileName db 12
	lFileName db ?
	fileName db 12 dup (?)
	buffer db 100 dup (?), '$'
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov di,1
	mov ah,09h
	mov dx,offset msg
	int 21h
	; citim de la tastatura numele fisierului
	mov ah,0Ah
	lea dx,maxFileName
	int 21h
	
	;transformare nume fisier in ASCIIZ
	mov al,lFileName
	mov ah,0
	mov si,ax
	mov fileName[si],0
	
	;deschidem fisierul
	mov ah,3Dh
	mov al,0 ; citire
	lea dx,fileName
	int 21h
	mov bx,ax
	citire:
		mov ah,3Fh
		lea dx,buffer
		mov cx,2000
		int 21h
		mov si,ax
		mov buffer[si],'$'
		xor si,si
		cauta:
			cmp buffer[si],'$'
			je afisare
			cmp buffer[si],0Ah
			je
			
		afisare:
		mov ah,09h
		int 21h
		cmp si,255
		je citire
		
		jmp endPrg ; sarim peste tratarea eventualelor erori

	endPrg:
		mov ax,4c00h
		int 21h
code ends
end start