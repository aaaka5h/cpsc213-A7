.pos 0x0
    ld   $sb, r5         # r5 = &stack bottom
    inca r5              # r5 = &value above stack bottom 
    gpc  $6, r6          # ra = pc + 6
    j    0x300           # jump to procedure at 0x300
    halt                 # halt

.pos 0x100
    .long 0x00001000     # x = 0x0000 1000 (points to address of array)

.pos 0x200               # bar()
    ld   (r5), r0        # r0 = i = 3 = value of first local var
    ld   4(r5), r1       # r1 = j = 4 = value of second local var
    ld   $0x100, r2      # r2 = &x
    ld   (r2), r2        # r2 = x
    ld   (r2, r1, 4), r3 # r3 = x[i]
    add  r3, r0          # i += x[i]
    st   r0, (r2, r1, 4) # x[j] = i
    j    (r6)            # return

.pos 0x300               # foo()
    ld   $-12, r0        # r0 = -12
    add  r0, r5          # allocate space for two local vars and ra (callee prologue)
    st   r6, 8(r5)       # store ra on stack
    ld   $1, r0          # r0 = i = 1 = first local var
    st   r0, (r5)        # store first local var on stack
    ld   $2, r0          # r0 = j = 2 = second local var
    st   r0, 4(r5)       # store second local var on stack
    ld   $-8, r0         # r0 = -8
    add  r0, r5          # allocate space for args (caller prologue)
    ld   $3, r0          # r0 = 3 = first arg
    st   r0, (r5)        # store first arg on stack
    ld   $4, r0          # r0 = 4 = second arg
    st   r0, 4(r5)       # store second arg on stack
    gpc  $6, r6          # ra = pc + 6
    j    0x200           # jump to procedure at 0x200 (bar)
    ld   $8, r0          # r0 = 8
    add  r0, r5          # deallocate two bytes of space on stack (caller epilogue)
    ld   (r5), r1        # r1 = i = first local var
    ld   4(r5), r2       # r2 = j = second local var
    ld   $-8, r0         # r0 = -8
    add  r0, r5          # allocate space on stack for args (caller prologue)
    st   r1, (r5)        # store first arg on stack
    st   r2, 4(r5)       # store second arg on stack
    gpc  $6, r6          # ra = pc + 6
    j    0x200           # jump to procedure at 0x200 (bar)
    ld   $8, r0          # r0 = 8
    add  r0, r5          # deallocate two bytes of space on stack (caller epilogue)
    ld   8(r5), r6       # load return address into r6
    ld   $12, r0         # r0 = 12
    add  r0, r5          # deallocate remaining space on stack (callee epilogue)
    j    (r6)            # return

.pos 0x1000
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

.pos 0x8000
    # These are here so you can see (some of) the stack contents
    # while running the code on the simulator.
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