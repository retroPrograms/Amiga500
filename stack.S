start:
	move.l #100,d0
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(sp)+,d0-d7/a0-a6
	
	move.l	#$f3f3f3f3,d1
	
	movem.l	d1,-(sp)
	movem.l (sp)+,d3
	jmp skipto
	jmp *	
skipto:	
	move.l	#3,d0	;set x to 3
	cmp.l	#2,d0
	
	bcc Jumped	;d0>=#?
	;bcs Jumped	;d0<#?
Jumped:	
	
	rts	


