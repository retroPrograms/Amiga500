MoveScreen 	= -162
OpenScreen	= -198
CloseScreen	= -66
CloseLibrary	= -414
OpenLib	= -408
ExecBase	= 4
Write		= -48
mode_old	= 1005
joy2		= $dff00c
fire 		= $bfe001

run:
	bsr	openint
	bsr	scropen
       bsr Init

waitmouse:
       btst #6,$bfe001
       bne waitmouse
       
       bsr scrclose
       bsr closeint
       rts

Init:              
       move.l	ExecBase,a6
	lea	dosname(pc),a1 ;dosname(pc),al
	moveq	#0,d0
	jsr	openlib(a6)
	move.l	d0,dosbase
	;beq	error
	
	lea 	consolname(pc),a1
	move.l	#mode_old,d0
	;bsr	openfile
	;beq	error
	move.l	d0,conhandle
       rts
	
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

pmsg:
        
	movem.l	d0-d7/a0-a6,-(sp)
        
	move.l	d0,a0
	move.l	a0,d2
	clr.l	d3
       move.l	#title1,d0
ploop:
	tst.b	(a0)+
	beq	pmsg2
	addq.l	#1,d3
	bra	ploop
pmsg2:
	move.l	conhandle,d1
	move.l	dosbase,a6
	jsr	write(a6)
	movem.l	(sp)+,d0-d7/a0-a6
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
        even
sname:
	dc.b 'Our Screen',0 
        even

DOS          dc.b    'dos.library',0
HelloWorld   dc.b    'Hello World!',$A,0

dosbase:
	dc.l	0
	

conhandle:
	dc.l 0

dosname:
	dc.b	 'dos.library',0,0
	even

consolname:
	dc.b 'CON:0/100/640/100/** CLI-Test **',0
	even

title1:
	dc.b '** Hello World! **'
