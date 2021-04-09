MoveScreen 	= -162
OpenScreen	= -198
CloseScreen	= -66
CloseLibrary	= -414
OpenLib		= -408
ExecBase	= 4
joy2		= $dff00c
fire 		= $bfe001

run:
	bsr	openint
	bsr	scropen
	
	move	joy2,d6
loop:
	tst.b	fire
	bpl	ende
	move	joy2,d0
	sub	d6,d0
	cmp	#$0100,d0
	bne	noup
	move.l	#-1,d1
	bsr	 scrmove
	bra loop
	
noup:
	cmp	#$0001,d0
	bne	 loop
	move.l 	#1,d1
	bsr	scrmove
	bra	loop
	
ende:
	bsr     scrclose
	bsr	closeint
	rts
	
openint:
	move.l	ExecBase,a6
	lea 	IntName,a1
	jsr	OpenLib(a6)
	move.l	d0,intbase
	rts

closeint:
	move.l  execbase,a6
	move.l	intbase,a1
	jsr	CloseLibrary(a6)
	rts
	
scropen:
	move.l intbase,a6
	lea screen_defs,a0
	jsr OpenScreen(a6)
	move.l	d0,screenhd
	rts
	
scrclose:
	move.l	intbase,a6
	move.l 	screenhd,a0
	jsr CloseScreen(a6)
	rts
	
scrmove:
	move.l	intbase,a6
	move.l	screenhd,a0
	clr.l	d0
	jsr MoveScreen(a6)
	rts	

Out:
	rts
	
	
screen_defs:

x_pos:		dc.w	0
y_pos:		dc.w	0
width:		dc.w	320
height:		dc.w	200
depth:		dc.w	2
detail_pen:	dc.b	1
block_pen:	dc.b	3
view_modes:	dc.w	2
screen_type:	dc.w	15
font:		dc.l	0
title:		dc.l	sname
gadgets:	dc.l	0
bitmap:		dc.l	0


intbase:	dc.l	0

screenhd:	dc.l	0

IntName:
	dc.b 'intuition.library',0
;	align
sname:
	dc.b 'Our Screen',0 
;	align	

DOS          dc.b    'dos.library',0
HelloWorld   dc.b    'Hello World!',$A,0
