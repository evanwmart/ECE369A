# Exercise 3
# Max Score: 12 points
# Students: 
#	Evan Martin (33%), Jorge Lujan (33%),  Thomas Gentrup (33%)
.data	
list1:		.word		3, 9, -1, 0, 6, 5, -4, -7, -8,
list2:		.word		9, 5, 0, 3, -4, 5, 6, -7, 8, 9,
.text
.globl	tomato
tomato: 
addi	$sp, $sp, -8       
addi	$t0, $a0, -1       
sw  	$t0, 0($sp)        
sw  	$ra, 4($sp)        
bne 	$a0, $zero, orange   
li  	$v0, 0             
addi	$sp, $sp, 8        
jr 	$ra                  

orange:   
add  $a0, $0, $t0            
jal   tomato 
lw    $t0, 0($sp)  
sll	$t1, $t0, 2  
add   $t1, $t1, $a1     
lw    $t2, 0($t1)
slt   $t3, $t2, $a2
bne   $t3, $0, carrot      
add   $v0, $v0, $t2 

carrot:    
lw    $ra, 4($sp)                
addi 	$sp, $sp, 8        
jr 	$ra                      
########################################################################
.globl	test
test:	
addi	$sp, $sp, -4	# Make space on stack
sw	$ra, 0($sp)		# Save return address
jal	tomato		# call function
lw	$ra, 0($sp)		# Restore return address
addi	$sp, $sp, 4		# Restore stack pointer
jr 	$ra			# Return
########################################################################
# main function starts here                                            #
.globl main
main:	addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)		# Save return address
	la	$a1, list2	
	li	$a0, 8
      li    $a2, 5		
	jal	test		
# What is the value of $v0 at this point? (v0)= 25       #
	la	$a1, list1	
	li	$a0, 13		
	jal	test		
# What is the value of $v0 at this point?	(v0) = 34       #
# What does this code compute? Your answer HERE: The code iterates through the first n elements of a list, summing all values greater than or equal to x. In this instance, the code initially iterated through the first 8 elements of list2, summing all values greater than or equal to 5. It continued on to sum the first 13 elements of list1, for all values greater than or equal to 5. However, list1 only has 9 elements, therefore the code included the first 4 elements of list2 to this process since they were the next addresses in memory. #

return:	
li	$v0, 0		# Return value
	lw	$ra, 0($sp)		# Restore return address
	addi	$sp, $sp, 4		# Restore stack pointer
	jr 	$ra			# Return	
