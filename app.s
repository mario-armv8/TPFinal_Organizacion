
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ QUARTER_SQUARES_SIZE,  10


black: .dword 0x000000
white: .dword 0xFFFFFF
color_tubo: .dword 0xB2FF4B
color_interno_tubo: .dword 0x00C300
color_cielo: .dword 0x6E91FF

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	

	ldr x11, color_cielo 
	mov x2, SCREEN_HEIGH         // Y Size 
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur x11,[x0]	   // Set color of pixel N
	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

//Tubo
	//Tubo arriba

	.equ ancho_tubo_arriba, QUARTER_SQUARES_SIZE * 9
	.equ altura_tubo_arriba, QUARTER_SQUARES_SIZE * 4

	add x0,x20,xzr
	ldr x9,=0xEDFD0 // x = 500 y = 380
	add x0,x0,x9
	ldr w1,color_tubo
	mov x2,ancho_tubo_arriba
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo



	//Tubo abajo

	.equ ancho_tubo_abajo, QUARTER_SQUARES_SIZE * 8
	.equ altura_tubo_abajo, QUARTER_SQUARES_SIZE * 6

	add x0,x20,xzr
	ldr x9,=0x106FE4 // x = 505, y = 420
	add x0,x0,x9
	mov x2,ancho_tubo_abajo
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo
	//////////////////////////////////
	
	
	//Sombreado interno

	.equ ancho_linea_fina, 2
	.equ ancho_linea_gruesa, 4
	.equ ancho_linea_gruesa2, 20
	.equ ancho_linea_gruesa3, 15
	.equ altura_linea_arriba, 35
	.equ altura_linea_abajo, 60
	.equ largo_linea_fina1, 10
	.equ largo_linea_fina2, 37


	add x0,x20,xzr
	ldr x9,=0xF11DC // x = 500 y = 385
	add x0,x0,x9
	ldr w1,color_interno_tubo
	mov x2,largo_linea_fina1
	mov x3,ancho_linea_fina
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0xF11F8 // x = 510 y = 385
	add x0,x0,x9
	mov x2,ancho_linea_gruesa
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0xF1298 // x = 550 y = 385
	add x0,x0,x9
	mov x2,largo_linea_fina2
	mov x3,ancho_linea_fina
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0xF1298 // x = 550 y = 385
	add x0,x0,x9
	mov x2,ancho_linea_fina
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0xF12C0 // x = 560 y = 385
	add x0,x0,x9
	mov x2,ancho_linea_gruesa2
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0x10700C // x = 515 y = 420
	add x0,x0,x9
	mov x2,ancho_linea_gruesa
	mov x3,altura_linea_abajo
	bl pintar_rectangulo
	
	add x0,x20,xzr
	ldr x9,=0x1070A4 // x = 553 y = 420
	add x0,x0,x9
	mov x2,ancho_linea_fina
	mov x3,altura_linea_abajo
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0x1070C8 // x = 562 y = 420
	add x0,x0,x9
	mov x2,ancho_linea_gruesa3
	mov x3,altura_linea_abajo
	bl pintar_rectangulo
	//////////////////////////////////


	//Borde arriba
	.equ linea_arriba, 2

	add x0,x20,xzr
	ldr x9,=0xEDFD0 // x = 500, y = 380
	add x0,x0,x9
	ldr w1,black
	mov x2,ancho_tubo_arriba
	mov x3,linea_arriba
	bl pintar_rectangulo

	//Borde arriba laterales
	.equ linea_arriba_laterales, 2

	add x0,x20,xzr
	ldr x9,=0xEDFD0 // x = 500, y = 380
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0xEE130 // x = 588, y = 380
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo

	//Borde abajo laterales
	.equ linea_arriba_laterales, 2

	add x0,x20,xzr
	ldr x9,=0x106FE4 // x = 505, y = 420
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo

	add x0,x20,xzr
	ldr x9,=0x10711C // x = 583, y = 420
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo

	//Borde medio arriba
	.equ linea_medio_arriba, 2

	add x0,x20,xzr
	ldr x9,=0x105BD0 // x = 500, y = 418
	add x0,x0,x9
	mov x2,ancho_tubo_arriba
	mov x3,linea_medio_arriba
	bl pintar_rectangulo
	

	//Borde medio abajo
	.equ linea_medio_abajo, 1

	add x0,x20,xzr
	ldr x9,=0x106FE4 // x = 505, y = 420
	add x0,x0,x9
	mov x2,ancho_tubo_abajo
	mov x3,linea_medio_abajo
	bl pintar_rectangulo



//Figuras

  /*Rectangulo
  	  Parametros:
		x0 = coordenada inicial
		w1 = color
		x2 = ancho del cuadrado
		x3 = alto del cuadrado
	*/

  pintar_rectangulo:
		add x11, xzr,xzr // x11 = 0
		add x14, xzr,lr  // x14 = link register
		loop_pintar_rectangulo: 
			bl pintar_linea_horizontal 	//salto a pintar_linea_horizontal y guardo la siguiente instruccion en x14(link register)
			add x0,x0,2560 				// salto eje y + 1
			add x11,x11,1 				//  x11 = x11 + 1
			cmp x3, x11 				// if x3 >= x11
			b.ge loop_pintar_rectangulo
			br x14
//////


  /*Linea horizontal
  	  Parametros:
		x0 = coordenada inicial
		w1 = color
		x2 = largo de la linea
	*/

  pintar_linea_horizontal:
		add x12, xzr, x0 // x12 = x0
		add x13, xzr, xzr // x13 = 0
		
		loop_pintar_linea_horizontal:
			stur w1, [x12]	// 
			add x12, x12, #4 // siguiente pixel
			add x13, x13, 1 // x13 = x13 + 1
			cmp x2, x13	// if x13 >= x1
			b.ge loop_pintar_linea_horizontal 
			br lr

//////




InfLoop: 
	b InfLoop
