.data 

.text 

# macro to reinitialize board to default 
.macro intialize_Board(%boadArray)

li $t0 , 64 # initilize the loop to 64
li $t1 , 0  # itterator
######################################
li $t2 , 0
li $t3 , 1
li $t4 , 2
###################################### 
j loop 

SetBlack:
	sw  $t3 , %boardArray($t1)
	sub $t0 , $t0 , 1
	j loop 
	
SetBlack:
	sw  $t4 , %boardArray($t1)
	sub $t0 , $t0 , 1
	j loop 
loop:
	
	beq $t0 , 28 , SetBlack
	beq $t0 , 36 , SetBlack
	beq $t0 , 29 , SetWhite
	beq $t0 , 37 , SetWhite
	sw  $t2 , %boardArray($t1)
	sub $t0 , $t0 , 1
	bgt $t0 , $zero , loop 
.end_macro 

######################################
.macro NextElement(%boardArray)

.end_macro

########################################
.macro SubOne($register)
	addi %register , %register , -1
.end_macro
########################################
.macro AddOne($register)
	addi %register , %register , 1
.end_macro 
########################################
.macro aMod28( %aRegister , %rRegister)
	j loop 
	stop:
		beq  %aRegister , 0 , zero
		move %rRegister , %aRRegister 
	zero:
		sw %rRegister , 0
	loop: 

		blt %aRegister , 28 , stop 
		addi %aRegister , %aRegister , -28
		j loop 
.end_macro
#############################################
.macro aMod32( %aRegister , %rRegister)
	j loop 
	stop:
		beq  %aRegister , 0 , zero
		move %rRegister , %aRegister 
	zero:
		sw %rRegister , 0
	loop: 

		blt %aRegister , 32 , stop 
		addi %aRegister , %aRegister , -32
		j loop 
.end_macro
############################################### 
.macro printString(%string)

	li $v0 , 4  
	la $a0 , %string
	syscall 
.end_macro 
################################################
.macro numIn (%storageRegister)
	li $v0 , 5
	syscall 
	move %storageRegister , $v0
.end_macro
################################################
.macro charIn(%storageRegister,%label)
	li $v0 , 12
	syscall 
	move %storageRegister , $v0
	
	beq %storageRegister , 83 , %label
.end_macro 
################################################
.macro calculateLocation(%charReg,%intReg,%invalidLabel,%s0)
	addi %charReg , %charReg , -65 
	addi %intReg , %intReg , -1
	
	blt $t2 , 0 , %invalidLabel
	bgt $t2 , 7 , %invalidLabel
	
	mul %charReg , %charReg , 32
	mul %intReg , %intReg , 4
	add %s0 , %charReg , %intReg
.end_macro
################################################
.macro LoadBoard(%boardname,%location ,%storageLocation)
	
	la %storageLocation , %boardname(%location)
.end_macro
################################################
.macro traverseUp(%location)
	addi %location , %location , -32 # traverse up one row
.end_macro
################################################
.macro traverseDown(%location)
	addi %location , %location , 32 # traverse up one row
.end_macro
#################################################
.macro traverseRight(%location)
	addi %location , %location , 4 # move right once
.end_macro
#################################################
.macro traverseLeft(%location)
	addi %location , %location , -4 # move right once
.end_macro
#################################################
.macro setToValid(%location)
	sw $zero ,ValidBoard(%location)
.end_macro
 ################################################
 .macro setToInvalid(%oneReg , %location)
 	sw %oneReg , ValidBoard(%location)
 .end_macro
 ################################################
.macro CheckValidBoard(%board , %location , %temp , %branch ,%branch2)
	lw %temp, %board(%location)
	beq %temp , 0 , %branch
	beq %temp , 1 , %branch2
.end_macro
#################################################
.macro CheckBranch(%register,%value,%label)
	bne %register , %value , %lable
.end_macro
#################################################
.macro RandNum(%location)

	li	$a1, 64	# upper bound of the range
	li	$v0, 42		# random int range
	syscall

	move $t0 , $a0 
	move %location , $a0
	mul %location , %location, 4
.end_macro
##################################################
.macro ValidMoves(%board , %label )
	li $t0 , 64
	li $t1 , 0
	li $t3 , 0
	
	loop:
		lw $t2 , %board($t1)
		beq $t2 , 1 , addOne
		j Increment 
		
		
	loopCheck:
		bgt $t0 , 0 , loop
		beq $t0 , $zero , sumCheck
		
	addOne:
		addi $t3 , $t3 , 1
		j Increment 
		
	sumCheck:
		beq $t3 , 0 , %label
		jr $ra
	Increment:
		addi $t1 , $t1 , 4
		addi $t0 , $t0 , -1
		j loopCheck
.end_macro
##################################################
.macro printInt(%num)
	li $v0 , 1
	move $a0 , %num
	syscall 
.end_macro
##################################################
.macro End()
	li $v0 , 10
	syscall
.end_macro 
##################################################
.macro SumPoints(%board)
	
	.data
	
	player_win:        .asciiz "\nPlayer Wins!!\n"
	computer_win:     .asciiz "\nComputer Wins!!\n"
	player_score:      .asciiz "Human Score: "
	computer_score:   .asciiz "\nComputer Score: "
	nl:		  .asciiz "\n"
	
	.text
	li $t0 , 64
	li $t1 , 0 
	li $t2 , 0 
	li $t3 , 0
	
	loop:
		lw $t4 , %board($t1)
		beq $t4 , 1 , PlayerSum
		beq $t4 , 2 , ComputerSum
		
	Iterate:
		addi $t1 , $t1 , 4
		addi $t0 , $t0 , -1
		j CheckCondition
		
	CheckCondition:
		beq $t0 , 0 , DisplayEnd
		bgt $t0 , 0 , loop
		
		
	PlayerSum:
		addi $t2 , $t2 , 1
		j Iterate
	ComputerSum:
		addi $t3 , $t3 , 1
		j Iterate 
	
	
	DisplayEnd:
	
		li $v0 , 4
		la $a0 , player_score
		syscall 
	

		li $v0 , 1
		move $a0 , $t2
		syscall 
		
		li $v0 , 4 
		la $a0 , nl
		syscall 
		
		li $v0 , 4
		la $a0 , computer_score
		syscall 
	

		li $v0 , 1
		move $a0 , $t3
		syscall 
		
		bgt $t2 , $t3 , PlayerWin
		bgt $t3 , $t2 , ComputerWin 
		
	ComputerWin:
	
		li $v0 , 4 
		la $a0 , computer_win
		syscall 
		
		li $v0 , 10
		syscall 
		
		
	PlayerWin:
		li $v0 , 4 
		la $a0 , player_win
		syscall 
		
		li $v0 , 10
		syscall 
		

.end_macro 
