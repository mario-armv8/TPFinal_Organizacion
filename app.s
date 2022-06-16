
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
color_piel: .dword 0xFFAA3C
color_verde_oscu: .dword 0x666600
color_amarillo: .dword 0xFFFFFF

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


	mov x15,500
	mov x16,300
	bl tubo
	

//TUBO
tubo:

	//Tubo arriba

	.equ ancho_tubo_arriba, QUARTER_SQUARES_SIZE * 9	// x = 90
	.equ altura_tubo_arriba, QUARTER_SQUARES_SIZE * 4	// y = 40

	bl get_pixel
	ldr w1,color_tubo
	mov x2,ancho_tubo_arriba
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo



	//Tubo abajo

	.equ ancho_tubo_abajo, QUARTER_SQUARES_SIZE * 8		// x = 80
	.equ altura_tubo_abajo, QUARTER_SQUARES_SIZE * 6	// x = 60

	add x15,x15,5
	add x16,x16,40
	bl get_pixel
	mov x2,ancho_tubo_abajo
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo
	//////////////////////////////////
	
	
	//Sombreado interno

	.equ ancho_linea_fina, 2							// x = 2
	.equ ancho_linea_gruesa, 4							// x = 4
	.equ ancho_linea_gruesa2, QUARTER_SQUARES_SIZE*2	// x = 20
	.equ ancho_linea_gruesa3, QUARTER_SQUARES_SIZE+5	// x = 15
	.equ altura_linea_arriba, QUARTER_SQUARES_SIZE*3+5	// y = 35
	.equ altura_linea_abajo, QUARTER_SQUARES_SIZE*6		// y = 60
	.equ largo_linea_fina1, QUARTER_SQUARES_SIZE		// x = 10
	.equ largo_linea_fina2, QUARTER_SQUARES_SIZE*3+7	// x = 37


	
	sub x15,x15,5
	sub x16,x16,35
	bl get_pixel
	ldr w1,color_interno_tubo
	mov x2,largo_linea_fina1
	mov x3,ancho_linea_fina
	bl pintar_rectangulo

	
	add x15,x15,10
	bl get_pixel
	mov x2,ancho_linea_gruesa
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	
	add x15,x15,40
	bl get_pixel
	mov x2,largo_linea_fina2
	mov x3,ancho_linea_fina
	bl pintar_rectangulo

	
	bl get_pixel
	mov x2,ancho_linea_fina
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	
	add x15,x15,10
	bl get_pixel
	mov x2,ancho_linea_gruesa2
	mov x3,altura_linea_arriba
	bl pintar_rectangulo

	
	sub x15,x15,45
	add x16,x16,35
	bl get_pixel
	mov x2,ancho_linea_gruesa
	mov x3,altura_linea_abajo
	bl pintar_rectangulo
	
	
	add x15,x15,38
	bl get_pixel
	mov x2,ancho_linea_fina
	mov x3,altura_linea_abajo
	bl pintar_rectangulo

	
	add x15,x15,9
	bl get_pixel
	mov x2,ancho_linea_gruesa3
	mov x3,altura_linea_abajo
	bl pintar_rectangulo
	//////////////////////////////////


	//Borde arriba
	.equ linea_arriba, 2

	
	sub x15,x15,62
	sub x16,x16,40
	bl get_pixel	
	ldr w1,black
	mov x2,ancho_tubo_arriba
	mov x3,linea_arriba
	bl pintar_rectangulo

	//Borde arriba laterales
	.equ linea_arriba_laterales, 2

	
	bl get_pixel
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo

	
	add x15,x15,88
	bl get_pixel	
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_arriba
	bl pintar_rectangulo

	//Borde abajo laterales
	.equ linea_arriba_laterales, 2

	
	sub x15,x15,83
	add x16,x16,40
	bl get_pixel	
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo

	
	add x15,x15,78
	bl get_pixel	
	mov x2,linea_arriba_laterales
	mov x3,altura_tubo_abajo
	bl pintar_rectangulo

	//Borde medio arriba
	.equ linea_medio_arriba, 2

	
	sub x15,x15,83
	sub x16,x16,2
	bl get_pixel	
	mov x2,ancho_tubo_arriba
	mov x3,linea_medio_arriba
	bl pintar_rectangulo
	

	//Borde medio abajo
	.equ linea_medio_abajo, 1

	
	add x15,x15,5
	add x16,x16,2
	bl get_pixel	
	mov x2,ancho_tubo_abajo
	mov x3,linea_medio_abajo
	bl pintar_rectangulo
	//////////////////////////////////


















	mov x15,100
	mov x16,200
	bl mario



