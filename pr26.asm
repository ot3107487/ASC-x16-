assume ds:data,cs:code
data segment
	a db 5 ; atribuim lui a valoare 5
	d db 8 ; atribuim lui d valoarea 8
	b dw 15 ; atribuim lui b valoare 15
	c dw 19 ;atribuim lui c valoare 19
	e dw ? ; rezultatul operatie
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,a ; al = a
	mul d ; al = al *d
	mov bx,ax ; bx=ax
	mov ax,b ; ax = b
	add bx,ax ; bx= bx + ax
	sub bx,c ; bx= bx-c
	mov e,bx ; e= bx
mov ax,4C00h
int 21h
code ends
end start