;
; File:  		221proj05RGAETA6.asm
; Description:   	Pack Input
; csc221 
; project 05
; malcolm

include irvine32.inc
include macros.inc

.DATA
    ; Prompt messages
    promptDay      BYTE "Enter day (1-31): ",0
    promptMonth    BYTE "Enter month (1-12): ",0
    promptYear     BYTE "Enter year (1980-2107): ",0
    newline        BYTE 0Dh,0Ah,0

    ; Output labels
    packedBinStr   BYTE "Packed date (binary):",0Dh,0Ah,0
    unpackYearStr  BYTE "Unpacked Year: ",0
    unpackMonthStr BYTE "Unpacked Month: ",0
    unpackDayStr   BYTE "Unpacked Day: ",0

    ; Variables
    dayVal   WORD ?      ; Day (1-31)
    monVal   WORD ?      ; Month (1-12)
    yrVal    WORD ?      ; Year adjusted (0-127)
    packedDx WORD ?      ; Packed 16-bit date

.CODE
main PROC
    call Clrscr

    ; Input Section ---

    ;day
    mov edx, OFFSET promptDay
    call WriteString
    call ReadInt
    mov word ptr dayVal, ax

    ;month
    mov edx, OFFSET promptMonth
    call WriteString
    call ReadInt
    mov word ptr monVal, ax

    ;year
    mov edx, OFFSET promptYear
    call WriteString
    call ReadInt
    sub ax, 1980
    mov word ptr yrVal, ax

    mov edx, OFFSET newline
    call WriteString

    ;  Packing Section

    ;day
    mov ax, dayVal
    shl ax, 11          ; Day -> bits 15-11
    mov dx, ax
    
    ;month
    mov ax, monVal
    shl ax, 7           ; Month -> bits 11-7
    add dx, ax

    ;year
    mov ax, yrVal       ; Year -> bits 6-0
    add dx, ax

    mov packedDx, dx

    ; Display Packed Binary
    mov edx, OFFSET packedBinStr
    call WriteString
    movzx eax, packedDx
    call WriteBin
    call Crlf

    ; Unpacking Section ---

    ;year
    mov ax, packedDx
    and ax, 007Fh       ; Mask bits 6-0
    add ax, 1980
    mov word ptr yrVal, ax
    mov edx, OFFSET unpackYearStr
    call WriteString
    movzx eax, yrVal
    call WriteDec
    call Crlf

    ;month
    mov ax, packedDx
    shr ax, 7
    and ax, 000Fh       ; Mask bits 3-0
    mov word ptr monVal, ax
    mov edx, OFFSET unpackMonthStr
    call WriteString
    movzx eax, monVal
    call WriteDec
    call Crlf

    ;day
    mov ax, packedDx
    shr ax, 11
    and ax, 001Fh       ; Mask bits 4-0
    mov word ptr dayVal, ax
    mov edx, OFFSET unpackDayStr
    call WriteString
    movzx eax, dayVal
    call WriteDec
    call Crlf

    exit
main ENDP

END main


