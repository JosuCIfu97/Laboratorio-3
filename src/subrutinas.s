/*------------------------------------------------------------------------
*Universidad del Valle de Guatemala
*Taller de Assembler
*Secci�n 21
*Josu� Cifuentes #15275
*Pablo Mu�oz #15258
*13/10/16
*Subrutinas necesarias para validaciones en el juego.
*subrutinas.s
------------------------------------------------------------------------*/

.global paint, buttonPressed

/*Subrutina paint:
*Pinta una imagen en pantalla
*Par�metros:
*r0 <- direcci�n virtual de monitor
*r1 <- posici�n inicial en x
*r2 <- posici�n inicial en y
*r3 <- direcci�n inicial de vector con colores de imagen
*r4 <- ancho de la imagen
*r5 <- altura de la imagen
*Salida: Coloreado en monitor*/
paint:
	mov r6,r0 @Direcci�n de monitor
	mov r7,r1 @Posici�n inicial en x
	mov r8,r2 @Posici�n inicial en y
	mov r9,r3 @Vector de colores
	mov r10,#0 @Contador de columnas
	mov r11,#0 @Contador de filas
fory:
	cmp r11,r5 @Compara altura imagen con contador de filas pintadas
	movge pc,lr
	add r8,#1 @Se le suma uno a la posici�n en y
	add r11,#1 @Se le suma uno al contador de filas
forx:
	mov r0,r6 @Direcci�n de monitor
	mov r1,r7 @Posici�n inicial en x
	mov r2,r8 @Posici�n inicial en y
	ldrb r3,[r9],#1 @Color de dicha posici�n y avanza al siguiente byte
	push {r4-r11,lr}
	bl pixel
	pop {r4-r11,lr}
	cmp r10,r4 @Compara ancho de imagen con contador de columnas pintadas
	subge r7,r4 @Si el contador es mayor o igual a la altura, reiniica la posici�n en x
	movge r10,#0 @Se reinicia contador tambi�n.
	bge fory @Se avanza a la siguiente fila (for en y).
	add r7,#1 @Si no es igual o mayor al ancho, avanza al siguiente pixel de la fila
	add r10,#1 @Suma uno tambi�n al contador de columnas.
	b forx @Repite el for en x hasta acabar con la fila.

	