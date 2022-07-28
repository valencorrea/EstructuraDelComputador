! Alternativa con numero no representable -> prende el flag v

.begin 
	.org 2048

	.macro push arg
	add %r14, -4, %r14
	st arg, %r14
	.endmacro

	.macro pop arg
	ld %r14, arg
	add %r14, 4, %r14
	.endmacro

!PPIO_DIREC .equ A2010h
!FIN_DIREC .equ B10h

PPIO_DIREC .equ 00000h
FIN_DIREC .equ 010h

LARGO .equ 2

	sethi PPIO_DIREC, %r1 			! aca devuelvo si es o no represent
	sll %r1, 2, %r1
	add %r1, FIN_DIREC, %r1
	
	!add LARGO, %r8
	!push 	

	!pop %r2 					! elementos que me faltan del array
	!pop %r3						! proximo elemento a leer
	
	add %r0, 2, %r2
	add %r0, array, %r3 	

	add %r0, %r0, %r6				! suma acumulada
	add %r0, %r0, %r7				! valor a retornar en periferico

loop:	
	subcc %r2, 1, %r2				! me fijo si tengo que seguir iterando
	bneg exit					! salgo si es neg
	ld %r3, %r9					! cargo el valor del elemento actual
	addcc %r9, %r0, %r0
	bneg is_neg 
	addcc %r9, %r6, %r6			! sumo 

is_neg:
	add %r3, 4, %r3
	bvc loop
	add %r0, 1, %r7
	ba loop

exit:
	add %r15, %r0, %r16			! backup
	call representable
	jmpl %r16+4, %r0

representable: 
	st %r7, %r1
	jmpl %r15 + 4, %r0

	.org 3000
array:   5
	 2147483647

	.end
