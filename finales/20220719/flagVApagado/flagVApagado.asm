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

add %r0, %r0, %r5					! cantidad de guardados
add %r0, 16, %r6					! cant max vector
add %r0, %r0, %r7					! indice de la posicion actual del vector

	pop %r1						! guardo la direc del periferico

loop:
	subcc %r6, %r5, %r0					! sigo teniendo lugar
	be exit						! se prende cuando es 0
	ld %r1, %r2					! me guardo el valor del periferico 
! asumimos que se va actualizando solo	
	
	sra %r2, 12, %r3					! me guardo las A
	
sla %r2, 20, %r4
sra %r4, 20, %r4					! me guardo las B	

	addcc %r4, %r0, %r0				! seteamos flags para el numero de 12
	bneg loop
	ld [array + %r7], %r4					! guardo el valor positivo
	add %r7, 4, %r7					! avanzo de posicion
	add %r5, 1, %r5					! aumento los guardados
	ba loop

exit:
jmpl %r15, 4, %r0	

.org 3000
array:	.dwb 16	

	.end
