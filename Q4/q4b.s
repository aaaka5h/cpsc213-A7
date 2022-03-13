.pos 0x100
start:
    ld   $sb, r5         # r5 = pointer to stack bottom
    inca r5              # r5 = &word after stack
    gpc  $6, r6          # set the return address
    j    main            # jump to main
    halt                 # halt

f:
    deca r5              # allocate 1 byte of space on stack
    ld   $0, r0          # r0 = j' = 0
    ld   4(r5), r1       # r1 = k = arg = x[i']
    ld   $0x80000000, r2 # r2 = 0x80000000
f_loop:
    beq  r1, f_end       # goto f_end if (k == 0)
    mov  r1, r3          # r3 = k
    and  r2, r3          # r3 = 0x80000000 & k
    beq  r3, f_if1       # goto f_if1 if ((0x80000000 & k) > 0)
    inc  r0              # j'++
f_if1:
    shl  $1, r1          # k = 2*k
    br   f_loop          # goto f_loop
f_end:
    inca r5              # deallocate 1 byte of space on stack
    j    (r6)            # return

main:
    deca r5              # allocate 1 byte of space on stack 
    deca r5              # allocate 1 more byte of space on stack
    st   r6, 4(r5)       # save return address onto stack (end of callee epilogue)
    ld   $8, r4          # r4 = i' = 8 
main_loop:
    beq  r4, main_end    # goto main_end if (i' == 0)
    dec  r4              # i'--
    ld   $x, r0          # r0 = &x
    ld   (r0, r4, 4), r0 # r0 = x[i']
    deca r5              # allocate 1 byte of space on stack for arg (caller prologue)
    st   r0, (r5)        # store arg on stack
    gpc  $6, r6          # set the return address
    j    f               # jump to f
    inca r5              # deallocate 1 byte of space on stack
    ld   $y, r1          # r1 = &y
    st   r0, (r1, r4, 4) # y[i'] = return value of f
    br   main_loop       # goto main_loop
main_end:
    ld   4(r5), r6       # load return address into r6
    inca r5              # deallocate 1 byte of space on stack
    inca r5              # deallocate last remaining byte of space on stack
    j    (r6)            # return

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long -1
    .long -2
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0