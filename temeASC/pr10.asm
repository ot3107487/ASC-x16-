assume cs:code ,ds:data
data segment
	a dw 30000
	b dw -30000
	suma dd 0
	zece dw 10
data ends
code segment
afisBaza10 proc
	push ax
	push bx
	push cx
	push dx
	xor cx,cx
	trans:
		cmp ax,0
		jz afisare
		inc cx
		div zece
		add dx,'0'
		push dx
		mov dx,0
		jmp trans
	afisare:
		jcxz final
		pop dx
		mov ah,2
		int 21h
		loop afisare
	final:
	pop dx
	pop cx
	pop bx
	pop ax
ret
endp	
start:
	push data
	pop ds
	mov ax,a
	cmp ax,0
	jl et1
	mov bx,b
	cmp bx,0
	jl et2
	mul bx
	jmp afisarePoz
	et1:
		mov bx,b
		cmp bx,0
		jl sari
		neg ax
		mul bx
		jmp afisareNeg
		sari:
			imul bx
			jmp afisarePoz
		
	et2:
		neg bx
		mul bx
		jmp afisareNeg
	afisarePoz:
		call afisBaza10
		jmp endOfStory
	afisareNeg:
		push ax
		push dx
		mov ah,2
		mov dl,'-'
		int 21h
		pop dx
		pop ax
		call afisBaza10
		jmp endOfStory
	endOfStory:
		mov ax,4c00h
		int 21h
code ends
end start
	
	