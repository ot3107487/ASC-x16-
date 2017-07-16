;Ioan Bogdan 
;grupa 214/1
;data: 16/01/2017
;Enunt:presupunand ca aveti memorat in segmentul de date
;anul,luna in care v-ati nascut. Cititi de la tastatura
;numele unui fisier. pe baza zilei de nastere, calculati-va varsta
;in ani si in luni si scrieti in fisier varsta.
assume cs:code,ds:data
data segment
	an dw 1997
	luna db 7;rac
	maxFileLen db 15
	fileLen db ?
	fileName db 15 dup(?)
	buffer db 255 dup(?)
	handle dw ?
data ends
code segment
afis10 proc
	;salvam "contextul"
	push ax
	push bx
	push cx
	push dx
	xor dx,dx
	mov bx,10;baza la care impartim
	mov cx,0;contor pentru nr de cifre
	calcul:
		cmp ax,0
		jz magyarorszag
		div bx
		add dx,'0'
		push dx
		mov dx,0
		inc cx
		jmp calcul
	magyarorszag:
		;bagam in buffer
		jcxz final
		pop dx
		mov buffer[si],dl
		inc si
		loop magyarorszag
final:
	inc si
	mov buffer[si],' '
	;refacem "contextul"
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
	lea dx,maxFileLen
	int 21h
	;transformam in asciiz
	xor bx,bx
	mov bl,fileLen
	mov fileName[bx],0
	;deschidem fisierul
	mov ah,3Dh
	mov al,2
	lea dx,fileName
	int 21h
	mov handle,ax ; salvam handle-ul fisierului
	;aflam data curenta
	mov ah,2Ah
	int 21h
	mov bx,an
	sub cx,bx;anul curent - anul de nastere
	cmp dh,luna
	jb scade
	mov ax,cx
	xor si,si ; si va fi index-ul in buffer
	call afis10
	sub dh,luna
	mov ah,0
	mov al,dh
	call afis10
	jmp endIt
	scade:
		dec cx
		mov ax,cx
		xor si,si;index in buffer
		call afis10
		mov al,12
		sub al,luna
		add al,dh
		mov ah,0
		call afis10
		jmp endIt
	endIt:
		;scriem in fisier
		mov ah,40h
		mov bx,handle
		mov cx,10
		lea dx,buffer
		int 21h
		;gata
		mov ax,4c00h
		int 21h
code ends
end start
		
		
	
	