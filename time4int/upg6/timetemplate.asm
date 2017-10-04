# timetemplate.asm
# Written 2015 by F Lundevall
# Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
addi	$sp,$sp,-4
sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
lw	%reg,0($sp)
addi	$sp,$sp,4
.end_macro

.data
white:  .word   0x00FFFFFF
.align 2
mytime:	.word 0x5957
timstr:	.ascii ""
.text

main:
# print timstr
la	$a0,timstr
li	$v0,4
syscall
nop
# wait a little
li	$a0,5000
jal	delay
nop
# call tick
la	$a0,mytime
jal	tick
nop
# call your function time2string
la	$a0,timstr
la	$t0,mytime
lw	$a1,0($t0)
jal	time2string
nop
# print a newline
li	$a0,10
li	$v0,11
syscall
nop
# go back and do it all again
j	main
      nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
addiu	$t0,$t0,1	# increase
andi	$t1,$t0,0xf	# check lowest digit
sltiu	$t2,$t1,0xa	# if digit < a, okay
bnez	$t2,tiend
nop
addiu	$t0,$t0,0x6	# adjust lowest digit
andi	$t1,$t0,0xf0	# check next digit
sltiu	$t2,$t1,0x60	# if digit < 6, okay
bnez	$t2,tiend
nop
addiu	$t0,$t0,0xa0	# adjust digit
andi	$t1,$t0,0xf00	# check minute digit
sltiu	$t2,$t1,0xa00	# if digit < a, okay
bnez	$t2,tiend
nop
addiu	$t0,$t0,0x600	# adjust digit
andi	$t1,$t0,0xf000	# check last digit
sltiu	$t2,$t1,0x6000	# if digit < 6, okay
bnez	$t2,tiend
nop
addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
jr	$ra		# return
nop

delay:

li $t0, 0 #counter for for-loop
li $t1, 4711 # constant

#while-loop
while:
  ble  $a0, 0, end # while ms>0, go to end if condition is met
  nop
  subi $a0, $a0, 1 # ms=ms+1

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

       PUSH ($ra)

# save teturn adress

       move $t6, $ra

       # minutes

move $a3, $s0


      andi $a3, $a1, 0x0000F000
srl $a3, $a3, 12

PUSH ($a3)

jal hexasc

POP ($a3)
# li $v0, 48
      sb $v0, 0($a0)

      andi $a3, $a1, 0x00000F00
srl $a3, $a3, 8
PUSH ($a3)

jal hexasc

POP ($a3)
# li $v0, 48
      sb $v0, 1($a0)

# comma
      li $t3, 58
      sb $t3, 2($a0)


# seconds
andi $a3, $a1, 0x000000F0
srl $a3, $a3, 4
PUSH ($a3)

jal hexasc

POP ($a3)
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





      POP ($ra)

jr $ra

nop

hexasc:
li  $t0,9
andi $a0, $a0, 0xF
slt $t1, $t0, $a3  # checks if $s0 > $s1
beq $t1,1,over
nop 	    # if $s0 > $s1, goes to label1
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

 li $t7, 0x0
 sb $t7, 4($a0)

 jr $ra

over:
addi $v0, $a0, 55
jr  $ra
nop
done:
nop


regi:
jr $t7
nop