//MARIO
mario:
  //Botas
	.equ ancho_botas_suela, QUARTER_SQUARES_SIZE * 2 // x = 20
	.equ altura_botas_suela, 4						 // y = 4
	.equ ancho_botas, QUARTER_SQUARES_SIZE + 5		 // x = 15
	.equ altura_botas, 3							 // y = 3

	//izq
	
	bl get_pixel
////	ldr x9,=0xFA410 // x = 260, y = 400
	
	ldr w1,color_verde_oscu
	mov x2,ancho_botas_suela
	mov x3,altura_botas_suela
	bl pintar_rectangulo
	
	
	add x15,x15,5
	sub x16,x16,4
	bl get_pixel
	mov x2,ancho_botas
	mov x3,altura_botas
	bl pintar_rectangulo

	//der
	
	add x15,x15,35
	add x16,x16,4
	bl get_pixel
	mov x2,ancho_botas_suela
	mov x3,altura_botas_suela
	bl pintar_rectangulo
	
	
	sub x16,x16,4
	bl get_pixel
	mov x2,ancho_botas
	mov x3,altura_botas
	bl pintar_rectangulo



	//////////////////////////////////

  //Traje
	.equ ancho_centro_traje, QUARTER_SQUARES_SIZE + 5 // x = 15
	.equ altura_centro_traje, QUARTER_SQUARES_SIZE	  // y = 10

	
	sub x15,x15,30
	sub x16,x16,11
	bl get_pixel
	ldr w1,red
	mov x2,ancho_centro_traje
	mov x3,altura_centro_traje
	bl pintar_rectangulo
	
	
	add x15,x15,25
	bl get_pixel
	mov x2,ancho_centro_traje
	mov x3,altura_centro_traje
	bl pintar_rectangulo

	.equ ancho_centro_traje_2, QUARTER_SQUARES_SIZE * 3 // x = 30
	.equ altura_centro_traje_2, QUARTER_SQUARES_SIZE	// y = 10

	
	sub x15,x15,20
	sub x16,x16,5
	bl get_pixel
	mov x2,ancho_centro_traje_2
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	
	add x15,x15,1
	sub x16,x16,5
	bl get_pixel
	mov x2,4
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	
	add x15,x15,25
	bl get_pixel
	mov x2,4
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	.equ ancho_arriba_traje, QUARTER_SQUARES_SIZE 		// x = 10
	.equ altura_arriba_traje, QUARTER_SQUARES_SIZE * 2	// y = 20

	
	sub x15,x15,16
	sub x16,x16,5
	bl get_pixel
	mov x2,ancho_arriba_traje
	mov x3,altura_arriba_traje
	bl pintar_rectangulo

	.equ ancho_arriba_traje_2, QUARTER_SQUARES_SIZE * 3 - 6		// x = 24
	.equ altura_arriba_traje_2, QUARTER_SQUARES_SIZE - 5		// y = 5

	
	sub x15,x15,7
	bl get_pixel
	mov x2,ancho_arriba_traje_2
	mov x3,altura_arriba_traje_2
	bl pintar_rectangulo
	
	.equ ancho_tiras, QUARTER_SQUARES_SIZE - 6	// x = 4
	.equ altura_tiras, QUARTER_SQUARES_SIZE		// y = 10

	
	sub x16,x16,10
	bl get_pixel
	mov x2,ancho_tiras
	mov x3,altura_tiras
	bl pintar_rectangulo
	
	
	add x15,x15,20
	bl get_pixel
	mov x2,ancho_tiras
	mov x3,altura_tiras
	bl pintar_rectangulo



