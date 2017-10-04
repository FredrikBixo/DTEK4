

# labwork.S
# Written 2015-2017 by F Lundevall
# Skeleton file for IS1200/IS1500 lab 1.
# The macros PUSH and POP are in the public domain.
# Please add your own code at the end of the file.

#
# Please keep the two macros PUSH and POP unchanged
#
.macro    PUSH reg
addi    $sp,$sp,-4
sw    \reg,0($sp)
.endm

.macro    POP reg
lw    \reg,0($sp)
addi    $sp,$sp,4
.endm
#
# Please add your own code below this line
#

.global delay
.global time2string
.global enable_interrupt
.data
white:  .word   0x00FFFFFF
.align 2
mytime:    .word 0x5957
timstr:    .ascii ""
.text

main:
# print timstr
la    $a0,timstr
li    $v0,4
syscall
nop
# wait a little
li    $a0,50000000
jal    delay
nop
# call tick
la    $a0,mytime
jal    tick
nop
# call your function time2string
la    $a0,timstr
la    $t0,mytime
lw    $a1,0($t0)
jal    time2string
nop
# print a newline
li    $a0,10
li    $v0,11
syscall
nop
# go back and do it all again
j    main
nop
# tick: update time pointed to by $a0
tick:    lw    $t0,0($a0)    # get time
addiu    $t0,$t0,1    # increase
andi    $t1,$t0,0xf    # check lowest digit
sltiu    $t2,$t1,0xa    # if digit < a, okay
bnez    $t2,tiend
nop
addiu    $t0,$t0,0x6    # adjust lowest digit
andi    $t1,$t0,0xf0    # check next digit
sltiu    $t2,$t1,0x60    # if digit < 6, okay
bnez    $t2,tiend
nop
addiu    $t0,$t0,0xa0    # adjust digit
andi    $t1,$t0,0xf00    # check minute digit
sltiu    $t2,$t1,0xa00    # if digit < a, okay
bnez    $t2,tiend
nop
addiu    $t0,$t0,0x600    # adjust digit
andi    $t1,$t0,0xf000    # check last digit
sltiu    $t2,$t1,0x6000    # if digit < 6, okay
bnez    $t2,tiend
nop
addiu    $t0,$t0,0xa000    # adjust last digit
tiend:    sw    $t0,0($a0)    # save updated result
jr    $ra        # return
nop

delay:

li $t0, 0 #counter for for-loop
li $t1, 4711000 # constant

#while-loop
while:
ble  $a0, 0, end # while ms>0, go to end if condition is met
nop
addi $a0, $a0, -1 # ms=ms+1

#nested for-loop
for:
beq $t0, $t1, while # jump back to while-loop if $t0 equals the constant
nop
addi $t0, $t0, 1 # i=i+1

j for #continue looping
nop

end:
jr $ra
nop
# eq a0 = memory adress, a1 = time info NBCD Encoded

time2string:

# save teturn adress
move $t6, $ra

# minutes

andi $a3, $a1, 0x0000F000
srl $a3, $a3, 12
jal hexasc
nop
# li $v0, 48
sb $v0, 0($a0)

andi $a3, $a1, 0x00000F00
srl $a3, $a3, 8
jal hexasc
nop
# li $v0, 48
sb $v0, 1($a0)

# comma
li $t3, 58
sb $t3, 2($a0)


# seconds
andi $a3, $a1, 0x000000F0
srl $a3, $a3, 4
jal hexasc
nop
sb $v0, 3($a0)

andi $a3, $a1, 0x0000000F
jal hexasc
nop
sb $v0, 4($a0)


# null ASCII
li $t3, 0
sb $t3, 5($a0)

andi $a3, $a1, 0x000000FF


beq $a3,0x00,branchr

jr $t6
nop

enable_interrupt:
EI
jr $ra
nop

hexasc:
li  $t0,9
slt $t1, $t0, $a3  # checks if $s0 > $s1
beq $t1,1,over
nop         # if $s0 > $s1, goes to label1
addi $v0, $a3, 48  #
jr  $ra
nop

branchr:
li $t7, 0x44
sb $t7, 0($a0)
li $t7, 0x49
sb $t7, 1($a0)
li $t7, 0x4E
sb $t7, 2($a0)
li $t7, 0x47
sb $t7, 3($a0)

li $t7, 0x00
sb $t7, 4($a0)

jr $t6

over:
addi $v0, $a0, 55
jr  $ra
nop
done:
nop

regi:
jr $t7
nop
