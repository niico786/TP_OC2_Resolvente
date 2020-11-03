#include <stdio.h>
#include <stdlib.h>

extern void resolvente(float a,float b,float c);

int main() {
	
	float a;
    float b;
    float c;

    //Solicito los coeficientes al usuario
	printf("Ingrese coeficiente A: ");
    scanf("%f", &a);

	printf("Ingrese coeficiente B: ");
    scanf("%f", &b);

	printf("Ingrese coeficiente C: ");
    scanf("%f", &c);

	//Llamada a la funcion de assembler 
	resolvente(a,b,c);

	return 0;
}
