 
.include "data.s"
.include "draw_objects.s"
.globl main
main:
   // X0 contiene la direccion base del framebuffer
	mov x20, x0 // Save framebuffer base address to x20
   //---------------- CODE HERE ------------------------------------
  
  

//Pinta el fondo de un solo color
	bl draw_backround
//Pinta las cajas y el hongo que se encuentran en el medio
	bl draw_bricks
//Pinta los ladrillos del piso
	bl draw_floor

	mov x1, #100
	mov x2, #50
	bl standar_cloud
	bl draw_floor
	

//Tubo
	mov x20,x0
	mov x15,TUBO_X
	mov x16,TUBO_Y
	bl draw_pipe
	
//Mario
	mov x15,100
	mov x16,FLOOR_HEIGH
	bl draw_mario



   //---------------------------------------------------------------
   // Infinite Loop
 
InfLoop:
	b InfLoop

 