//Brazos
	.equ ancho_brazo, QUARTER_SQUARES_SIZE			// x = 10
	.equ altura_brazo, QUARTER_SQUARES_SIZE + 5		// y = 15

	//izq
	
	sub x15,x15,38
	add x16,x16,15
	bl get_pixel
	ldr w1,color_piel
	mov x2,ancho_brazo
	mov x3,altura_brazo
	bl pintar_rectangulo
		

	
	add x15,x15,20
	bl get_pixel
	ldr w1,color_amarillo
	mov x2,4
	mov x3,4
	bl pintar_rectangulo

	//der
	
	add x15,x15,30
	bl get_pixel
	ldr w1,color_piel
	mov x2,ancho_brazo
	mov x3,altura_brazo
	bl pintar_rectangulo

	
	sub x15,x15,14
	bl get_pixel
	ldr w1,color_amarillo
	mov x2,4
	mov x3,4
	bl pintar_rectangulo


//Pulgares
	.equ ancho_pulgar, QUARTER_SQUARES_SIZE - 5 	// x = 5
	.equ altura_pulgar, QUARTER_SQUARES_SIZE - 5	// y = 5

	//izq
	
	sub x15,x15,26
	add x16,x16,5
	bl get_pixel
	ldr w1,color_piel
	mov x2,ancho_pulgar
	mov x3,altura_pulgar
	bl pintar_rectangulo
	
	//der
	
	add x15,x15,35
	bl get_pixel
	mov x2,ancho_pulgar
	mov x3,altura_pulgar
	bl pintar_rectangulo


//Parte verde
	.equ ancho_verde, QUARTER_SQUARES_SIZE - 5		// x = 5
	.equ altura_verde, QUARTER_SQUARES_SIZE - 6		// y = 4

  //cerca pulgares
	//izq
	
	sub x15,x15,35
	sub x16,x16,5
	bl get_pixel
	ldr w1,color_verde_oscu
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo
	
	//der
	
	add x15,x15,35
	bl get_pixel
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo

  //cerca traje
	.equ ancho_verde, QUARTER_SQUARES_SIZE *2 - 3	// x = 17
	.equ altura_verde, QUARTER_SQUARES_SIZE - 6		// y = 4

	//izq
	
	sub x15,x15,45
	sub x16,x16,5
	bl get_pixel
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo

	//der	
	
	add x15,x15,43
	bl get_pixel
	mov x2,ancho_verde
	mov x3,altura_verde
	bl pintar_rectangulo

	.equ ancho_verde_2, QUARTER_SQUARES_SIZE + 2	 // x = 12

	//izq
	
	sub x15,x15,38
	sub x16,x16,5
	bl get_pixel
	mov x2,ancho_verde_2
	mov x3,altura_verde
	bl pintar_rectangulo

	
	add x15,x15,5
	sub x16,x16,5
	bl get_pixel
	mov x2,7
	mov x3,altura_verde
	bl pintar_rectangulo

	//der	
	
	add x15,x15,33
	add x16,x16,5
	bl get_pixel
	mov x2,ancho_verde_2
	mov x3,altura_verde
	bl pintar_rectangulo

	//centro 
	.equ ancho_centro_verde, QUARTER_SQUARES_SIZE + 4	 // x = 14
	.equ altura_centro_verde, QUARTER_SQUARES_SIZE - 1	 // y = 9

	
	sub x15,x15,20
	sub x16,x16,5
	bl get_pixel
	mov x2,ancho_centro_verde
	mov x3,altura_centro_verde
	bl pintar_rectangulo


