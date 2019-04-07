.data
	exiting: .asciiz "Exiting... \n"
.text
.globl main
main:
	jal menu
	li $v0, 4
	la $a0, exiting
	syscall
	
	#xeraite
	li $v0, 10
	syscall


#Pseudo
# void printAuksousa(){
#	trexe(head)
#}
#void  trexe(Node current){
#	if(current.next==null){
#		System.out.print(current.data+ " |");
# 		return;
#	}
#	current=current.next;
#	trexe(current.next);
#	System.out.print(current.data+ " |");

#} 
factorial:
	addi $sp, $sp -8
	sw $ra, ($sp)
	sw $s0, 4($sp)
	
	#Base Case
	li $v0, 1
	beq $a0, 0, exitFactorial
	#find factorial(theNumber -1)
	move $s0, $a0
	addi $a0, $a0, -1
	jal factorial
	#the magic happens here
	mul $v0, $s0, $v0
	
	exitFactorial:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		addi $sp, $sp, 8
		jr $ra
