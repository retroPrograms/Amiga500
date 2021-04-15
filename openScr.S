OpenLib		=       -30-378	
closelib	=	-414
;ExecBase	=	4

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
	lea	dosname(pc),al
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