//Cabeza
	//centro
	.equ ancho_centro_cabeza, QUARTER_SQUARES_SIZE * 2 + 2	 // x = 22
	.equ altura_centro_cabeza, QUARTER_SQUARES_SIZE 	 	 // x = 10

	
	sub x15,x15,8
	sub x16,x16,10
	bl get_pixel
	ldr w1, color_piel
	mov x2,ancho_centro_cabeza
	mov x3,altura_centro_cabeza
	bl pintar_rectangulo

	.equ ancho_menton, QUARTER_SQUARES_SIZE 	  // x = 10
	.equ altura_menton, QUARTER_SQUARES_SIZE - 5  // y = 5

	
	add x15,x15,23
	add x16,x16,5
	bl get_pixel
	mov x2,ancho_menton
	mov x3,altura_menton
	bl pintar_rectangulo

	
	sub x15,x15,28
	sub x16,x16,20
	bl get_pixel
	mov x2,6
	mov x3,20
	bl pintar_rectangulo

	.equ ancho_centro_cabeza_2, QUARTER_SQUARES_SIZE + 6	 // x = 16
	.equ altura_centro_cabeza_2, QUARTER_SQUARES_SIZE + 5	 // x = 15

	
	add x15,x15,11
	bl get_pixel
	mov x2,ancho_centro_cabeza_2
	mov x3,altura_centro_cabeza_2
	bl pintar_rectangulo

	
	add x15,x15,16
	add x16,x16,9
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo

	//Bigote
	.equ ancho_bigote, QUARTER_SQUARES_SIZE * 2 - 1  // x = 19
	.equ altura_bigote, QUARTER_SQUARES_SIZE - 5	 // y = 5

	
	add x15,x15,1
	add x16,x16,5
	bl get_pixel
	ldr w1, color_verde_oscu
	mov x2,ancho_bigote
	mov x3,altura_bigote
	bl pintar_rectangulo
	
	
	add x15,x15,5
	sub x16,x16,5
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo
	
	//Ojo
	.equ ancho_ojo, QUARTER_SQUARES_SIZE - 6	// x = 4
	.equ altura_ojo, QUARTER_SQUARES_SIZE - 1	// y = 9

	
	sub x15,x15,5
	sub x16,x16,9
	bl get_pixel
	ldr w1,color_verde_oscu
	mov x2,ancho_ojo
	mov x3,altura_ojo
	bl pintar_rectangulo
	
	
	add x15,x15,5
	add x16,x16,9
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo
	
	//Nariz
	.equ ancho_nariz, QUARTER_SQUARES_SIZE - 2	// x = 8
	.equ altura_nariz, QUARTER_SQUARES_SIZE 	// x = 10

	
	add x15,x15,6
	sub x16,x16,5
	bl get_pixel
	ldr w1,color_piel
	mov x2,ancho_nariz
	mov x3,altura_nariz
	bl pintar_rectangulo
	
	
	add x15,x15,9
	add x16,x16,5
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo

	
	sub x15,x15,15
	sub x16,x16,9
	bl get_pixel
	mov x2,5
	mov x3,10
	bl pintar_rectangulo

	//Pelo
	.equ ancho_pelo, QUARTER_SQUARES_SIZE - 5	// x = 5
	.equ altura_pelo, QUARTER_SQUARES_SIZE + 4	// y = 14

	
	sub x15,x15,28
	bl get_pixel
	ldr w1,color_verde_oscu
	mov x2,ancho_pelo
	mov x3,altura_pelo
	bl pintar_rectangulo
	
	
	sub x15,x15,5
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo

	
	sub x15,x15,6
	add x16,x16,5
	bl get_pixel
	mov x2,5
	mov x3,10
	bl pintar_rectangulo

	
	add x15,x15,6
	add x16,x16,10
	bl get_pixel
	mov x2,4
	mov x3,5
	bl pintar_rectangulo


	//Sombrero
	.equ ancho_sombrero, QUARTER_SQUARES_SIZE * 5 - 5	// x = 45
	.equ altura_sombrero, QUARTER_SQUARES_SIZE - 5		// y = 5

	
	add x15,x15,5
	sub x16,x16,20
	bl get_pixel
	ldr w1,red
	mov x2,ancho_sombrero
	mov x3,altura_sombrero
	bl pintar_rectangulo
	
	.equ ancho_sombrero_2, QUARTER_SQUARES_SIZE * 3 	// x = 30
	.equ altura_sombrero_2, QUARTER_SQUARES_SIZE - 3	// x = 7

	
	add x15,x15,5
	sub x16,x16,7
	bl get_pixel
	mov x2,ancho_sombrero_2
	mov x3,altura_sombrero_2
	bl pintar_rectangulo
	







	mov x15,100
	mov x16,300
	bl mario_mov




