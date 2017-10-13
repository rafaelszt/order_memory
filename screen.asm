;nome: Rafael de Souza Teixeira

printChar proc
	mov ah, 02h 
    int 10h
	
    mov cx, 1h 
    mov ah, 09h 
    int 10h
	
    ret
    printChar endp

printString proc
	mov al, 00h
	mov bl, 0fh
	mov cx, 0
	
	mov si, bp
	sizeString:
		cmp byte ptr [si], '$'
		je fimSizeString
		
		inc cx
		inc si
		jmp sizeString
	fimSizeString:

	mov ah, 13h
	int 10h
	
	ret
	printString endp

clearScreen proc
	mov bh, 00h
	mov ah, 06h 
	mov al, 00h 
	mov ch, 2 
	mov cl ,2
	mov dl, 16
	int 10h	
	
	ret
	clearScreen endp

incChar macro
	inc bl
	inc al
	call printChar
	endm

printScreen proc
	mov [ds:899h], al 

	mov dh, 8
	call clearScreen	
    	
	mov dl, 9 
	mov dh, 3 
	mov bl, 09h 
	mov al, 41h 
	
	call printChar
	add dl, 4
	incChar
	
	add dh, 2
	incChar
	
	add dh, 2
	incChar
	
	mov bl, 08h
	sub dl, 4
	incChar
	
	sub dl, 4
	incChar
	
	sub dh, 2
	incChar
	
	sub dh, 2
	incChar
	
	mov al, [ds:899h] 
    ret
	printScreen endp	

makeFrame proc
	mov bx, 01h 	
	mov al, 178 
	mov bl, 08h 
	mov dh, 0
	mov dl, 0
	
	startPrint:
		cmp dl, maxTop
		je next1
		
		call printChar
		inc dl
		jmp startPrint
		
		next1:
		cmp dh, maxBottom
		je next2
		
		call printChar
		inc dh
		jmp next1
		
		next2:
		cmp dl, minBottom
		je next3
		
		call printChar
		dec dl
		jmp next2
		
		next3:
		cmp dh, minTop
		je next4
				
		call printChar
		dec dh
		jmp next3
	
		next4:
		cmp minTop, 1
		je endPrint
		
		inc minBottom
		inc minTop
		dec maxTop
		dec maxBottom
		dec bl
		mov dl, minBottom
		mov dh, minTop
		
		jmp startPrint
	endPrint:

	ret
	makeFrame endp

mainMenu proc   
	mov	dh, 4
	mov dl, 6
	mov bp, offset gameName1 
	call printString
	
	inc dl
	inc dh
	mov bp, offset gameName2
	call printString
	
	inc dl
	inc dh
	mov bp, offset gameName3
	call printString
	
	add dh, 2
	mov dl, 4
	mov bp, offset pressPlay	
	call printString
	
	ret	
	mainMenu endp

endGame proc
	mov dh, 9
    call clearScreen
	
	mov dh,  6
	mov dl, 5
	mov bp, offset youLose
	call printString
	
	mov ah, 00h 
	int 16h	
	
	ret
	endGame endp

start proc
	mov ah, 00h 
	mov al, 13h
    int 10h
	
    mov ch, 010000b	
    mov ah, 01h
    int 10h
	
	ret
	start endp

gameName1 db 'Ordem$'
gameName2 db '###$'
gameName3 db 'Memory$'

pressPlay db 'Press ENTER$'
youLose db 'You Lose!$'

maxTop db 18
maxBottom db 11
minTop db 0
minBottom db 0
