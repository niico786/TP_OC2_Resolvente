extern printf
global resolvente

section .data

;Variable -B 
varBNeg dd 0.0

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
raiz1 dq 0.0 

;Variable final de la raiz 2
raiz2 dq 0.0 

;Constantes
constante4 dd 4.0
constante2 dd 2.0

formato db "Raiz 1: %.2f; Raiz 2: %.2f  ", 10,13,0

section .text 
 
resolvente:
    push ebp 
    mov ebp, esp  
    
    ;Invierto el signo de la variable B, almacenado en ebp + 12
    FLD dword[EBP+12]
    FCHS 
    FSTP dword[varBNeg] 
    
    ;Calculo B al cuadrado utilizando la pila para multiplicar por si mismo el valor B (ebp+12)
    FLD dword[EBP+12]
    FLD dword[EBP+12]
    FMUL 
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
    FSUB 
    FSQRT
    FSTP dword[varRaizBResto4AC] 
    
    ;Calculo el fragmento -B + raiz de (BCuadrado - 4*A*C), y almaceno el resultado en varSuma
    FLD dword[varBNeg] 
    FLD dword[varRaizBResto4AC]
    FADD
    FSTP dword[varSuma] 
    
    ;Calculo el fragmento -B - raiz de (BCuadrado - 4*A*C), y almaceno el resultado en varResta
    FLD dword[varBNeg]
    FLD dword[varRaizBResto4AC] 
    FSUB 
    FSTP dword[varResta] 
    
    ;Realizo la divison del fragmento -B + raiz de (BCuadrado - 4*A*C) / 2*A, y obtengo finalmente la raiz 1
    FLD dword[varSuma]
    FLD dword[var2A] 
    FDIV 
    FSTP qword[raiz1]
    
    ;Realizo la divison del fragmento -B - raiz de (BCuadrado - 4*A*C) / 2*A, y obtengo finalmente la raiz 2
    FLD dword[varResta]
    FLD dword[var2A] 
    FDIV 
    FSTP qword[raiz2] 
    
    ;Paso a la pila los valores de pila de forma en que las reciba la llamada a la funcion printf como parametros a imprimir mas el formato de salida.
    push dword[raiz2+4]
    push dword[raiz2]
    push dword[raiz1+4]
    push dword[raiz1]
    push formato
    call printf 
    add esp,20  ;Se debe incrementar el puntero de esp ya que realice el push de 5 variables dword por lo que debo aumentar en 5 bytes el registro.
    
    ;Libero los registros para finalizar
    mov ebp,esp 
    pop ebp 
    
    ret
