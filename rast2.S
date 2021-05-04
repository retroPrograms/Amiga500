;ScoopexUs	Amiga Hardware Programming 2
init:
	move #$ac,d7	;start y position
	move #1,d6	;y add
	move	$dff01c,d5
	move #$7fff,$dff09a	;disable all bits in INTENA	
*********************************************************************
mainloop:

wframe:
	btst	#0,$dff005
	bne	wframe

	cmp.b	#$2c,$dff006
	bne	wframe
	move.w	#$000,$dff180
	
;-------------frame loop start --------------------------------------	

	add d6,d7	;add "1" to y position
	
	cmp #$f0,d7	;bottom check $f0
	blo	ok1	
	neg d6		;change direction
ok1:	
	
	cmp.b	#$40,d7
	bhi	ok2
	neg d6		;change direction
ok2:
		
waitras1:
	cmp.b	$dff006,d7
	bne	waitras1
	move.w	#$fff,$dff180


waitras2:
	cmp.b	$dff006,d7
	beq	waitras2
	move.w	#$126,$dff180


;-------------frame loop stop  --------------------------------------


	btst	#6,$bfe001	;test bit 6 (left mouse button)
	bne	mainloop
*********************************************************************
exit:
	or #$8000,d5
	move d5,$dff09a
	rts


