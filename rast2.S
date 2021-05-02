;ScoopexUs	Amiga Hardware Programming 2

mainloop:

waitras1:
	cmp.b	#$ac,$dff006
	bne	waitras1
	move.w	#$fff,$dff180


waitras2:
	cmp.b	#$ac,$dff006
	beq	waitras2
	move.w	#$126,$dff180





	btst	#6,$bfe001	;test bit 6 (left mouse button)
	bne	mainloop
	rts


