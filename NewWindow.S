;Mapping the Amiga page 7

;	INCLUDE "Intuition/intuition.i"

OpenLibrary	equ	-552
CloseLibrary	equ	-414
OpenWindow	equ	-204
CloseWindow	equ	-72
Wait		equ	-318
ExecBase	equ	4

	SECTION code,CODE
	
	movea.l	#IntuitionName,a1
	move.l	#0,d0
	movea.l	ExecBase,a6
	jsr	OpenLibrary(a6)
	move.l	d0,_IntuitionBase
	beq.s 	Abort2
	
Abort2:
	clr.l	d0
	rts



	SECTION data,DATA

MyNewWindow:
	dc.w	0,12
	dc.w	200,100
	dc.b	-1,-1
	dc.l	CLOSEWINDOW
	;dc.l	WINDOWCLOSE!WINDOWDEPTH!WINDOWDRAG!WINDOWSIZING!ACTIVATE
	dc.l	0
	dc.l	0
	dc.l	WindowTitle
	dc.l	0
	dc.l	0
	dc.w	80,24
	dc.w	-1,-1
	;dc.w	WBENCHSCREEN

IntuitionName:
	dc.b	'intuition.library',0
WindowTitle:
	dc.b	'Close Me',0


	SECTION	mem,BSS

_IntuitionBase:
	ds.l	1
MyWindow
	ds.l	1
