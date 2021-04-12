start:
		lea	buffer,a0
		move.l	#100,d0

loop:

		move.b	#$5f,(a0,d0)
		sub.l	#1,d0
		bne loop


		rts
		
buffer:		DCB.B 2000
	

