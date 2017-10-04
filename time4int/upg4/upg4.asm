.text

main:

delay:

		addi $t1,$t1, 1	#input ms = $a0
		jal  delayloop

delayloop:
		li   $t3, 0
		ble  $t1,$t3,done	# ms >= 0
		addi $t1,$t1,-1		# ms = ms - 1
		jal  forloop

forloop:				# i < 4711
		li  $t4, 4711
		beq  $t1,$t4,delayloop	# jump if end
		addi $t1,$t1,1		# i++
		j     forloop
		 	# continue looping

done:
		nop
