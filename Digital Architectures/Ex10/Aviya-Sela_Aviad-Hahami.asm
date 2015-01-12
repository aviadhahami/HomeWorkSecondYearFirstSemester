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
	#s0 will be size,
	#s1 will be first
	#s2 will be last
	add $s0,$zero,$zero #init $s0 -> 0
	lui $s0,0x1000 #pointing to 0x1000000
	lw $s1,0($s0) #$s1 = size
	add $s0,$zero,$s1 #S0 is now size, for comfort purposes
	add $s1,$zero,$zero #init s1->0, will be first
	subi $s2,$s0,1 #S2 (last) = s0 (size) - 1
	j loop
loop:
	sub $t0,$s2,$s1 #t0 = last - first
	addi $a1,$zero,1#sa1 will be 1
	add $a2,$a1,$a1 #$a2 = 2
	slt $t8,$t0,$a1 #if t0 (last-first) < 2, t8 will be 1
	beq $t8,$a1,exit #if t8 == 1 that means (last-first)<2 aka (last-first)<=1 and we leave
	#We get to this part iff (last-first)>1 ===> Loop continues
	# vars:
	#$s3 will be mid
	div $s3,$t0,2 #mid = (last-first)/2
	add $s3,$s3,$s1 #mid = mid + first
	#if A[mid] == val
		j exit #we go to exit and break
	#if a[mid] > val
		add $s2,$zero,$s3#last =mid
		j loop#continue
	#if A[mid]<val
		add $s1,$zero,$s2#first=mid
		j loop#continue
	
exit:
	#some exit stuff
	