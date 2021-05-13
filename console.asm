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
      ;jsr deCypher
	bsr	init
	bsr	test
       
	nop
	bra	qu
	
test:
	move.l	#title,d0
	bsr	pmsg
	bsr	pcrlf
	bsr	pcrlf

      jsr   deCypher

waitmouse:
       btst #6,$bfe001
       bne waitmouse
       rts
	
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
	jsr	openfile
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
	movem.l	(sp)+,d0-d7/a0-a6
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

deCypher:
            
              movem.l	d0-d7/a0-a6,-(sp)
	
		lea	cypher,a0
		lea	buffer,a1
		lea 	key,a2
		move.l	#0,d0	;for cypher,buffer
		move.l 	#0,d2	;for key
loop:

		move.b	(a2,d2),d3	;get next key
		add.l	#1,d2
		cmp	#3,d2
		bne	key_ok
		move.l	#0,d2
		
key_ok:
		move.b	(a0,d0),d1	;get cypher num
		
		cmp #255,d1
		beq finished

				
		eor d3,d1		;xor cypher num and key
		
		move.b d1,(a1,d0)
		add.l	#1,d0
		
		bra loop

finished:
            movem.l	(sp)+,d0-d7/a0-a6
		rts
	
dosname:
	dc.b	 'dos.library',0,0
	even
dosbase:
	dc.l	0
	
consolname:
	dc.b 'CON:0/100/640/100/My Screen',0
	even
conhandle:
	dc.l 0
title2:
	dc.b '** Welcome to this program! **'
outline2:
	dc.w 0	

title:
        dc.b 'Soc. And you remember how we said that the children of the good parents were to be educated, and the children of the bad secretly dispersed among the inferior citizens; and while they were all growing up the rulers were to be on the look-out, and to bring up from below in their turn those who were worthy, and those among themselves who were unworthy were to take the places of those who came up?'
outline:
        dc.w 0
        
buffer:	   DCB.B 2000	
	
key:       DC.B $67, $6f, $64

