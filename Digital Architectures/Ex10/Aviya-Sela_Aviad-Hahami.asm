#DATA
.data 0x10000000
arrSize: 	.word 10  # array in size 10
toSearch: 	.word 0xd # the value we search

#ARRAY VALUES AS GIVEN IN THE ASSIGNMENT
.data 0x10000100 
arr: 	.word 1
	.word 5
	.word 7
	.word 9
	.word 0xb
	.word 0xd
	.word 0x10
	.word 0x4000
	.word 0x50000
	.word 0x700000
	
main:
	#	vars setup
	#==================================
	add $s0,$zero,$zero #init $s0 -> 0
	lui $s0,0x1000 #pointing to 0x1000000
	lw $s1,0($s0) #$s1 = size
	add $s0,$zero,$s1 #S0 is now size, for comfort purposes
	add $s1,$zero,$zero #init s1->0, will be first
	subi $s2,$s0,1 #S2 (last) = s0 (size) - 1
	j loop
loop:
	
	