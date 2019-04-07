.data 
	CRLF: .asciiz "\n"
	ArrayStart: .asciiz "| "
	Arraybound: .asciiz " | "
	indexOutOfBound: .asciiz "Index you insert is out of bounds"
	emptyList: .asciiz "Your list is EMPTY" 
	menuInsertPrompt: .asciiz "Press \"1\" to insert item in the list."
	menuRemovePrompt: .asciiz "Press \"2\" to remove item from the list."
	menuPrintGPrompt: .asciiz "Press \"3\" to print the list in ascend order."
	menuPrintLPrompt: .asciiz "Press \"4\" to print the list in declining order."
	menuError: .asciiz "What you insert is not right please try again..."
	menuExitPrompt: .asciiz "Press \"0\" to exit."
	inserPrompt: .asciiz "Insert the number you want to add on the list: "
	removePrompt: .asciiz "Insert the index of the element you want to remove from the list: "
.text 
.globl println
println:
	li $v0, 4
	la $a0, CRLF
	syscall
	jr $ra
	
.globl printStartList
printStartList:
	li $v0, 4
	la $a0, ArrayStart
	syscall
	jr $ra
	
.globl printBound
printBound:
	li $v0, 4
	la $a0, Arraybound
	syscall
	jr $ra
	
.globl printOutOfBounds
printOutOfBounds:
	li $v0, 4
	la $a0,  indexOutOfBound
	syscall
	jr $ra
	
.globl printEmptyList
printEmptyList:
	li $v0, 4
	la $a0, emptyList
	syscall
	jr $ra
	
.globl printMenu
#PseudoCode
#cout << menuInsertPrompt << endl;
#cout << menuRemovePrompt << endl;
#cout << menuPrintGPrompt << endl;
#cout << menuPrintLPrompt << endl;
#cout << menuExitPrompt << endl;
printMenu:
	move $t7, $ra 
	li $v0, 4
	la $a0, menuInsertPrompt
	syscall
	jal println
	li $v0, 4
	la $a0, menuRemovePrompt
	syscall
	jal println
	li $v0, 4
	la $a0, menuPrintGPrompt
	syscall
	jal println
	li $v0, 4
	la $a0, menuPrintLPrompt
	syscall
	jal println
	li $v0, 4
	la $a0, menuExitPrompt
	syscall
	jal println
	move $ra, $t7
	jr $ra
	

.globl printInsert
#PseudoCode
#cout << inserPrompt;
printInsert:
	#move $t7, $ra
	li $v0, 4
	la $a0, inserPrompt
	syscall
	#move $ra, $t7
	jr $ra

.globl printRemove
#PseudoCode
#cout << removePromt;
printRemove:
	li $v0, 4
	la $a0, removePrompt
	syscall
	jr $ra
	
	
.globl printMenuError
#Pseudo code 
#cout << menuError << endl;
printMenuError:
	move $t7, $ra
	li $v0, 4
	la $a0, menuError
	syscall
	jal println
	move $ra, $t7
	jr $ra