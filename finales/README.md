# Indice de finales



### 20210309

Un programa recibe por stack la direccion de inicio de un arreglo de 16 elementos no signados. Debe calcular el promedio de todos los elementos (pares) y comunicar el resultado a un periférico mapeado en la direccion B71300A1h

* a) El promedio debe ser calculado por una subrutina
* b) El promedio debe ser calculado utilizando una macro


### 20210827

Escribir un programa que lee una palabra de 32 bits entregada por un periférico mapeado en la dirección C2100308h, ésta comprende dos números enteros signados en sus 16 bits más altos y en sus 16 bits más bajos respectivamente. El main pasa esta palabra de 32 bits a una rutina vía stack para que se encargue de separar ambos números y devolverlos también a través del stack. El programa principal suma estos dos números y escribe el resultado en el mismo periférico desde donde leyó el valor original y luego termina el programa. El programa principal y la rutina van en el mismo módulo.


### 20220719

Un programa recibe por stack la direccion de un arreglo conformado por numeros enteros en complemento a2 y se encarga de devolver por esa misma via la suma de todos sus elementos positivos de dicho arreglo. Antes de terminar incova una subrutina que escribe un 0 en la direccion A2010B10h en caso de que la suma anterior no sea representable en 32 bits o escribe un 1 en caso contrario

* a) subrutina y main forman parte del mismo modulo 
* b) indicar los cambios necesarios para que la rutina este declarada en un modulo aparte


### sinFecha1

Subrutina que lee datos de la direccion de un periferico que recibe por stack, y devuelve el dato leido por la misma via. Lee de un dato a la vez. Cada dato tiene 32 bits y se compone de dos numeros en complemento a2. El primer numero es de 20 bits y el segundo de 12. Si el de 12 es positivo se guarda en un array de 16 posiciones declarado. El programa termina cuando el array esta lleno.

