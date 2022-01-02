# Operands to multiply
.data
a: .word 0xBAD
b: .word 0xFEED

.text
main:   # Load data from memory
		la      t3, a
        lw      t3, 0(t3)
        la      t4, b
        lw      t4, 0(t4)

        # t6 will contain the result
        add		t6, x0, x0

        # Mask for 16x8=24 multiply
        ori		t0, x0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff

####################
# Start of your code

# Use the code below for 16x8 multiplication
#   mul		<PROD>, <FACTOR1>, <FACTOR2>
#   and		<PROD>, <PROD>, t0

        addi t1, x0, 2
        addi t2, x0, 0
        addi s8, x0, 0xff
        addi s9, x0, 0
        addi s10, x0, 8

        beq t4, x0, finish

mult_loop:
        beq t2, t1, finish

        mul s9, t2, s10
        sll s8, s8, s9

        add t5, x0, t3
        and t5, t5, s8

        beq t5, x0, next_iter

        mul s11, t5, t4
        and s11, s11, t0

        add t6, t6, s11

next_iter:
        addi t2, t2, 1

        j mult_loop

# End of your code
####################

finish: addi    a0, x0, 1
        addi    a1, t6, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall


