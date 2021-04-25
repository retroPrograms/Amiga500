start:
	move.l #100,d0
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(sp)+,d0-d7/a0-a6
	
	move.l	#696969,d1
	
	movem.l	d1,-(sp)
	movem.l (sp)+,d3	
	
	
	rts	


