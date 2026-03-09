extrn ExitProcess : proc        ; Declare external function ExitProcess

.DATA                           ; Directive; Enter .data section

numbers QWORD 1,82,4,9,17,214,0,52

sum qword 0
n qword 0

.CODE                           ; Directive: Enter .code section

main PROC                       ; Directive: Begin function labeled `main`

    sub rsp, 28h                ; Bump 8 bytes to ensure 16 byte alignment. Reserve 32 bytes shadow space.
    ; -------------------- /\ PROLOGUE /\ --------------------

    Whileloop:

        cmp n, 105
        Jge Endloop

        add n, 5
        add sum, n

        Jmp Whileloop

    Endloop:


    ; -------------------- \/ EPILOGUE \/ --------------------
    ; Put the return value in the RCX register before the call instruction executes.
    call ExitProcess            ; Use Windows API to exit the process

main ENDP                       ; Directive: End function labeled `main`

END
