;Ioan Bogdan Lab7p4 Grupa 214/1
assume cs:code, ds:data
data segment
	s db 1,2,4,6,10,20,25 ;s- string (sir de caractere)
	l EQU $-s ; l - lungimea sirului s 
	d db l-1 dup(?) ; d - string cu lungimea l-1 (rezultatul)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov cx,l-1 ; cx=l-1=6-1=5 (cred)
	mov si,0 ; si=0 (indicele lui d)
	jcxz Sfarsit ; cand cx devine 0 , sare la sfarsit
	Repeta: ; eticheta 
		mov al,byte ptr s[si+1] ;al= 2(pentru prima tura)
		sub al,byte ptr s[si] ; al=al-1 = 1
		mov byte ptr d[si],al ; d[0]=1
		inc si ; si=si+1=1
		loop Repeta ; repeta Repetea
	Sfarsit: ; eticheta 
		mov ax,4C00h
		int 21h
		code ends
		end start