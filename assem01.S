start:
	move.l	#buffer,a0
	move.w	#1999,d0
	move.b	#70,d1
	
loop:
	move.b	d1,(a0,d0)	
	sub.l	#1,d0
	bne	loop
	move.b	d1,(a0,d0)
	
	rts


buffer:
	dcb.b 	2000


