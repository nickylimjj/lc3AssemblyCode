PUSH
; pushes a value (from R0) onto the stack
; IN: R0 (value)
; OUT: R5 (0 if success; 1 if fail)
; Register Table
; R3 - STACK_END
; R4 - STACK_TOP
    
    ; prepare registers
    ST R3, Save_R3      ; save R3
    ST R4, Save_R4      ; save R4
    AND R5, R5, #0      ; clear R5
    LD R3, STACK_END
    LD R4, STACK_TOP

    ; check for overflow
    ADD R3, R3, #-1     ; if pointer is above the stack
    NOT R3, R3
    ADD R3, R3, #1
    ADD R3, R3, R4
    BRz OVERFLOW        ; stack is full

    ; store value in stack
    STR R0, R4, #0      ; push onto the stack
    ADD R4, R4, #-1     ; move the stack pointer to next available slot
    ST R4, STACK_TOP
    BRnzp DONE_PUSH

OVERFLOW ADD R5, R5, #1

    ; restore registers
DONE_PUSH
    LD R3, Save_R3      ; save R3
    LD R4, Save_R4      ; save R4

    RET

;data
Save_R3     .BLKW   #1
Save_R4     .BLKW   #1
STACK_TOP   .FILL   X4000
STACK_END   .FILL   X3FF0

