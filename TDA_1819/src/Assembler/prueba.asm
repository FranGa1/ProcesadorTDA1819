        .data
num1:   .word 20
        .code
        lw r1, num1(r0)
        dsubi r3, r2, –5
        halt
    