//MARIO EN MOVIMIENTO
mario_mov:
  //Botas
	.equ ancho_botas_suela, QUARTER_SQUARES_SIZE +1  // x = 11
	.equ altura_botas_suela, 4						 // y = 4
	.equ ancho_botas, QUARTER_SQUARES_SIZE	+2 		 // x = 12
	.equ altura_botas, QUARTER_SQUARES_SIZE -3		 // y = 7


	//izq
	bl get_pixel
//	ldr x9,=0xFA410 // x = 260, y = 400
	ldr w1,color_verde_oscu
	mov x2,ancho_botas_suela
	mov x3,altura_botas_suela
	bl pintar_rectangulo
	
	
	sub x15,x15,5
	sub x16,x16,8
	bl get_pixel
//	ldr x9,=0xF53FC // x = 255, y = 392
	mov x2,ancho_botas
	mov x3,altura_botas
	bl pintar_rectangulo

	//der
	.equ ancho_botas_2, QUARTER_SQUARES_SIZE-2	// x = 8
	.equ altura_botas_2, QUARTER_SQUARES_SIZE	// y = 10

	
	add x15,x15,51
	sub x16,x16,12
	bl get_pixel
//	ldr x9,=0xEDCC8 // x = 306, y = 380
	mov x2,ancho_botas_2
	mov x3,altura_botas_2
	bl pintar_rectangulo
	
	
	add x15,x15,4
	sub x16,x16,4
	bl get_pixel
//	ldr x9,=0xEB4D8 // x = 310, y = 376
	mov x2,4
	mov x3,4
	bl pintar_rectangulo

	//////////////////////////////////



  //Traje
	.equ ancho_centro_traje, QUARTER_SQUARES_SIZE + 5 	  // x = 15
	.equ altura_centro_traje, QUARTER_SQUARES_SIZE - 2	  // y = 8

	.equ ancho_centro_traje_2, QUARTER_SQUARES_SIZE * 4 	  // x = 40
	.equ altura_centro_traje_2, QUARTER_SQUARES_SIZE - 4	  // y = 6

	
	sub x15,x15,50
	add x16,x16,9
	bl get_pixel
//	ldr x9,=0xF0E10 // x = 260, y = 385
	ldr w1,red
	mov x2,ancho_centro_traje
	mov x3,altura_centro_traje
	bl pintar_rectangulo
	
	
	add x15,x15,5
	sub x16,x16,5
	bl get_pixel
//	ldr x9,=0xEDC24 // x = 265, y = 380
	mov x2,ancho_centro_traje_2
	mov x3,altura_centro_traje_2
	bl pintar_rectangulo

	.equ ancho_centro_traje_3, QUARTER_SQUARES_SIZE 	// x = 12
	.equ altura_centro_traje_3, QUARTER_SQUARES_SIZE 	// y = 12

	
	add x15,x15,30
	bl get_pixel
