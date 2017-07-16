;Ioan Bogdan, Grupa 214/1 , Lab3p12
;Scrieti un program in limbaj de asamblare care sa rezolve expresia aritmetica, 
;considerand domeniile de definitie ale variabilelor.
;a-[0,128], b-[32,64], c-[16,192], d-[17,41]
;(b+b)+(c-a)+d
assume cs:code,ds:data
data segment
	a db 30 ; atribuim lui a val 30
	b db 40 ; atribuim lui b val 40
	c db 84 ; atribuim lui c val 84
	d db 25 ; atribuim lui d val 25
	e dw ? ; e va fi valoare finala
data ends
code segment
start:
	mov ax,data ;chestie care trebuie scrisa 
	mov ds,ax ;alta chestie care trebuie scrisa
	mov al,b ;al=b
	cbw ;convert byte to word
	add al,b ;al+=b
	mov bx,ax ;bx=ax
	mov al,c ;al=c
	sub al,a ;al-a
	add bx,ax ;bx+=ax
	mov al,d ;al=d
	add bx,ax ;bx+=ax
	mov e,bx ; e=bx
mov ax,4C00h
int 21h
code ends
end start
	
	
 