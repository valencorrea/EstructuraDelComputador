! Un programa declara un arreglo de 32 palabras de 32 bits y carga en el las primeras 32 lecturas de un
! periferico que esta mapeado en la direccion C3101200h. 

! Una vez finalizada esta tarea invoca una subrutina que calcula su promedio.

! El programa principal devuelve el promedio por stack y termina.

! Los valores entregados por el dispositivo estan representados en a2.

! La rutina, que debe ser declarada en el mismo modulo que el programa ppal,
! recibe por stack la direccion del arreglo (el largo es siempre de 32 elementos)
! y devuelve tambien por stack el promedio calculado. 

! En caso de excederse el rango de representacion devuelve un 0

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

PPIO_PERIFERICO .equ 00000h
FIN_PERIFERICO .equ 010h


main:                                    
	sethi PPIO_PERIFERICO, %r1               
	sll %r1, 2, %r1            
	add %r1, FIN_PERIFERICO, %r1           ! guardo la direccion del periferico
                                                                             
	add %r0, 2, %r2            ! tope de lecturas
	add %r0, array, %r3           ! guardo la direccion del array
	add %r0, %r0, %r4          ! inicializo valor del promedio
	add %r0, array, %r6           ! me hago una copia de la direccion del array
	add %r0, %r0, %r7          ! inicializo registro para verificar overflow
                                                                             
loop_lectura:                             
	subcc %r2, 1, %r2          ! me fijo si tengo que seguir recorriendo elementos
	bneg exit_loop             ! termine de leer
                                                                             
	ld %r1, %r8                ! cargo valor del elemento del periferico
	st %r8, %r3                ! guardo en la direccion del array el elemento
	add %r3, 4, %r3            ! avanzo al sig elemento del vector	
	ba loop_lectura                      
                                                                             
	push %r4                   ! devuelvo el promedio         
	jmpl %r15, 4, %r0          
                                                                             
	exit_loop:                               
		push %r6                   ! mando direccion del arreglo             
		add %r15, %r0, %r16        ! backup del pc
		call calcular_promedio                    
                                                                             
	calcular_promedio:                             
		pop %r6                    ! agarro direc del arreglo        
		add %r0, 2, %r2            ! vuelvo a setear el tope del array	
                                                                             
	loop_promedio:                             
		subcc %r2, 1, %r2          ! tengo que seguir iterando?
		bneg fin_del_programa                     
		ld %r6, %r8                ! me guardo el elemento actual en r8
		addcc %r8, %r4, %r4        ! sumo los elementos en el acumulador del promedio
		bvc entra_en_rango         ! no excedio limite		
		add %r7, 1, %r7            ! aviso que hubo overflow
                                                                             
	entra_en_rango:                             
		add %r6, 4, %r6            ! avanzo de posicion en el vector 
		ba loop_promedio                      
                                                                             
	fin_del_programa:                             
		sra %r4, 1, %r4            ! divido por 2
                                                                             
                                                                             
		subcc %r0, %r7, %r0        ! seteo flags
		be sin_overflow                       ! si son iguales es porque nunca setee el 1 del overflow 
		add %r0, %r0, %r4          ! devuelvo 0 porque hubo overflow
                                                                             
	sin_overflow:                             
		push %r4                                
		jmpl %r16, 4, %r0          
                                                                             
.org 48                    ! = 00000030h
array:        .dwb 2                    
.end
 
                                                                         