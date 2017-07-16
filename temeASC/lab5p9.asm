;Ioan Bogdan - Grupa 214/1 - Lab5prob9
;9. Se de cuvantul A si octetul B. Sa se obtina octetul C astfel:
;- bitii 0-3 ai lui C coincid cu bitii 6-9 ai lui A
;- bitii 4-5 ai lui C au valoatrea 1
;- bitii 6-7 ai lui C coincid cu bitii 1-2 ai lui B
assume cs:code,ds:data
data segment
	A dw 1000111100000000b
	B db 11110110b
	C db ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov al,00000000b ; in al calculam rezultatul
	shr A,6 ; A=0000001000111100b
	mov bx,A ; bx=0000001000111100b
	and bx,0000000000001111b ; izolam primii 4 biti
	or al,bl ; al = 00001100b
	or al,00110000b ; al=00111100b
	shr B,1 ; B=01111011
	shl B,6 ; B=11000000b
	mov bl,b ; bl = b= 00000000b
	or al,bl ; al=00111100b
	mov ax,4C00h
	int 21h
code ends
end start