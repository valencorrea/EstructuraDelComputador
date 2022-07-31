! Escribir un programa que lee una palabra de 32 bits entregada por 
! un periférico mapeado en la dirección C2100308h.

! Esta comprende dos números enteros signados en sus 16 bits más 
! altos y en sus 16 bits más bajos respectivamente. 

! El main pasa esta palabra de 32 bits a una rutina vía stack 
! para que se encargue de separar ambos números y devolverlos también a través del stack. 

! El programa principal suma estos dos números y escribe el resultado 
! en el mismo periférico desde donde leyó el valor original y luego termina el programa. 
! El programa principal y la rutina van en el mismo módulo.

.begin
.org 2048

PPIO_PERIFERICO .equ 00000h
FIN_PERIFERICO .equ 010h

	.macro push arg
	add %r14, -4, %r14
	st arg, %r14 
	.endmacro

	.macro pop arg
	ld %r14, arg
	add %r14, 4, %r14	
	.endmacro

main:	sethi PPIO_PERIFERICO, %r1
	sll %r1, 2, %r1
	add %r1, FIN_PERIFERICO, %r1		! guardo la direccion del periferico

	ld %r1, %r2				! leo la palabra y la guardo
	push %r2				! guardo en la pila
	call split_numbers

	pop %r2					! agarro los dos numeros
	pop %r3
	
	add %r2, %r3, %r8			! sumo 
	st %r8, %r1				! guardo en periferico

	jmpl %r15, 4, %r0

split_numbers:	
	add %r2, %r0, %r3			! me hago una copia del numero leido
	
	sll %r2, 16, %r2			
	sra %r2, 16, %r2			! me guardo los 16 menos significativos
	
	sra %r3, 16, %r3			! me guardo los 16 mas significativos

	push %r2
	push %r3				! devuelvo los numeros separados
	
	jmpl %r15, 4, %r0			! vuelvo al main
.end
