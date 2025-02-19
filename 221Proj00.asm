Title 221 Project 01 0 Hello World (221Proj00.asm)

; author: Ricardo Gaeta
; Course: csc221
; project: 00
; date: 2/19/2025
; description: basic hello world program
;

INCLUDE C:\Irvine\Irvine32.inc

INCLUDELIB C:\Irvine\Irvine32.lib
INCLUDELIB C:\Irvine\Kernel32.lib
INCLUDELIB C:\Irvine\User32.lib

.data
	msg	BYTE "Hello World!", 14
	msgtoo BYTE "Good Bye Cruel World!", 13,10,0

.code

	main PROC

	mov EDX, OFFSET msg
	call WriteString

	exit

main ENDP
END main
