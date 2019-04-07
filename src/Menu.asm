.data
	sucess: .asciiz "Succes... "
.text
.globl menu
menu:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	jal Constructor
	while:
		jal printMenu
		li $v0, 5
		syscall
		move $t0, $v0
		bltz $t0, notValid
		bgt $t0, 4, notValid
		beq $t0, 0, exitWhile
		beq $t0, 1, insert
		beq $t0, 2, remove
		beq $t0, 3, auksousa
		beq $t0, 4, fthinousa
		j while
	exitWhile:
		lw $ra, ($sp)
		addi $sp, $sp, 4
		jr $ra
success:
	li $v0, 4
	la $a0, sucess
	syscall
	jal printSize
	jal println
	jal println
	jal while
insert:
	jal printInsert
	li $v0, 5
	syscall
	move $a1, $v0
	jal addElement
	jal success
	
remove:
	jal printRemove
	li $v0, 5
	syscall
	move $a1, $v0
	jal removeElement
	jal success
	
auksousa:
	jal getSize
	beqz $v1, empty
	jal printAuksousa
	jal println
	j while
fthinousa:
	jal getSize
	beqz $v1, empty
	jal printFthinousa
	jal println
	jal while
empty:
	jal printEmptyList
	jal println
	j while
notValid:
	
	
	jal println
	j while