cypher:  
	   DC.B 79,59,12,2,79,35,8,28,20,2,3,68,8,9,68,45,0,12,9,67
	   DC.B 68,4,7,5,23,27,1,21,79,85,78,79,85,71,38,10,71,27,12
	   DC.B 2,79,6,2,8,13,9,1,13,9,8,68,19,7,1,71,56,11,21,11,68
	   DC.B 6,3,22,2,14,0,30,79,1,31,6,23,19,10,0,73,79,44,2,79
	   DC.B 19,6,28,68,16,6,16,15,79,35,8,11,72,71,14,10,3,79,12
	   DC.B 2,79,19,6,28,68,32,0,0,73,79,86,71,39,1,71,24,5,20,79
	   DC.B 13,9,79,16,15,10,68,5,10,3,14,1,10,14,1,3,71,24,13,19
	   DC.B 7,68,32,0,0,73,79,87,71,39,1,71,12,22,2,14,16,2,11,68
	   DC.B 2,25,1,21,22,16,15,6,10,0,79,16,15,10,22,2,79,13,20,65
	   DC.B 68,41,0,16,15,6,10,0,79,1,31,6,23,19,28,68,19,7,5,19,79
	   DC.B 12,2,79,0,14,11,10,64,27,68,10,14,15,2,65,68,83,79,40
	   DC.B 14,9,1,71,6,16,20,10,8,1,79,19,6,28,68,14,1,68,15,6,9
	   DC.B 75,79,5,9,11,68,19,7,13,20,79,8,14,9,1,71,8,13,17,10
	   DC.B 23,71,3,13,0,7,16,71,27,11,71,10,18,2,29,29,8,1,1,73,79
	   DC.B 81,71,59,12,2,79,8,14,8,12,19,79,23,15,6,10,2,28,68,19
	   DC.B 7,22,8,26,3,15,79,16,15,10,68,3,14,22,12,1,1,20,28,72,71
	   DC.B 14,10,3,79,16,15,10,68,3,14,22,12,1,1,20,28,68,4,14,10
	   DC.B 71,1,1,17,10,22,71,10,28,19,6,10,0,26,13,20,7,68,14,27
	   DC.B 74,71,89,68,32,0,0,71,28,1,9,27,68,45,0,12,9,79,16,15,10
	   DC.B 68,37,14,20,19,6,23,19,79,83,71,27,11,71,27,1,11,3,68,2
	   DC.B 25,1,21,22,11,9,10,68,6,13,11,18,27,68,19,7,1,71,3,13,0
	   DC.B 7,16,71,28,11,71,27,12,6,27,68,2,25,1,21,22,11,9,10,68,10
	   DC.B 6,3,15,27,68,5,10,8,14,10,18,2,79,6,2,12,5,18,28,1,71,0,2
	   DC.B 71,7,13,20,79,16,2,28,16,14,2,11,9,22,74,71,87,68,45,0,12
	   DC.B 9,79,12,14,2,23,2,3,2,71,24,5,20,79,10,8,27,68,19,7,1,71
	   DC.B 3,13,0,7,16,92,79,12,2,79,19,6,28,68,8,1,8,30,79,5,71,24
	   DC.B 13,19,1,1,20,28,68,19,0,68,19,7,1,71,3,13,0,7,16,73,79,93
	   DC.B 71,59,12,2,79,11,9,10,68,16,7,11,71,6,23,71,27,12,2,79,16
	   DC.B 21,26,1,71,3,13,0,7,16,75,79,19,15,0,68,0,6,18,2,28,68,11
	   DC.B 6,3,15,27,68,19,0,68,2,25,1,21,22,11,9,10,72,71,24,5,20,79
	   DC.B 3,8,6,10,0,79,16,8,79,7,8,2,1,71,6,10,19,0,68,19,7,1,71,24
	   DC.B 11,21,3,0,73,79,85,87,79,38,18,27,68,6,3,16,15,0,17,0,7,68
	   DC.B 19,7,1,71,24,11,21,3,0,71,24,5,20,79,9,6,11,1,71,27,12,21
	   DC.B 0,17,0,7,68,15,6,9,75,79,16,15,10,68,16,0,22,11,11,68,3,6,0
	   DC.B 9,72,16,71,29,1,4,0,3,9,6,30,2,79,12,14,2,68,16,7,1,9,79,12
	   DC.B 2,79,7,6,2,1,73,79,85,86,79,33,17,10,10,71,6,10,71,7,13,20
	   DC.B 79,11,16,1,68,11,14,10,3,79,5,9,11,68,6,2,11,9,8,68,15,6,23
	   DC.B 71,0,19,9,79,20,2,0,20,11,10,72,71,7,1,71,24,5,20,79,10,8,27
	   DC.B 68,6,12,7,2,31,16,2,11,74,71,94,86,71,45,17,19,79,16,8,79,5
	   DC.B 11,3,68,16,7,11,71,13,1,11,6,1,17,10,0,71,7,13,10,79,5,9,11
	   DC.B 68,6,12,7,2,31,16,2,11,68,15,6,9,75,79,12,2,79,3,6,25,1,71
	   DC.B 27,12,2,79,22,14,8,12,19,79,16,8,79,6,2,12,11,10,10,68,4,7
	   DC.B 13,11,11,22,2,1,68,8,9,68,32,0,0,73,79,85,84,79,48,15,10,29
	   DC.B 71,14,22,2,79,22,2,13,11,21,1,69,71,59,12,14,28,68,14,28,68
	   DC.B 9,0,16,71,14,68,23,7,29,20,6,7,6,3,68,5,6,22,19,7,68,21,10
	   DC.B 23,18,3,16,14,1,3,71,9,22,8,2,68,15,26,9,6,1,68,23,14,23,20
	   DC.B 6,11,9,79,11,21,79,20,11,14,10,75,79,16,15,6,23,71,29,1,5,6
	   DC.B 22,19,7,68,4,0,9,2,28,68,1,29,11,10,79,35,8,11,74,86,91,68
	   DC.B 52,0,68,19,7,1,71,56,11,21,11,68,5,10,7,6,2,1,71,7,17,10,14
	   DC.B 10,71,14,10,3,79,8,14,25,1,3,79,12,2,29,1,71,0,10,71,10,5,21
	   DC.B 27,12,71,14,9,8,1,3,71,26,23,73,79,44,2,79,19,6,28,68,1,26,8
	   DC.B 11,79,11,1,79,17,9,9,5,14,3,13,9,8,68,11,0,18,2,79,5,9,11,68
	   DC.B 1,14,13,19,7,2,18,3,10,2,28,23,73,79,37,9,11,68,16,10,68,15
	   DC.B 14,18,2,79,23,2,10,10,71,7,13,20,79,3,11,0,22,30,67,68,19,7,1
	   DC.B 71,8,8,8,29,29,71,0,2,71,27,12,2,79,11,9,3,29,71,60,11,9,79
	   DC.B 11,1,79,16,15,10,68,33,14,16,15,10,22,73,255



