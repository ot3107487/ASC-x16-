assume cs:code,ds:data
data segment
	s db 'a','v','x','a','c'
	l EQU $-s
	d db l dup(?)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov cx,l
	mov si,0
	jcxz Sfarsit
	Repeta:
	mov al,byte ptr s[si]
	sub al,'a'-'A'
	mov byte ptr d[si],al
	inc si
	loop repeta
	Sfarsit:
		mov ax,4C00h
		int 21h
		code ends
		end start
	