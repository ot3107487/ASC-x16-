;Ioan Bogdan , Grupa 214/1 , Lab4p2 cu semn
;Scrieti 2 programe in limbaj de asamblare care sa rezolve una 
;dintre urmatoarele expresii aritmetice in interpretarea cu semn
; si respectiv in interpretarea fara semn, tipul variabilelor fiind specificat.
;2/(a+b*c-9)+d
;a,b,c-byte; d-doubleword
assume cs:code,ds:data
data segment
	a db 5;a=5
	b db 4;b=4
	c db 3;c=3
	d dd 10;d=10
	doi EQU 2; doi=2 (eticheta)
	noua EQU 9; noua=9(eticheta)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,b ;al=b
	imul c; al=b*c
	add al,a;ax+=a=b*c+a
	sub al,noua; ax=ax-9=a+b*c-9
	mov bx,ax
	mov ax,doi;ax=doi
	cwd ; convert word to doubleword ax -> dx:ax
	idiv bx ; dx:ax/bx=2/(a+b*c-9)
	mov bx,word PTR d ; pune in bx ultimele 16 cifre ale lui d
	mov cx,word PTR d+2 ; pune in cx primele 16 cifre ale lui d
	add ax,bx ; ax=ax+bx
	adc dx,cx ; dx=dx+cx+CF
	mov ax,4C00h
	int 21h
code ends
end start 
