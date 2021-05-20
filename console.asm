;Console INIT
		
	SECTION TEXT		;CODE Section

	
       jsr Init
	
       jsr NewLine
       jsr NewLine
       
       move.w #459,(strLen)
       move.l #message,d2 
       jsr PrintStr

	jsr NewLine			;Start a new line	
       jsr NewLine
       jsr NewLine
	
	rts					;Return to OS
	




PrintStr:
	moveM.l d0-d3/a0,-(sp)
		;move.b d0,(CharBuffer)		;Save character into buffer
		;move.l    
		move.l (doshandle),a0		;Dos Handle
		move.l (consolehandle),d1	;Console handle
		;move.l #strBuffer,d2		;Dosbase in a6
             move.l #0,d3
             move.w (strLen),d3

		;move.l #15,d3				;buffer length (1 byte)
		jsr	(-48,a0)				;Call "Dos: Write"
		
	moveM.l (sp)+,d0-d3/a0
	rts


PrintString:
	move.b (a3)+,d0		;Read a character in from A3
	cmp.b #255,d0
	beq PrintString_Done;return on 255
	jsr PrintChar		;Print the Character
	bra PrintString
PrintString_Done:		
	rts

NewLine:
	move.b #$0D,d0		;Char 13 CR
	jsr PrintChar
	move.b #$0A,d0		;Char 10 LF
	jsr PrintChar
	rts

PrintChar:
	moveM.l d0-d3/a0,-(sp)
		move.b d0,(CharBuffer)		;Save character into buffer
		
		move.l (doshandle),a0		;Dos Handle
		move.l (consolehandle),d1	;Console handle
		move.l #CharBuffer,d2		;Dosbase in a6
		move.l #1,d3				;buffer length (1 byte)
		jsr	(-48,a0)				;Call "Dos: Write"
		
	moveM.l (sp)+,d0-d3/a0
	rts

Init:
       lea dosname,a1 		;'dos.library' defined in chip ram
	moveq.l	#0,d0		;Version
	move.l	$4,a6		;Load base for call from addr $4
	jsr	(-552,a6)		;Exec - Openlibrary - return DosBase in D0
	
	move.l d0,(DosHandle);Save DOS Base to handle name
	
	move.l d0,a6		;Dos base
	move.l #consolename,d1;'CONSOLE:'
	move.l #1005,d2		;ModeOld
	jsr	(-30,a6)		;Dos: Open (D0=Console Handle)

	move.l d0,(ConsoleHandle)	;Save Console Handle

       rts
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
dosname: 		dc.b 'dos.library',0	;Library name
consolename:  	dc.b  'CONSOLE:',0		;Console handle


	

	even

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;Chip Ram
		
	Section ChipRAM,Data_c	;Request 'Chip Ram' area memory 
								
DosHandle: 		dc.l 0			;Dos Handle
ConsoleHandle: 	dc.l 0			;Console Handle
CharBuffer: 	dc.b 0			;Character we want to print

strBuffer: 	dc.b "**** New Console ****"			;Character we want to print
strLen:      dc.w 0                                     ;string length

message:
    	dc.b 83,111,99,46,32,65,110,100,32
	dc.b 119,104,101,110,32,119,101,32,104
	dc.b 97,100,32,103,105,118,101,110,32
	dc.b 116,111,32,101,97,99,104,32,111
	dc.b 110,101,32,116,104,97,116,32,115
	dc.b 105,110,103,108,101,32,101,109,112
	dc.b 108,111,121,109,101,110,116,32,97
	dc.b 110,100,10,112,97,114,116,105,99
	dc.b 117,108,97,114,32,97,114,116,32
	dc.b 119,104,105,99,104,32,119,97,115
	dc.b 32,115,117,105,116,101,100,32,116
	dc.b 111,32,104,105,115,32,110,97,116
	dc.b 117,114,101,44,32,119,101,32,115
	dc.b 112,111,107,101,32,111,102,32,116
	dc.b 104,111,115,101,32,119,104,111,10
	dc.b 119,101,114,101,32,105,110,116,101
	dc.b 110,100,101,100,32,116,111,32,98
	dc.b 101,32,111,117,114,32,119,97,114
	dc.b 114,105,111,114,115,44,32,97,110
	dc.b 100,32,115,97,105,100,32,116,104
	dc.b 97,116,32,116,104,101,121,32,119
	dc.b 101,114,101,32,116,111,32,98,101
	dc.b 32,103,117,97,114,100,105,97,110
	dc.b 115,10,111,102,32,116,104,101,32
	dc.b 99,105,116,121,32,97,103,97,105
	dc.b 110,115,116,32,97,116,116,97,99
	dc.b 107,115,32,102,114,111,109,32,119
	dc.b 105,116,104,105,110,32,97,115,32
	dc.b 119,101,108,108,32,97,115,32,102
	dc.b 114,111,109,32,119,105,116,104,111
	dc.b 117,116,44,32,97,110,100,10,116
	dc.b 111,32,104,97,118,101,32,110,111
	dc.b 32,111,116,104,101,114,32,101,109
	dc.b 112,108,111,121,109,101,110,116,59
	dc.b 32,116,104,101,121,32,119,101,114
	dc.b 101,32,116,111,32,98,101,32,109
	dc.b 101,114,99,105,102,117,108,32,105
	dc.b 110,32,106,117,100,103,105,110,103
	dc.b 32,116,104,101,105,114,10,115,117
	dc.b 98,106,101,99,116,115,44,32,111
	dc.b 102,32,119,104,111,109,32,116,104
	dc.b 101,121,32,119,101,114,101,32,98
	dc.b 121,32,110,97,116,117,114,101,32
	dc.b 102,114,105,101,110,100,115,44,32
	dc.b 98,117,116,32,102,105,101,114,99
	dc.b 101,32,116,111,32,116,104,101,105
	dc.b 114,10,101,110,101,109,105,101,115
	dc.b 44,32,119,104,101,110,32,116,104
	dc.b 101,121,32,99,97,109,101,32,97
	dc.b 99,114,111,115,115,32,116,104,101
	dc.b 109,32,105,110,32,98,97,116,116,255
