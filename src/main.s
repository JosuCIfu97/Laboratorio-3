/*------------------------------------------------------------------------
*Universidad del Valle de Guatemala
*Taller de Assembler
*Sección 21
*Josué Cifuentes #15275
*Pablo Muñoz #15258
*13/10/16
*Videojuego
*main.s
*size: 1360x768, 16 bits per pixel
------------------------------------------------------------------------*/

/*Área de código*/

.text
.global main

main:
	@Obtiene dirección del GPIO de la Raspberry
	bl GetGpioAddress
	ldr r1,=myloc
	str r0,[r1]

	@Obtiene dirección de monitor
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	@Cuatro pines en modo de lectura (push buttons de controles de mando)
	@Pin 12
	mov r0,#12 @botón superior
	mov r1,#0
	bl SetGpioFunction
	@Pin 16
	mov r0,#16 @botón izquierdo
	mov r1,#0
	bl SetGpioFunction
	@Pin 20
	mov r0,#20 @botón inferior
	mov r1,#0
	bl SetGpioFunction
	@Pin 21
	mov r0,#21 @botón derecho
	mov r1,#0
	bl SetGpioFunction

@Pinta el menu y luego corre un loop infinito hasta que se apache un botón.
	ldr r0,=pixelAddr
	ldr r0,[r0] @Puntero del buffer frame
	mov r1,#168 @Posición inicial en x
	mov r2,#0 @Posición inicial en y
	ldr r3,=Menu @Vector con colores de imagen
	ldr r4,=MenuWidth
	ldr r4,[r4] @Ancho de imagen
	ldr r5,=MenuHeight
	ldr r5,[r5] @Altura de imagen
	bl paint @Subrutina que pinta imagen
menu1:
	@Se verifica si los botones están siendo presionados
	@Pin 12
	mov r0,#12
	bl GetGpio
	cmp r0,#0
	mov r1,#12
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne instrucciones1
	@Pin 16
	mov r0,#16
	bl GetGpio
	cmp r0,#0
	mov r1,#16
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne instrucciones1
	@Pin 20
	mov r0,#20
	bl GetGpio
	cmp r0,#0
	mov r1,#20
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne instrucciones1
	@Pin 21
	mov r0,#21
	bl GetGpio
	cmp r0,#0
	mov r1,#21
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne instrucciones1
	b menu1 @Si ningún botón fue apachado, se mantiene en el loop.

@Pinta la página de instrucciones y después se mantiene en un loop esperando a que un botón sea presionado.
instrucciones1:
	ldr r0,=pixelAddr
	ldr r0,[r0] @Puntero del buffer frame
	mov r1,#64 @Posición inicial en x
	mov r2,#0 @Posición inicial en y
	ldr r3,=Instrucciones @Vector con colores de imagen
	ldr r4,=InstruccionesWidth
	ldr r4,[r4] @Ancho de imagen
	ldr r5,=InstruccionesHeight
	ldr r5,[r5] @Altura de imagen
	bl paint @Subrutina que pinta imagen
instrucciones2:
	@Se verifica si los botones están siendo presionados
	@Pin 12
	mov r0,#12
	bl GetGpio
	cmp r0,#0
	mov r1,#12
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne juego
	@Pin 16
	mov r0,#16
	bl GetGpio
	cmp r0,#0
	mov r1,#16
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne juego
	@Pin 20
	mov r0,#20
	bl GetGpio
	cmp r0,#0
	mov r1,#20
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne juego
	@Pin 21
	mov r0,#21
	bl GetGpio
	cmp r0,#0
	mov r1,#21
	blne buttonPressed @Subrutina para evitar ruido.
	cmp r0,#0
	bne juego
	b instrucciones2 @Si ningún botón fue apachado, se mantiene en el loop.

@Inicializa juego
juego:
	
	@Salida al SO
	mov r7,#1
	swi 0

/*Área de datos*/
.data
.global myloc
myloc: @GPIO virtual address Raspberry 2|3
	.word 0x3F200000
pixelAddr: @Dirección de monitor
	.word 0