//	ldr x9,=0xEDC9C // x = 295, y = 380
	mov x2,ancho_centro_traje_3
	mov x3,altura_centro_traje_3
	bl pintar_rectangulo

	.equ ancho_centro_traje_4, QUARTER_SQUARES_SIZE *3		// x = 30
	.equ altura_centro_traje_4, QUARTER_SQUARES_SIZE + 3	// y = 13

	
	sub x15,x15,25
	sub x16,x16,8
	bl get_pixel
//	ldr x9,=0xE8C38 // x = 270, y = 372
	mov x2,ancho_centro_traje_4
	mov x3,altura_centro_traje_4
	bl pintar_rectangulo



	.equ ancho_tiras_traje, QUARTER_SQUARES_SIZE - 2	// x = 8
	.equ altura_tiras_traje, QUARTER_SQUARES_SIZE *2 	// y = 20

	
	add x15,x15,10
	sub x16,x16,17
	bl get_pixel
//	ldr x9,=0xDE260 // x = 280, y = 355
	mov x2,ancho_tiras_traje
	mov x3,altura_tiras_traje
	bl pintar_rectangulo


	.equ ancho_arriba_traje, QUARTER_SQUARES_SIZE + 5		// x = 15
	.equ altura_arriba_traje, QUARTER_SQUARES_SIZE - 4	// y = 5

	
	add x15,x15,5
	add x16,x16,10
	bl get_pixel
//	ldr x9,=0xE4674 // x = 285, y = 365
	mov x2,ancho_arriba_traje
	mov x3,altura_arriba_traje
	bl pintar_rectangulo

	.equ ancho_arriba_traje_2, QUARTER_SQUARES_SIZE - 7		// x = 4
	.equ altura_arriba_traje_2, QUARTER_SQUARES_SIZE - 7	// y = 4

	
	add x15,x15,4
	sub x16,x16,4
	bl get_pixel
//	ldr x9,=0xE1E84 // x = 289, y = 361
	mov x2,ancho_arriba_traje_2
	mov x3,altura_arriba_traje_2
	bl pintar_rectangulo



	.equ ancho_parte_verde, QUARTER_SQUARES_SIZE * 2 -1	// x = 19
	.equ altura_parte_verde, QUARTER_SQUARES_SIZE 		// y = 10

	
	sub x15,x15,29
	sub x16,x16,6
	bl get_pixel
//	ldr x9,=0xDE210 // x = 260, y = 355
	ldr w1,color_verde_oscu
	mov x2,ancho_parte_verde
	mov x3,altura_parte_verde
	bl pintar_rectangulo

	.equ ancho_parte_verde_2, QUARTER_SQUARES_SIZE -1		// x = 9
	.equ altura_parte_verde_2, QUARTER_SQUARES_SIZE -5		// y = 5

	
	add x15,x15,10
	add x16,x16,11
	bl get_pixel
//	ldr x9,=0xE5038 // x = 270, y = 366
	ldr w1,color_verde_oscu
	mov x2,ancho_parte_verde_2
	mov x3,altura_parte_verde_2
	bl pintar_rectangulo


	.equ ancho_parte_verde_3, QUARTER_SQUARES_SIZE 			// x = 10
	.equ altura_parte_verde_3, 5							// y = 5

	
	add x15,x15,19
	sub x16,x16,11
	bl get_pixel
//	ldr x9,=0xDE284 // x = 289, y = 355
	ldr w1,color_verde_oscu
	mov x2,ancho_parte_verde_3
	mov x3,altura_parte_verde_3
	bl pintar_rectangulo

	.equ ancho_parte_verde_4, QUARTER_SQUARES_SIZE +3		// x = 13
	.equ altura_parte_verde_4, 4							// y = 4

	
	add x15,x15,4
	add x16,x16,6
	bl get_pixel
