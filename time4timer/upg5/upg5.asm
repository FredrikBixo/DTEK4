5.

.text

main:

delay:

		addi $t1,$t1, 1	#input ms = $a0
		jal  delayloop
		nop

delayloop:
		li   $t3, 0
		ble  $t1,$t3,done
		nop	# ms >= 0
		addi $t1,$t1,-1		# ms = ms - 1
		jal  forloop
		nop

forloop:				# i < 4711
		li  $t4, 4711
		beq  $t1,$t4,delayloop
		nop	# jump if end
		addi $t1,$t1,1		# i++
		j     forloop
		nop
		 	# continue looping

done:
		nop
