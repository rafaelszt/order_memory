;nome: Rafael de Souza Teixeira

cod		segment
			assume cs:cod, ds:cod, es:cod, ss:cod
	org 100h
	

main proc
	call start 
	call makeFrame
	call mainMenu
	
	mov ah, 00h 
	int 16h
	
	call setDifficult
	call printScreen
	
enq:	
	cmp player, 0
	je ia
		call clearBuffer
		mov	dh, 9
		mov dl, 6
		mov bp, offset turnPlayer
		call printString
		
		inc toques
		mov dl, toques
		
		cmp dl, iaMax
		je fimPlayer
		
		mov ah, 00h
		int 16h		
		
		cmp al, 1bh
		je cont

		mov bx, endComp
		cmp byte ptr [bx], al 
		jne perdeu
		
		inc endComp
	
		jmp cont
		
		perdeu:
			call endGame
			mov al, 1bh
			jmp cont
    ia:
		mov	dh, 9
		mov dl, 6
		mov bp, offset turnComp 
		call printString
		
		call calcTecla
		
		
		mov bx, endComp
		mov [bx], al
		inc endComp
				
		inc toques
		mov dl, toques
		cmp dl, iaMax
		je fimIA
		
		jmp cont
	fimIA:
		call printScreen
		mov endComp, 900h
		inc player
		mov toques, 0
		jmp enq
	fimPlayer:
		call printScreen
		mov endComp, 900h
		inc iaMax
		mov toques, 0
		dec player
		jmp enq
	
	cont:
    call printScreen 

	 
    mov dh, 3 
	cmp al, '7'
		je keyH
	cmp al, '8'
		je keyA
	cmp al, '9'
		je keyB
	jmp switch1
	
	keyH:
		mov ax, 2415
		call play
		mov bl, 07h
		mov al, 'H'
		mov dl, 5 
		call printChar
		JMP enq	
    keyA:
		mov ax, 4560 
		call play
		mov bl, 07h
		mov al, 'A'
		mov dl, 9
		call printChar
		JMP enq
	keyB:
		mov ax, 4063
		call play
		mov bl, 07h
		mov al, 'B'
		mov dl, 13
		call printChar
		JMP enq
	
	switch1:
	mov dh, 5 
	cmp al, '6'
		je keyC
	cmp al, '4'
		je keyG
    jmp switch2
	
	keyC:
		mov ax, 3619
		call play
		mov bl, 07h
		mov al, 'C'
		mov dl, 13
		call printChar
		JMP enq
	keyG:
		mov ax, 2415
		call play
		mov bl, 07h
		mov al, 'G'
		mov dl, 5
		call printChar
		JMP enq	
		
	switch2:
	mov dh, 7 
	cmp al, '3'
		je keyD
	cmp al, '2'
		je keyE
	cmp al, '1'
		je keyF
	jmp switch3
		
	keyD:
		mov ax, 3416
		call play
		mov bl, 07h
		mov al, 'D'
		mov dl, 13
		call printChar
		JMP enq
	keyE:	
		mov ax, 3043
		call play
		mov bl, 07h
		mov al, 'E'
		mov dl, 9
		call printChar
		JMP enq
	keyF:
		mov ax, 2711
		call play
		mov bl, 07h
		mov al, 'F'
		mov dl, 5
		call printChar
		JMP enq
		
	switch3:
	cmp al, 1bh
	    je fim
	
	dec toques
    jmp enq
    
	fim:
		mov ah, 06h 
		mov al, 00h 
		mov ch, 0 
		mov cl ,0
		mov dh, 11 
		mov dl, 18
		int 10h	
		ret
	
main endp

include screen.asm	
include ia.asm

clearBuffer proc
	mov ah, 01h
	int 16h

	jz bufferClean
	mov ah, 00h
	int 16h
	call clearBuffer

	bufferClean:

	ret
	clearBuffer endp

play proc
	mov al, 182
	out 43h, al 

	out 42h, al 
	mov al, ah
	out 42h, al 
	in al, 61h 

	or al, 00000011b 
	out 61h, al 
	mov bx, 5h 
	dura:
		mov cx, 0ffffh
	durac:
		dec cx
		jne durac
		dec bx
		jne dura
	
		in al, 61h 
		and al, 11111100b 
		out 61h, al 
	ret
	play endp

turnPlayer db 'Player $'
turnComp db 'Machine$'

player db 0
iaMax db 2
toques db 0

endComp dw 900h

cod ends
	end main