//	ldr x9,=0xE1E94 // x = 293, y = 361
	ldr w1,color_verde_oscu
	mov x2,ancho_parte_verde_4
	mov x3,altura_parte_verde_4
	bl pintar_rectangulo

	.equ ancho_parte_verde_5, QUARTER_SQUARES_SIZE 			// x = 10
	.equ altura_parte_verde_5, 3							// y = 4

	
	add x15,x15,8
	add x16,x16,5
	bl get_pixel
//	ldr x9,=0xE50B4 // x = 301, y = 366
	ldr w1,color_verde_oscu
	mov x2,ancho_parte_verde_5
	mov x3,altura_parte_verde_5
	bl pintar_rectangulo



//Brazos
	.equ ancho_brazo_izq, QUARTER_SQUARES_SIZE	-2		// x = 8
	.equ altura_brazo_izq, QUARTER_SQUARES_SIZE + 5		// y = 15

	//izq
	
	sub x15,x15,50
	sub x16,x16,6
	bl get_pixel
//	ldr x9,=0xE13EC // x = 251, y = 360
	ldr w1,color_piel
	mov x2,ancho_brazo_izq
	mov x3,altura_brazo_izq
	bl pintar_rectangulo
		

	
	add x15,x15,9
	add x16,x16,6
	bl get_pixel
//	ldr x9,=0xE5010 // x = 260, y = 366
	mov x2,4
	mov x3,4
	bl pintar_rectangulo



	.equ ancho_brazo_der, QUARTER_SQUARES_SIZE + 3		// x = 13
	.equ altura_brazo_der, QUARTER_SQUARES_SIZE - 6		// y = 4

	//der
	
	add x15,x15,46
	sub x16,x16,5
	bl get_pixel
//	ldr x9,=0xE1ECC // x = 307, y = 361
	mov x2,ancho_brazo_der
	mov x3,altura_brazo_der
	bl pintar_rectangulo


	.equ ancho_brazo_der_2, QUARTER_SQUARES_SIZE - 2		// x = 8
	.equ altura_brazo_der_2, QUARTER_SQUARES_SIZE - 6		// y = 4

	
	add x15,x15,5
	add x16,x16,4
	bl get_pixel
//	ldr x9,=0xE46E0 // x = 312, y = 365
	mov x2,ancho_brazo_der_2
	mov x3,altura_brazo_der_2
	bl pintar_rectangulo



//Cabeza
	//centro
	.equ ancho_centro_cabeza, QUARTER_SQUARES_SIZE * 2 + 2	 // x = 22
	.equ altura_centro_cabeza, QUARTER_SQUARES_SIZE 	 	 // x = 10

	
	sub x15,x15,37
	sub x16,x16,21
	bl get_pixel
//	ldr x9,=0xDB04C // x = 275, y = 334
	ldr w1, color_piel
	mov x2,ancho_centro_cabeza
	mov x3,altura_centro_cabeza
	bl pintar_rectangulo


	.equ ancho_menton, QUARTER_SQUARES_SIZE 		 // x = 10
	.equ altura_menton, QUARTER_SQUARES_SIZE - 5	 // y = 5

	
	add x15,x15,23
	add x16,x16,5
	bl get_pixel
//	ldr x9,=0xDE280 // x = 298, y = 339
	mov x2,ancho_menton
	mov x3,altura_menton
	bl pintar_rectangulo

	
	sub x15,x15,28
	sub x16,x16,20
	bl get_pixel
//	ldr x9,=0xD1A38 // x = 270, y = 319
	mov x2,6
	mov x3,20
	bl pintar_rectangulo


	.equ ancho_centro_cabeza_2, QUARTER_SQUARES_SIZE + 6	 // x = 16
	.equ altura_centro_cabeza_2, QUARTER_SQUARES_SIZE + 5	 // x = 15

	
	add x15,x15,11
	bl get_pixel
