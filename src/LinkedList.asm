#########################################################################################
#den exoun dokimasti=unstable
#########################################################################################
.data
	size: .word -1
	actualSize: .word -1
.text

#########################################################################################
#public:
#########################################################################################

.globl Constructor
Constructor:
	move $t7, $ra
	jal malloc
	move $s0, $v1 #$s0=head
	jal malloc 
	move $s1, $v1 #$s1=tail
	li $t0, 0
	sw $t0, size
	sw $t0, actualSize
	move $ra, $t7
	jr $ra
.globl printSize
printSize:
	li $v0, 1
	lw $a0, size
	syscall
	jr $ra
	
.globl getSize
getSize:
	lw $v1, size
	jr $ra
	
.globl getSizeActualSize
getSizeActualSize:
	lw $v1, actualSize
	jr $ra
		
.globl removeElement
#unstable
removeElement:
	addi $sp $sp -4 
	sw $ra, ($sp)
	move $t0, $s0#s0, prev
	lw $t1, size
	add $t4, $t1, -1
	beq $t4, $a1, removeTail
	beqz $t1, noSuchElement
	beqz $a1, removeHead
	bge $a1, $t1, outOfBounds
	blt $a1, $zero outOfBounds
	li $t2, 1#i=1
	LoopRemove: 
		beq $t2, $a1, remove
		lw $t0, 4($t0)
		add $t2, $t2, 1
		j LoopRemove
	exitLoopRemove:
		lw $ra ($sp)
		addi $sp, $sp, 4
		jr $ra
.globl addElement
addElement:
	move $s7, $a1
	move $t7, $ra
	lw $t0, size
	beqz $t0, addToEmpty #if list is Empty
	beq $t0, 1, addWithOne#if list has one element
	move $s3, $s0#s3 current
	lw $s3, 4($s3)
	move $s5, $s0#s5 previous
	lw $t3 ($s5)
	blt $s7, $t3, addToHead
	for: 
		#$s3=current
		#$s4=newNode
		beq $s3, $s1, addTail
		lw $t3, ($s3)
		bgt $s7, $t3, nextNode
		jal malloc
		move $s4, $v1
		sw $s7, ($s4)
		sw $s3, 4($s4)
		#lw $t1, ($s3) #previous s4 s3 
		#lw $t2, ($s3) #next
		#previous s3 next
		#sw $s4, 8($t1)
		sw $s4, 4($s5)
		#to $t1 otan eimaste se periptvsh 0 den exei previous  to idio kai to $t2 otam eimaste sto telos
		#sw $t1, ($s4)
		#sw $s3, 8($s4)
		jal sizepp
		jal actualSizepp
	exitLoop:
		move $ra, $t7
		jr $ra
.globl printAuksousa
printAuksousa:
	move $t7, $ra
	move $t0, $s0
	lw $t1, size
	beqz $t1,exitLoopAuksousa
	jal printStartList
	li $t2, 0#i
	loopAuksousa: 
		li $v0, 1
		lw $a0, ($t0)
		syscall
		jal printBound
		add $t2, $t2, 1
		beq $t2, $t1, exitLoopAuksousa
		lw $t0, 4($t0)
		j loopAuksousa
	exitLoopAuksousa:
		move $ra, $t7
		jr $ra
	
.globl printFthinousa
printFthinousa:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	move $a1, $s0
	lw $s3, size
	addi $s3, $s3, -1
	li $t1, 0
	jal printStartList
	jal recursivePrint
	li $v0, 1
	lw $a0, ($s0)
	syscall
	jal printBound
	jal println
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	
recursivePrint:
	addi $sp, $sp, -8
	sw $ra, ($sp)
	sw $a1, 4($sp)
	beq $t1, $s3, exitRecursivePrint
	lw $a1, 4($a1)
	addi $t1, $t1, 1
	jal recursivePrint
	li $v0, 1
	lw $a0, ($a1) 
	syscall
	jal printBound
	exitRecursivePrint:
		lw $ra ($sp)
		lw $a1, 4($sp)
		addi $sp, $sp, 8
		jr $ra
#########################################################################################	
#private:
#########################################################################################
	
sizepp:
	lw $t0, size
	add $t0, $t0, 1
	sw $t0, size
	jr $ra
	
sizemm:
	lw $t0, size
	add $t0, $t0, -1
	sw $t0, size
	jr $ra
	
actualSizepp:
	lw $t0, actualSize
	add $t0, $t0, 1
	sw $t0, actualSize
	jr $ra

#########################################################################################
#if labels
#########################################################################################

addToHead:
	jal malloc
 	 move $s4, $v1
 	 sw $s7, ($s4)
  	#sw $s4, ($s0)
  	sw $s0, 4($s4)
  	move $s0, $s4
  	jal sizepp
  	jal actualSizepp
 	j exitLoop     
addTail:
	
  	jal malloc
  	move $s4, $v1
  	#s4= new Node
  	sw $s7, ($s4)
  	lw $t3, ($s1)
  	blt $s7, $t3, addBeforeTail 
  	sw $s4, 4($s1)
 	move $s1, $s4
 	jal sizepp
 	jal actualSizepp
 	j exitLoop
addBeforeTail:
	sw $s4, 4($s5)
	sw $s1, 4($s4)
	jal sizepp
	jal actualSizepp
	j exitLoop                                         
nextNode:                          
  	lw $s3, 4($s3)
  	lw $s5, 4($s5)
  	j for 
	
addToEmpty:
	sw $s7, ($s0)
	sw $s7, ($s1)
	jal sizepp
	jal actualSizepp
	j exitLoop
addWithOne:
	lw $t0, ($s0)
	bgt $s7, $t0, awt
	sw $s7, ($s0)
	sw $s1, 4($s0)
	#sw $s0, ($s1)	
	jal sizepp
	jal actualSizepp
	j exitLoop
awt:
	sw $s7, ($s1)
	sw $s1, 4($s0)
	#sw $s0, ($s1)	
	jal sizepp
	jal actualSizepp
	j exitLoop	
	
noSuchElement: 
	jal printEmptyList
	jal println
	j exitLoopRemove
	
outOfBounds:
	jal printOutOfBounds
	jal println
	j exitLoopRemove
	
remove: 
	lw $s5, 4($t0)
	lw $s5, 4($s5)
	sw $s5, 4($t0)
	jal sizemm
	j exitLoopRemove
removeHead:
	lw $s0, 4($s0)
	jal sizemm
	j exitLoopRemove
#stinAnakilkosi allagi
removeTail:
	#li $v0, 1
	 
	addi $sp, $sp, -4
	sw $t0, ($sp)
	li $t0, 0
	move $s4, $s0
	goPFT:
		addi $t0, $t0,1
		beq $t0, $t4 exitPFT
		lw $s4, 4($s4)
		j goPFT
	exitPFT:
		lw $t0, ($sp)
		addi $sp, $sp, 4
		sw $zero, 4($s4)
		move $s1, $s4
		jal sizemm
		j exitLoopRemove
#okay:
#	lw $s6, ($s3)#previous
#	lw $s7, 8($s3)#next
	
#	sw $s7, 8($s6)
#	sw $s6, ($s7)
#	j exitFind
