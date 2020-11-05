extern printf
global resolvente

;Section data donde se almacenan variablea inicializadas a utilizar en el programa.
section .data

;Variable -B 
varBNeg dd 0.0 ;Variable Dword de 32 bits inicializada en 0, que luego sera reemplazada en momento de ejecucion

;Variable B Al cuadrado 
varBCuadrado dd 0.0 

;Variable 4 * A * C
var4AC dd 0.0 

;Variable 2 *A
var2A dd 0.0 

;Variable raiz de (B - 4 * A * C)
varRaizBResto4AC dd 0.0 

;Variable resultado -B + raiz de (B - 4 * A * C)
varSuma dd 0.0 

;Variable resultado -B - raiz de (B - 4 * A * C)
varResta dd 0.0

;Variable final de la raiz 1
raiz1 dq 0.0  ;Varialbe quad word de 64 bits, donde almaceno los resultados finales de las raices.

;Variable final de la raiz 2
raiz2 dq 0.0 

;Constantes
constante4 dd 4.0 ;Constatntes dword de 32 bits que no son alterados en la ejecucion del programa.
constante2 dd 2.0

formato db "Raiz 1: %.2f; Raiz 2: %.2f  ", 10,13,0 ;Variable de 1 byte para formatear el output de salida de los resultados

section .text 
 
resolvente:
    ;Muevo a la pila al registro ebp y copio el valor de esp en ebp para comenzar la ejecucion.
    push ebp 
    mov ebp, esp  
    
    ;Invierto el signo de la variable B, almacenado en ebp + 12
    FLD dword[EBP+12] ;Float load data, almacena el valor float del registro indicado en la pila. EBP+12 es el modo de direccionamiento para acceder a la constante del registro almacenada en ella.
    FCHS ;Float change sign, alterna el valor que lee desde la pila.
    FSTP dword[varBNeg] ;Float store and pop, almacena el valor del registro indicado y realiza un pop de la pila para despejar espacio.
    
    ;Calculo B al cuadrado utilizando la pila para multiplicar por si mismo el valor B (ebp+12)
    FLD dword[EBP+12]
    FLD dword[EBP+12]
    FMUL ;Float multiplicate, multiplica los valores float que tenga sobre la pila.
    FSTP dword[varBCuadrado]
    
    ;Clculo el fragmento de la resolvente 4*A*C, utilizo A (ebp+8) y C(ebp+16)
    FLD dword[constante4] 
    FLD dword[EBP+8]
    FMUL 
    FLD dword[EBP+16] 
    FMUL 
    FSTP dword[var4AC]  
    
    ;Calculo el fragmento 2*A y almaceno el resultado en var2A
    FLD dword[constante2] 
    FLD dword[EBP+8]
    FMUL 
    FSTP dword[var2A] 
    
    ;Calculo el fragmento (B al cuadrado) - (4*A*C), y a su resultado le aplico la raiz cuadrada, luego almaceno el resultado en la variable varBResto4AC  
    FLD dword[varBCuadrado]    
    FLD dword[var4AC]    
    FSUB ;Float substraction, realiza una resta entre los operandos que lea desde la pila.
    FSQRT ;Float square root, aplica la raiz cuadrada al valor float que lea desde la pila
    FSTP dword[varRaizBResto4AC] 
    
    ;Calculo el fragmento -B + raiz de (BCuadrado - 4*A*C), y almaceno el resultado en varSuma
    FLD dword[varBNeg] 
    FLD dword[varRaizBResto4AC]
    FADD ;Float add, suma dos variables float que lee desde la pila
    FSTP dword[varSuma] 
    
    ;Calculo el fragmento -B - raiz de (BCuadrado - 4*A*C), y almaceno el resultado en varResta
    FLD dword[varBNeg]
    FLD dword[varRaizBResto4AC] 
    FSUB 
    FSTP dword[varResta] 
    
    ;Realizo la divison del fragmento -B + raiz de (BCuadrado - 4*A*C) / 2*A, y obtengo finalmente la raiz 1
    FLD dword[varSuma]
    FLD dword[var2A] 
    FDIV ;Float divison, realiza una divison de los parametros float que lea desde la pila.
    FSTP qword[raiz1]
    
    ;Realizo la divison del fragmento -B - raiz de (BCuadrado - 4*A*C) / 2*A, y obtengo finalmente la raiz 2
    FLD dword[varResta]
    FLD dword[var2A] 
    FDIV 
    FSTP qword[raiz2] 
    
    ;Paso a la pila los valores de las raices de forma en que las reciba la llamada a la funcion printf como parametros a imprimir mas el formato de salida.
    push dword[raiz2+4] ;Apilo la variable en dos partes para parsear el tamaño del quad word.
    push dword[raiz2]
    push dword[raiz1+4]
    push dword[raiz1]
    push formato
    call printf ;Invoco la funcion externa printf
    add esp,20  ;Se debe incrementar el puntero de esp lo correspondiente a los 5 dword que se transfirieron a la pila.
    
    ;Libero los registros para finalizar
    mov ebp,esp 
    pop ebp 
    
    ;Retorno el programa para continuar su ejecucion desde la llamada del programa en C.
    ret