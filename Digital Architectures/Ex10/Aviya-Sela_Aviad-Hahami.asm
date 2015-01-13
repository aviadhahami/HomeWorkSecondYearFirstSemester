#first = 0
#last = size -1
#while (last - first > 1) {
	#mid = (last-first)/2 + first
	#if A[mid] == val
		#break;
	#if A[mid] > val
		#last = mid;
		#continue
	#else
		#first = mid;
		#continue;
#}
.data 0x10000000
	#TODO: define the array
arr: 			.word 1,5,7,9,0xb,0xd,0x10,0x4000,0x50000,0x700000#ARRAY VALUES AS GIVEN IN THE ASSIGNMENT

.data 0x10000100
arrSize: 		.word 0x000a  # array in size 10
toSearch: 	.word 0xd # the value we search

.text	
main:
	#	vars setup
	#==================================
	#s0 will be size,
	#s1 will be first
	#s2 will be last
	
	lui $s0,0x1000 #pointing to 0x1000000
	lw $s0,0($t9) #$s1 = size <------ SHOULD CHECK
	
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
	
