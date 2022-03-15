ld $7, r1           # r1 = size
gpc $4, r0          # r0 = &buffer????
sys $2              # exec
halt                # halt

.long 0x2f62696e    # ASCII: /bin (size: 4)
.long 0x2f73680a    # ASCII: /sh  (size: 3)