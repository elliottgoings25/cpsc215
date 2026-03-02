extrn ExitProcess : proc        ; Declare external function ExitProcess

.DATA                           ; Directive; Enter .data section

input_var DWORD 5

.CODE                           ; Directive: Enter .code section

main PROC                       ; Directive: Begin function labeled `main`

    sub rsp, 28h                ; Bump 8 bytes to ensure 16 byte alignment. Reserve 32 bytes shadow space.
    ; -------------------- /\ PROLOGUE /\ --------------------

    // if (input_var == 2)
        cmp [input_var], 2  //check if 2

        jne not2    //not 2 jump

        mov rcx, 0  //is 2 return 0
        jmp done

    //else if (input_var == 3 || input_var == 4)
    not2:
        cmp [input_var], 3  //check if 3
            je is3or4   //is 3 jump

        cmp [input_var], 4  //check if 4
            je is3or4   //is 4 jump

        jmp else.   //not 3 or 4 jump

        is3or4: //is 3 or 4 return 1
        mov rcx, 1
        jmp done

    //else return 2
    else.:
        mov rcx, 2  //is not 2, 3, or 4 return 2
    done:

    ; -------------------- \/ EPILOGUE \/ --------------------
    ; Put the return value in the RCX register before the call instruction executes.
    call ExitProcess            ; Use Windows API to exit the process

main ENDP                       ; Directive: End function labeled `main`

END
