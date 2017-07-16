;Ioan Bogdan - Grupa 214/1 - Lab4p1
;1. (a*a-b+7)/(2+a)
;a-byte; b-doubleword
assume cs:code,ds:data
data segment
a db 5
b dd 4
sapte EQU 7 
doi EQU 2
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,a ; al=a=5
	imul a ; ax=a*a= 25
	add ax,sapte ; ax=a*a+7=32
	cwd ; ax->dx:ax
	sub dx,word ptr b+2  
	sub ax,word ptr b ; dx:ax-=b = a*a-b+7=28
	mov bl,a ; bl=a=5
	add bl,doi ; bl=a+2=7
	idiv bx
	mov ax,4C00h
	int 21h
code ends
end start