
; Program project 03 RevStr
; Program Description: Reverse a user given string using indirect addressing and a procedure  
; Author: Ricardo Gaeta   
; Revisions: 1
; Date: 3/24/2025

INCLUDE C:\Irvine\Irvine32.inc
INCLUDELIB C:\Irvine\Irvine32.lib
INCLUDELIB C:\Irvine\Kernel32.lib
INCLUDELIB C:\Irvine\User32.lib

.data 
    source BYTE 50 DUP ('#')                 ; Input buffer initialized with '#'
    destination BYTE SIZEOF source DUP ('$') ; Output buffer initialized with '$'
    len DWORD 0                              ; Actual length of input string
    prompt BYTE "Enter a short string: ",0   ; prompt message

.code

; RevStr Procedure
; Description: Reverses a string using indirect addressing

RevStr PROC
    L1:
        mov al, [esi]       ; Load character from source
        mov [edi], al       ; Store in destination start
        dec esi             ; Move to previous source character
        inc edi             ; Move to next destination position
        loop L1             ; Repeat for all characters

    ; Add null terminator at the end of reversed string
    mov byte ptr [edi], 0
    ret
RevStr ENDP    ; End of Reverse String Procedure

main PROC
    ; Prompt user for input
    mov edx, OFFSET prompt
    call WriteString

    ; Read string into source
    mov edx, OFFSET source
    mov ecx, SIZEOF source - 1  ; Max chars to read (plus null)
    call ReadString
    mov len, eax            ; Save actual string length

    ; Set up parameters for RevStr
    mov esi, OFFSET source
    add esi, len                ; Point ESI to last character in source
    dec esi
    mov edi, OFFSET destination ; EDI points to start of destination
    mov ecx, len                ; ECX = number of characters to reverse

    call RevStr                 ; Reverse the string

    ; display reversed string
    mov edx, OFFSET destination
    call WriteString
    call Crlf               ; new line

    exit
main ENDP

END main