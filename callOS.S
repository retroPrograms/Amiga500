OpenLib		=	-30-378
closelib	=	-414
ExecBase	=	4












dosename:
	dc.b	'dos.library',0,0
	even
dosbase:
	dc.l	0
consolname:
	dc.b	'CON:0/100/640/100/** CLI-Test **',0
	even
conhandle:
	dc.l	0

