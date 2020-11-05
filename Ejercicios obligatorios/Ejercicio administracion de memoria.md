**Ejercicio 4:**

* C: 
    Como tengo paginas de 4KB entonces -> 2^2 * 1k
                                          2^2 * 2^10
                                          2^12
    Entonces el formato de direcciones logicas es: <20,12> (32 bits).
    Luego con estos datos se que la tabla tiene 2^20 => 1048576 entradas posibles en el esquema de 1 solo nivel.

* D:
    Para el esquema de paginacion invertido se que tengo 1GB de memoria fisica => 2^30. Es decir que se manejan direcciones fisicas de 30 bits. El formato de direcciones fisicas entonces es <18,12>, con este dato tenemos entonces que : 
    2^18 => 262144 entradas posibles para el esquema de direccion invertida.

**Ejercicio 6:**

* A- Para la direccion logica 0 para el DS:
    Su direccion fisica es: base 500 + offset 0 => 500

* B- Para la direccion logica 550 para el CS:
    Su direccion fisica es: base 1000 + offset 550 => 1550

* C- Para la direccion logica 100 para el SS:
    Su direccion fisica es: base 4000 + offset 100 => 4100

* D- Para la direccion logica 4000 para el WS:
    Su direccion fisica es: base 4000 + offset 4000 => 8000
    Esta direccion fisica es invalida ya que supera el limite (200) del proceso, por lo que arrojaria un trap en el sistema.

**Ejercicio 7:**

* CICLO A:

* TLB:

Pagina | Frame | Tiempo
------------ |------------ | -------------
4 | 3 | 0
5 | 4 | 1

* Tabla de paginas 

Pagina | Frame | Valid | Tiempo
------------ |------------ | ------------- | ------------
1 | 1 | v | 1 
2 | 2 | v | 0 
3 | - | I | - 
4 | 3 | v | 2 
5 | 4 | V | 3
6 | - | I | - 

* Memoria pŕincipal 

Frame 1 | Frame 2 | Frame 3 | Frame 4
------------ |------------ | ------------- | ------------
pagina 1 | pagina 2 | pagina 4 | pagina 5 

* Backin store

pagina 3 | pagina 6 
------------ |------------ 

* CICLO B:

* TLB:

Pagina | Frame | Tiempo
------------ |------------ | -------------
4 | 1 | 0
6 | 4 | 1

* Tabla de paginas 

Pagina | Frame | Valid | Tiempo
------------ |------------ | ------------- | ------------
1 | - | I | - 
2 | 2 | v | 0 
3 | - | I | - 
4 | 1 | v | 1 
5 | 3 | V | 2
6 | 4 | V | 3 

* Memoria pŕincipal 

Frame 1 | Frame 2 | Frame 3 | Frame 4
------------ |------------ | ------------- | ------------
pagina 4 | pagina 2 | pagina 5 | pagina 6 

* Backin store

pagina 1 | pagina 3 
------------ |------------ 