#ID 302188347
#MIPS BINARY SEARCH IMPLEMENTATION

#===============================
#    	DATA DIRECTIVES
#==============================
		.data  	0x10000000

arrSize:    		.word   0x0000000a 	# array size = 10
toSearch:		.word	0xd			# element to search
index:			.word	0xffffffff	# index of element in the array
arrEntryPoint:   	.word   0x10000100 	# start address of array

		.data 	0x10000100     		 #array's allocation
		
				.word 1
				.word 5
				.word 7
				.word 9
				.word 0xb
				.word 0xd
				.word 0x10
				.word 0x4000
				.word 0x50000
				.word 0x700000
				               
#======================
#	TEXT DIRECTIVE
#======================

	.text	0x0400000
#==========START OF MAIN========================
main:	
	lui		$gp, 0x1000		# $gp points at 0x10000000
	lw		$s0, 0($gp)		# $s0 = arrSize
        lw		$s1, 12($gp)		# $s1 = arrEntryPoint 
       	lw		$s2, 4($gp)		# $s2 = toSearch
	add		$s3, $0, $0		# $s3 = first index
	lw		$s4, 0($s1)		# $s4 = first item in arraay
	addi  	$s5, $s0, -1		# $s5 = arrSize-1 = last index
	add		$t5, $s5, $s5		# $t5 =$s5 + $s5
 	add		$t5, $t5, $t5		# $t5= 4* (last index)
	add		$t5, $t5, $s1		# $t5= physical pointer to last element
	lw 		$s6, 0($t5)		# $s6 = last element
#==========END OF MAIN========================

#=========START OF WHILE LOOP=================
whileLoop:
	sub		$t0, $s5, $s3		 
	slti		$t1, $t0, 2		# if $t0 < 2 then $t1=1
	bne		$t1,$0, exitPath 	# if $t0 < 2, we're done
	ori		$0,$0,0			#dummy ori
	div		$s7,$t0,2		# $s7 = $t0/2 --> mid index calc
	add		$s7,$s7,$s3		# midPointer= first+(last-first)/2
	add		$t3, $s7, $s7		# $t3 = $s5 + $s5
 	add		$t3, $t3, $t3		# $t3= 4*(middle element)
	add		$t3, $t3, $s1		# $t3= address of mid element
  	lw 		$t2, 0($t3)		# $t2 = A[middlePointer]
	beq		$t2,$s2,foundReqItem	#if currElem = A[middlePointer]
	ori		$0,$0,0			#dummy ori
	slt		$t4, $s2, $t2		# if currElem < A[middlePointer] => $t4 = 1
#=========END OF WHILE LOOP=================	

#========START OF HELPER CONDITION===========
if:	
	beq		$t4, $zero, else
	ori		$0,$0,0			#dummy ori
	add		$s5, $s7, $zero	# last index = mid index
	add		$s6, $t2, $zero	# last val = mid val
	j 		whileLoop
	ori		$0,$0,0	
else:
	add		$s3, $s7, $zero	# first index = mid index
	add		$s4, $t2, $zero	#$s4 = $t2
	j		whileLoop
	ori		$0,$0,0			#dummy ori
#========END OF HELPER CONDITION===========

#========START OF foundReqItem===========
foundReqItem:
	
	sw 		$s7, 8($gp)		# index = mid index

#========END OF foundReqItem===========

#=========START OF exitPath============                    
exitPath:
	beq		$zero, $zero, exitPath		#we loop until end of times
	ori		$0,$0,0					#dummy ori
#========END OF exitPath==============
	
