SysBase         = 4     ;a2 http://teleinfo.pb.edu.pl/krashan/new/amiga-assembler-and-system
OpenLibrary     = -552
CloseLibrary    = -414
PutStr          = -948
           
                      
           LEA     DosName,A1
           MOVEQ   #36,D0
           MOVEA.L SysBase,A6
           JSR     OpenLibrary(A6)

           TST.L   D0
           BEQ.S   NoDos

           MOVE.L  #Hello,D1
           MOVEA.L D0,A6
           JSR     PutStr(A6)

           MOVEA.L A6,A1
           MOVEA.L SysBase,A6
           JSR     CloseLibrary(A6)
 
NoDos:     CLR.L   D0
           RTS
 
DosName    DC.B    "dos.library",0
Hello      DC.B    "Hello World!",10,0