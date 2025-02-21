Title 221 Project 01 Hello Ricardo (221Proj01.asm)

; author: Ricardo Gaeta
; Course: csc221
; project: 01
; date: 2/19/2025
; description: basic hello world program
;

;include the libs  and defs

INCLUDE C:\Irvine\Irvine32.inc

INCLUDELIB C:\Irvine\Irvine32.lib
INCLUDELIB C:\Irvine\Kernel32.lib
INCLUDELIB C:\Irvine\User32.lib

.data ;vars
	msg	BYTE "Hello Ricardo!", 14
	msgtoo BYTE " Good Bye Cruel World!", 13,10,0

.code ;start of code segment

	main PROC ;start of main procedure

	mov EDX, OFFSET msg
	call WriteString

	exit

main ENDP ;end of main code
END main ;end of program, point to main
