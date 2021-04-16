OpenLib		=       -30-378	
closelib	=	-414
ExecBase	=	4

Open		=	-30
Close		=	-30-6
Write		=	-48
IoErr		=	-132
mode_old	=	1005
alloc_abs	=	-$cc

run:
	bsr	init
	bsr	test
	nop
	bra	qu
	
test:
	move.l	#title,d0
	bsr	pmsg
	bsr	pcrlf
	bsr	pcrlf
	
	rts
	
init:
	move.l	ExecBase,a6
	lea	dosname(pc),a1 ;dosname(pc),al
	moveq	#0,d0
	jsr	openlib(a6)
	move.l	d0,dosbase
	beq	error
	
	lea 	consolname(pc),a1
	move.l	#mode_old,d0
	bsr	openfile
	beq	error
	move.l	d0,conhandle
	rts

pmsg:
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	d0,a0
	move.l	a0,d2
	clr.l	d3
ploop:
	tst.b	(a0)+
	beq	pmsg2
	addq.l	#1,d3
	bra	ploop
pmsg2:
	move.l	conhandle,d1
	move.l	dosbase,a6
	jsr	write(a6)
;	move.l	(sp)+,d0-d7/a0-a6
	rts
	
pcrlf:
	move	#10,d0
	bsr	pchar
	move	#13,d0
pchar:
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	conhandle,d1
pch1:
	lea	outline,a1
	move.b	d0,(a1)
	move.l	a1,d2
	move.l	#1,d3
	move.l	dosbase,a6
	jsr	write(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	
error:
	move.l	dosbase,a6
	jsr	IoErr(a6)
	move.l	d0,d5
	move.l	#-1,d7
qu:
	move.l	conhandle,d1
	move.l	dosbase,a6
	jsr	close(a6)
	move.l	dosbase,a1
	move.l 	ExecBase,a6
	jsr	closelib(a6)
	
openfile:
	move.l	a1,d1
	move.l	d0,d2
	move.l	dosbase,a6
	jsr	open(a6)
	tst.l	d0
	rts
	
dosname:
	dc.b	 'dos.library',0,0

dosbase:
	dc.l	0
	
consolname:
	dc.b 'CON:0/100/640/100/** CLI-Test **',0
conhandle:
	dc.l 0
title:
	dc.b '** Welcome to this program! **'
outline:
	dc.w 0	
