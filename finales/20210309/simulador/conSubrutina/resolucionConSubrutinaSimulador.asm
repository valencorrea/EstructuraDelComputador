! Un programa recibe por stack la direccion de inicio de un arreglo 
! de 16 elementos no signados. 

! Debe calcular el promedio de todos los elementos (pares) y 
! comunicar el resultado a un periférico mapeado en la direccion B71300A1h

! a) El promedio debe ser calculado por una subrutina
! b) El promedio debe ser calculado utilizando una macro

	.begin
	.org 2048

	.macro pop arg
	ld %r14, arg
	add %r14, 4, %r14
	.endmacro

PPIO_PERIFERICO .equ B7130h
FIN_PERIFERICO .equ 0A1h

	sethi PPIO_PERIFERICO, %r4
	sll %r4, 2, %r4	
	add %r4, FIN_PERIFERICO, %r4	! guardo la direccion del periferico
	
	!pop %r1			! guardo direccion del arreglo
	add %r0, array, %r1		! me guardo la direc del arreglo	


	add %r0, 2, %r2	! guardo la cantidad de elementos del vector
	add %r0, %r0, %r3	! inicializo donde voy a ir calculando el promedio

loop: 	
	subcc %r2, 1, %r2	! me fijo si puedo seguir recorriendo el vector
	bneg exit			! ya recorri todo el vector (be equals)
	
	ld %r1, %r6		! guardo el valor del elemento actual
	add %r6, %r3, %r3	! sumo el elemento actual a donde voy a calcular el promedio
	
	add %r1, 4, %r1		! avanzo a la siguiente posicion del vector
	ba loop			! avanzo el loop al siguiente elemento

exit:
	call calcular_promedio	! llamo a calcular el promedio por subrutina despues de que termino el loop	
	st %r3, %r4		! guardo el promedio en la direccion del periferico

calcular_promedio:	
			srl %r3, 1, %r3		! divido por el total de elementos del vector
			jmpl %r15, 4, %r0	! vuelvo a la linea siguiente del llamado

	.org 3000
array:   5
	 4
	

	.end
