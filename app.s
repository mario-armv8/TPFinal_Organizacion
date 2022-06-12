
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ QUARTER_SQUARES_SIZE,  10


black: .dword 0x000000
white: .dword 0xFFFFFF
red: .dword 0xFF0000
color_tubo: .dword 0xB2FF4B
color_interno_tubo: .dword 0x00C300
color_cielo: .dword 0x6E91FF
color_piel: .dword 0x000000
color_verde_oscu: .dword 0x00C300

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
	//////////////////////////////////


//TUBO
	//Tubo arriba

	.equ ancho_tubo_arriba, QUARTER_SQUARES_SIZE * 9
	.equ altura_tubo_arriba, QUARTER_SQUARES_SIZE * 4

	mov x0,x20
	ldr x9,=0xEDFD0 // x = 500 y = 380
	add x0,x0,x9
	ldr w1,color_tubo
	mov x2,ancho_tubo_arriba
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo



	//Tubo abajo

	.equ ancho_tubo_abajo, QUARTER_SQUARES_SIZE * 8
	.equ altura_tubo_abajo, QUARTER_SQUARES_SIZE * 6

	mov x0,x20
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


	mov x0,x20
	ldr x9,=0xF11DC // x = 500 y = 385
	add x0,x0,x9
	ldr w1,color_interno_tubo
	mov x2,largo_linea_fina1
	mov x3,ancho_linea_fina
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xF11F8 // x = 510 y = 385
	add x0,x0,x9
	mov x2,ancho_linea_gruesa
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xF1298 // x = 550 y = 385
	add x0,x0,x9
	mov x2,largo_linea_fina2
	mov x3,ancho_linea_fina
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xF1298 // x = 550 y = 385
	add x0,x0,x9
	mov x2,ancho_linea_fina
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xF12C0 // x = 560 y = 385
	add x0,x0,x9
	mov x2,ancho_linea_gruesa2
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0x10700C // x = 515 y = 420
	add x0,x0,x9
	mov x2,ancho_linea_gruesa
	mov x3,altura_linea_abajo
	bl pintar_rectangulo
	
	mov x0,x20
	ldr x9,=0x1070A4 // x = 553 y = 420
	add x0,x0,x9
	mov x2,ancho_linea_fina
	mov x3,altura_linea_abajo
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0x1070C8 // x = 562 y = 420
	add x0,x0,x9
	mov x2,ancho_linea_gruesa3
	mov x3,altura_linea_abajo
	bl pintar_rectangulo
	//////////////////////////////////


	//Borde arriba
	.equ linea_arriba, 2

	mov x0,x20
	ldr x9,=0xEDFD0 // x = 500, y = 380
	add x0,x0,x9
	ldr w1,black
	mov x2,ancho_tubo_arriba
	mov x3,linea_arriba
	bl pintar_rectangulo

	//Borde arriba laterales
	.equ linea_arriba_laterales, 2

	mov x0,x20
	ldr x9,=0xEDFD0 // x = 500, y = 380
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xEE130 // x = 588, y = 380
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo

	//Borde abajo laterales
	.equ linea_arriba_laterales, 2

	mov x0,x20
	ldr x9,=0x106FE4 // x = 505, y = 420
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0x10711C // x = 583, y = 420
	add x0,x0,x9
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo

	//Borde medio arriba
	.equ linea_medio_arriba, 2

	mov x0,x20
	ldr x9,=0x105BD0 // x = 500, y = 418
	add x0,x0,x9
	mov x2,ancho_tubo_arriba
	mov x3,linea_medio_arriba
	bl pintar_rectangulo
	

	//Borde medio abajo
	.equ linea_medio_abajo, 1

	mov x0,x20
	ldr x9,=0x106FE4 // x = 505, y = 420
	add x0,x0,x9
	mov x2,ancho_tubo_abajo
	mov x3,linea_medio_abajo
	bl pintar_rectangulo
	//////////////////////////////////


