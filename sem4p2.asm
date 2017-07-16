;2/(a+b*c-9)+d
assume cs:code,ds:data
data segment
	a db 25 ; atribuim lu a valoarea 25
	b db 4 ; atribuim lui b valoarea 4
	c db 15 ; atribuim lui c valoarea 15
	d dd 20 ; atribuim lui d valoare 20
	doi EQU 2 ; eticheta doi = 2
	noua EQU 9 ; eticheta noua=9
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,b ; al=b
	imul c ; al=al*c=b*c
	add al,a ; ax= ax+a = b*c+a
	sub al,noua ; ax=ax-c= a+b*c-9
	mov bx,ax ; bx=ax
	mov al,doi ; dx:ax=2
	cbw
	cwd
	idiv bx ; ax=dx:ax/bx si dx=dx:ax%bx
	mov bx,word ptr d ; bx= primele cifre din d
	mov cx,word ptr d+2 ; cx= ultimele cifre din d
	add ax,bx ; ax=ax+bx
	adc dx,cx ; dx=dx+cx +CF
	mov ax,4C00h
	int 21h
code ends
end start