//	ldr x9,=0xD1A64 // x = 281, y = 339
	mov x2,ancho_centro_cabeza_2
	mov x3,altura_centro_cabeza_2
	bl pintar_rectangulo

	
	add x15,x15,16
	add x16,x16,9
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo

	//Bigote
	.equ ancho_bigote, QUARTER_SQUARES_SIZE * 2 - 1  // x = 19
	.equ altura_bigote, QUARTER_SQUARES_SIZE - 5	 // y = 5

	
	add x15,x15,1
	add x16,x16,5
	bl get_pixel
	ldr w1, color_verde_oscu
	mov x2,ancho_bigote
	mov x3,altura_bigote
	bl pintar_rectangulo
	
	
	add x15,x15,5
	sub x16,x16,5
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo
	
	//Ojo
	.equ ancho_ojo, QUARTER_SQUARES_SIZE - 6	// x = 4
	.equ altura_ojo, QUARTER_SQUARES_SIZE - 1	// y = 9

	
	sub x15,x15,5
	sub x16,x16,9
	bl get_pixel
	ldr w1,color_verde_oscu
	mov x2,ancho_ojo
	mov x3,altura_ojo
	bl pintar_rectangulo
	
	
	add x15,x15,5
	add x16,x16,9
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo
	
	//Nariz
	.equ ancho_nariz, QUARTER_SQUARES_SIZE - 2	// x = 8
	.equ altura_nariz, QUARTER_SQUARES_SIZE 	// x = 10

	
	add x15,x15,6
	sub x16,x16,5
	bl get_pixel
	ldr w1,color_piel
	mov x2,ancho_nariz
	mov x3,altura_nariz
	bl pintar_rectangulo
	
	
	add x15,x15,9
	add x16,x16,5
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo

	
	sub x15,x15,15
	sub x16,x16,9
	bl get_pixel
	mov x2,5
	mov x3,10
	bl pintar_rectangulo

	//Pelo
	.equ ancho_pelo, QUARTER_SQUARES_SIZE - 5	// x = 5
	.equ altura_pelo, QUARTER_SQUARES_SIZE + 4	// y = 14

	
	sub x15,x15,28
	bl get_pixel
	ldr w1,color_verde_oscu
	mov x2,ancho_pelo
	mov x3,altura_pelo
	bl pintar_rectangulo
	
	
	sub x15,x15,5
	bl get_pixel
	mov x2,5
	mov x3,5
	bl pintar_rectangulo

	
	sub x15,x15,6
	add x16,x16,5
	bl get_pixel
	mov x2,5
	mov x3,10
	bl pintar_rectangulo

	
	add x15,x15,6
	add x16,x16,10
	bl get_pixel
	mov x2,4
	mov x3,5
	bl pintar_rectangulo


	//Sombrero
	.equ ancho_sombrero, QUARTER_SQUARES_SIZE * 5 - 5	// x = 45
	.equ altura_sombrero, QUARTER_SQUARES_SIZE - 5		// y = 5

	
	add x15,x15,5
	sub x16,x16,20
	bl get_pixel
	ldr w1,red
	mov x2,ancho_sombrero
	mov x3,altura_sombrero
	bl pintar_rectangulo
	
	.equ ancho_sombrero_2, QUARTER_SQUARES_SIZE * 3 	// x = 30
	.equ altura_sombrero_2, QUARTER_SQUARES_SIZE - 3	// x = 7

	
	add x15,x15,5
	sub x16,x16,7
	bl get_pixel
	mov x2,ancho_sombrero_2
	mov x3,altura_sombrero_2
	bl pintar_rectangulo


	add x15,x15,6
	add x16,x16,53
	bl get_pixel
	ldr w1,color_amarillo
	mov x2,4
	mov x3,4
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

	/*Parametros:
			x15 = eje x
			x16 = eje y
			 */

  get_pixel:
		mov x0,x20		
		mov x9,SCREEN_WIDTH
		mov x18,4
		madd x9,x16,x9,x15 // x9 = (x16 * 640) + x15
		mul x9,x9,x18 // x9 = 4*x9
		add x0,x0,x9
		br lr


//////



