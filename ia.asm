;nome: Rafael de Souza Teixeira

setDifficult proc
	mov dh, 8
	call clearScreen
	mov dh, 4
	mov dl, 5
	mov bp, offset selectdif
	call printString
	
	inc dh
	mov bp, offset easyDif
	call printString
	
	inc dh
	mov bp, offset mediumDif
	call printString
	
	inc dh
	mov bp, offset HardDif
	call printString
	
	mov ah, 00h
	int 16h
	
	sub al, 48
	
	mul iaMax
	mov iaMax, al
	
	ret
	setDifficult endp

calcTecla proc
	reset:
	mov ah, 2ch
	int 21h

	divBySub:
		cmp dl, 9
		jl endDivBySub
		
		sub dl, 9
		jmp divBySub
	endDivBySub:
	
	mov al, dl
	
	add al, 49
	cmp al, '5'
	je reset
		
	mov bx, 14h		
	duraT:
		mov cx, 0ffffh
	duraTC:
		dec cx
		jne duraTC
		dec bx
		jne duraT

	ret
	calcTecla endp

selectdif db 'Difficult:$'
easyDif db '1. Easy$'
mediumDif db '2. Medium$'
HardDif db '3. Hard$'