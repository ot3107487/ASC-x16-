;a+b/c -d*2
;a- doubleword
;b,d-byte
;c- word
assume cs:code,ds:data
data segment
	a dd 125 
	b db 2
	d db 15
	c dw 200
	doi EQU 2 ; eticheta 2 are valoarea 2
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,b ; al=b
	cbw ;  ax=al=b sau mov ah,0
	cwd ; dx:ax = ax=b sau mov dx,0
	idiv c ; ax =dx:ax/c=b/c si dx=dx:ax%c
	mov bx,ax ; bx=ax= b/c
	mov al,d ; al =d
	mov al,doi ;al=2
	imul d ; ax= 2 * d
	sub bx,ax ; bx = bx-ax = b/c - d*2
	mov ax,bx ; ax=bx=b/c-d*2 
	cwd ; dx:ax=b/c-d*2
	mov bx,word ptr a
	mov cx,word ptr a+2
	add ax,bx ; ax=ax+bx
	adc dx,cx ; dx= dx + cx + CF
	; dx:ax = a+b/c-d*2
	mov ax,4C00h
	int 21h
code ends
end start