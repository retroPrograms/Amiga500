;-----------------ScoopexUS YouTube initial code----------------------

init:

	move.l	4.w,a6		:execbase
	clr.l d0
	move.l	#gfxname,a1
	jsr -408(a6)		;oldopenlibrary()
	move.l d0,a1
	move.l 38(a1),d4	;original copper ptr
	
	jsr -414(a6)		;closelibrary()
	
	
	move #$ac,d7	;start y position
	move #1,d6	;y add
	move $dff01c,d5
	move #$7fff,$dff09a	;disable all bits in INTENA
	
	move.l #copper,$dff080
	
**********************************************************************


mainloop:
wframe:
	btst #0,$dff005
	bne wframe
	cmp.b #$2c,$dff006
	bne wframe
;	move.w #$000,$dff180
	
;-------------frame loop start----------------------------------------
	
	add d6,d7	;add "1" to y position
	
	cmp #$f0,d7	;bottom check
	blo ok1
	neg d6		;change direction
	
ok1:

	cmp.b #$40,d7
	bhi ok2
	neg d6		;change direction
	
ok2:

waitras1:
	cmp.b $dff006,d7
	bne waitras1
	move.w #$fff,$dff180


waitras2:
	cmp.b $dff006,d7
	beq waitras2
	move.w #$113,$dff180
	
;-------------frame loop start----------------------------------------



	btst #6,$bfe001
	bne mainloop
	
**********************************************************************
exit:
	move.l d4,$dff080
	or #$c000,d5
	move d5,$dff09a
	rts

gfxname:
	dc.b "graphics.library",0


	SECTION tut,DATA_C



Copper:
	dc.w	$1fc,0		;slow fetch mode, AGA compatibility
	dc.w	$100,$0200	;$df100
	dc.w	$180,$349
	dc.w 	$2b07,$fffe
	dc.w 	$180,$56b
	dc.w 	$2c07,$fffe
	dc.w 	$180,$113

	dc.w	$ffdf,$fffe	
	dc.w 	$2c07,$fffe
	dc.w 	$180,$56c
	dc.w 	$2d07,$fffe
	dc.w 	$180,$349
	
	
	
	
	dc.w	$ffff,$fffe
	
	;yt 20 num 6	
