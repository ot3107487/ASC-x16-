assume ds:data,cs:code
data segment
a db 78 ; a = 78
b db 35 ; b = 35
d db 30 ; d = 30
e db ? ; e - variabila in care retinem rezultatul
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,a ; al = a
	add al,b ; al=al+d
	sub al,d ; al=al-d	
	mov bl,al ;bl - al
	mov al,a ;al=a
	sub al,b ;al=al-b
	sub al,d ;al=al-d
	add al,bl ;al=al+bl
	mov bl,al
	mov e,al ;e=al
	mov ax,4C00h
	int 21h
code ends
end start