//MARIO
  //Botas
	.equ ancho_botas_suela, QUARTER_SQUARES_SIZE * 2
	.equ altura_botas_suela, 4
	.equ ancho_botas, QUARTER_SQUARES_SIZE + 5
	.equ altura_botas, 3

	mov x0,x20
	ldr x9,=0xFA4B0 // x = 300, y = 400
	add x0,x0,x9
	ldr w1,color_interno_tubo
	mov x2,ancho_botas_suela
	mov x3,altura_botas_suela
	bl pintar_rectangulo
	
	mov x0,x20
	ldr x9,=0xF7CB0 // x = 300, y = 396
	add x0,x0,x9
	mov x2,ancho_botas
	mov x3,altura_botas
	bl pintar_rectangulo


	mov x0,x20
	ldr x9,=0xFA410 // x = 260, y = 400
	add x0,x0,x9
	mov x2,ancho_botas_suela
	mov x3,altura_botas_suela
	bl pintar_rectangulo
	
	mov x0,x20
	ldr x9,=0xF7C24 // x = 265, y = 396
	add x0,x0,x9
	mov x2,ancho_botas
	mov x3,altura_botas
	bl pintar_rectangulo
	//////////////////////////////////

  //Traje
	.equ ancho_centro_traje, QUARTER_SQUARES_SIZE + 5
	.equ altura_centro_traje, QUARTER_SQUARES_SIZE

	mov x0,x20
	ldr x9,=0xF0E38 // x = 270, y = 385
	add x0,x0,x9
	ldr w1,red
	mov x2,ancho_centro_traje
	mov x3,altura_centro_traje
	bl pintar_rectangulo
	
	mov x0,x20
	ldr x9,=0xF0E9C // x = 295, y = 385
	add x0,x0,x9
	mov x2,ancho_centro_traje
	mov x3,altura_centro_traje
	bl pintar_rectangulo

	.equ ancho_centro_traje_2, QUARTER_SQUARES_SIZE * 3
	.equ altura_centro_traje_2, QUARTER_SQUARES_SIZE

	mov x0,x20
	ldr x9,=0xEDC4C // x = 275, y = 380
	add x0,x0,x9
	mov x2,ancho_centro_traje_2
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xEAA4C // x = 275, y = 375
	add x0,x0,x9
	mov x2,4
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	mov x0,x20
	ldr x9,=0xEAAB4 // x = 301, y = 375
	add x0,x0,x9
	mov x2,4
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	.equ ancho_arriba_traje, QUARTER_SQUARES_SIZE 
	.equ altura_arriba_traje, QUARTER_SQUARES_SIZE * 2

	mov x0,x20
	ldr x9,=0xE7874 // x = 285, y = 370
	add x0,x0,x9
	mov x2,ancho_arriba_traje
	mov x3,altura_arriba_traje
	bl pintar_rectangulo

	.equ ancho_arriba_traje_2, QUARTER_SQUARES_SIZE * 3 - 6
	.equ altura_arriba_traje_2, QUARTER_SQUARES_SIZE - 5

	mov x0,x20
	ldr x9,=0xE7858 // x = 278, y = 370
	add x0,x0,x9
	mov x2,ancho_arriba_traje_2
	mov x3,altura_arriba_traje_2
	bl pintar_rectangulo
	
	.equ ancho_tiras, QUARTER_SQUARES_SIZE - 6
	.equ altura_tiras, QUARTER_SQUARES_SIZE

	mov x0,x20
	ldr x9,=0xE1458 // x = 278, y = 360
	add x0,x0,x9
	mov x2,ancho_tiras
	mov x3,altura_tiras
	bl pintar_rectangulo
	
	mov x0,x20
	ldr x9,=0xE14A8 // x = 298, y = 360
	add x0,x0,x9
	mov x2,ancho_tiras
	mov x3,altura_tiras
	bl pintar_rectangulo


//Brazos
	.equ ancho_brazo, QUARTER_SQUARES_SIZE
	.equ altura_brazo, QUARTER_SQUARES_SIZE + 5

	//izq
	mov x0,x20
	ldr x9,=0xEAA10 // x = 260, y = 375
	add x0,x0,x9
	ldr w1,color_piel
	mov x2,ancho_brazo
	mov x3,altura_brazo
	bl pintar_rectangulo
		
	//der
	mov x0,x20
	ldr x9,=0xEAAD8 // x = 310, y = 375
	add x0,x0,x9
	mov x2,ancho_brazo
	mov x3,altura_brazo
	bl pintar_rectangulo

//Pulgares
	.equ ancho_pulgar, QUARTER_SQUARES_SIZE - 5 
	.equ altura_pulgar, QUARTER_SQUARES_SIZE - 5

	//izq
	mov x0,x20
	ldr x9,=0xEDC38 // x = 270, y = 380
	add x0,x0,x9
	mov x2,ancho_pulgar
	mov x3,altura_pulgar
	bl pintar_rectangulo
	
	//der
	mov x0,x20
	ldr x9,=0xEDCC4 // x = 305, y = 380
	add x0,x0,x9
	mov x2,ancho_pulgar
	mov x3,altura_pulgar
	bl pintar_rectangulo


//Parte verde
	.equ ancho_verde, QUARTER_SQUARES_SIZE - 6
	.equ altura_verde, QUARTER_SQUARES_SIZE - 6

  //cerca pulgares
	//izq
	mov x0,x20
	ldr x9,=0xEAA38 // x = 270, y = 375
	add x0,x0,x9
	ldr w1,color_verde_oscu
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo
	
	//der
	mov x0,x20
	ldr x9,=0xEAAC4 // x = 305, y = 375
	add x0,x0,x9
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo

  //cerca traje
	.equ ancho_verde, QUARTER_SQUARES_SIZE *2 - 3
	.equ altura_verde, QUARTER_SQUARES_SIZE - 6

	//izq
	mov x0,x20
	ldr x9,=0xE7810 // x = 260, y = 370
	add x0,x0,x9
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo

	//der	
	mov x0,x20
	ldr x9,=0xE78BC // x = 303, y = 370
	add x0,x0,x9
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo

	.equ ancho_verde_2, QUARTER_SQUARES_SIZE *2 - 8

	//izq
	mov x0,x20
	ldr x9,=0xE4624 // x = 265, y = 365
	add x0,x0,x9
	mov x2,ancho_verde_2
	mov x3,altura_verde
	bl pintar_rectangulo

	//der	
	mov x0,x20
	ldr x9,=0xE46BC // x = 303, y = 365
	add x0,x0,x9
	mov x2,ancho_verde_2
	mov x3,altura_verde
	bl pintar_rectangulo





InfLoop: 
	b InfLoop






//Figuras

  /*Rectangulo
  	  Parametros:
		x0 = coordenada inicial
		w1 = color
		x2 = base del cuadrado
		x3 = altura del cuadrado
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



