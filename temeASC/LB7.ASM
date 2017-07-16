;Ioan Bogdan Lab7p11 Grupa 214/1
assume cs:code,ds:data
data segment
	s dd 12345678h,1A2B3C4Dh,0FE98DC76h
	l EQU ($-s)/4 ; l=3
	d db l dup(?)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov es,ax
	mov cx,l ; cx=l
	cld ; df=0
	mov bx,offset s  ; bx=0
	inc bx ;bx=1
	mov si,bx ; si =1
	mov di,offset d ; di=0
	jcxz Sfarsit
	Program:
		LODSB ;al=s[si]
		mov AH,0 ; ah=0
		mov bl,10 ; bl=10
		mov dl,al ; dl=al=s[si]
		div bl ; ax/bl;
		cmp AH,0 ; =ah-0
		je Mergi ; daca ah=0 salt la mergi
		inc si ; si++
		inc si ; si++
		inc si ; si++
		loop Program ; repeta et Program
		Mergi:
			mov al,dl ; al = dl = s[si]
			STOSB ; d[di]=al
			inc si ;si++
			inc si ; si++
			inc si ; si++
		loop Program
	Sfarsit:
		mov ax,4C00h
		int 21h
		code ends
		end start