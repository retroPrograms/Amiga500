start:
	move.l	#buffer,a0
	move.w	#1999,d0
	move.b	#32,d1
	
loop:
	move.b	d1,(a0,d0)
	add.b	#1,d1
	cmp	#126,d1
	beq	res_asc
	add.b	#1,d1	
	sub.l	#1,d0
	bne	loop
res_ret:
	move.b	d1,(a0,d0)
	
	rts

res_asc:
	move.b	#32,d1
	bra	res_ret	

buffer:
	dcb.b 	2000


