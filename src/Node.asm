.data

.text
.globl malloc
malloc:
	li $v0, 9
	li $a0, 8
	syscall
	move $v1, $v0
	sw $zero, 4($v1)
	jr $ra
	
.globl printNode
printNode:
	addi $sp, $sp -4
	sw $t0, ($sp)
	lw $t0, ($a1)
	li $v0, 1
	move $a0, $t0
	syscall
	lw $t0, ($sp)
	addi $sp, $sp, 4
	jr $ra
