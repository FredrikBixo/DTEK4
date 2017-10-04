Our changed code looks like:
  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,18		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window

stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

hexasc:
	andi 	$a0, $a0,0xf	# only gets 4 lsb
	addi	$v0,$zero,0x30	# adds 48
	addi	$t0,$zero,0x9	# adds 9

	ble	$a0,$t0 loop	# checks values in range 0-9
	nop
	addi 	$v0,$v0, 0x07

loop:
	add 	$v0,$a0,$v0
	jr	$ra
nop
