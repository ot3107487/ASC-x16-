assume cs:code, ds:data
data segment
	s1 db '+42a8X5'
	s2 db 'a45'
	lgd EQU s2-s1-($-s2)
	d db lgd dup(?)
	lgs1 EQU s2-s1
	lgs2 EQU d-s2-1
	
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,lgd
	mov ah,lgs1
	mov bl,lgs2
	mov ax,4C00h
	int 21h
code ends
end start

	