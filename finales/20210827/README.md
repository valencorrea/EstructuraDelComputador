# 27 de Agosto 2021

Escribir un programa que lee una palabra de 32 bits entregada por un periférico mapeado en la dirección C2100308h, ésta comprende dos números enteros signados en sus 16 bits más altos y en sus 16 bits más bajos respectivamente. El main pasa esta palabra de 32 bits a una rutina vía stack para que se encargue de separar ambos números y devolverlos también a través del stack. El programa principal suma estos dos números y escribe el resultado en el mismo periférico desde donde leyó el valor original y luego termina el programa. El programa principal y la rutina van en el mismo módulo.

