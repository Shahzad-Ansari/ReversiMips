
.include "macros.asm"
.data

#########################################################################################################
#
#				TEXT PROMPTS 
#
#########################################################################################################

	#####################################################################
	#
	#		User Input Prompts:				
	#
	#####################################################################

	LetterPrompt: 	  .asciiz "\nEnter in a Capital letter from A-G\n"
        NumberPrompt:     .asciiz "\nEnter in a number from 1-8\n"
       
       ######################################################################
       #
       #		System Prompts: 
       #
       ######################################################################
       
	noPass:	          .asciiz "Both players cannot make any further moves!\n"
	human_win:        .asciiz "\nPlayer Wins!!\n"
	computer_win:     .asciiz "\nComputer Wins!!\n"
	human_score:      .asciiz "Human Score: "
	computer_score:   .asciiz "\nComputer Score: "
	
	#####################################################################
	#
	#		Invalid Selection messages:
	#
	#####################################################################
	
	Invalid_Occupied: .asciiz "\nThe Space is occupied/n"
	Invalid_Entry:    .asciiz "\nThe entered in location is invalid\n"
	Invalid_Location: .asciiz "\nThe location you entered in cannot capture any peices\n"
	Invalid_Move:     .asciiz "Entered position is not valid\n"
	
	
	################################################################################################
	################################################################################################
	# 				    Variables and Arrays				       #
	################################################################################################
	################################################################################################
	EBox: .asciiz "[ ]"	# 0 in array
	XBox: .asciiz "[B]"	# PLAYER is 1 , Black
	OBox: .asciiz "[W]"	# 2 in array White , computer 
	HorizontalBar: .asciiz "  1  2  3  4  5  6  7  8"
	Letters: .asciiz "A" , "B" , "C" ,"D" , "E" , "F" , "G" ,"H"
	nl: .ascii "\n"
	
	################################################################################################
	################################################################################################
	#					Board Arrays	                                       #
	################################################################################################
	################################################################################################
	
	board:         .word 0, 0, 0, 0, 0, 0, 0, 0,   
		     	     0, 0, 0, 0, 0, 0, 0, 0,
		             0, 0, 0, 0, 0, 0, 0, 0,
		             0, 0, 0, 1, 2, 0, 0, 0,
		             0, 0, 0, 1, 2, 0, 0, 0,
		     	     0, 0, 0, 1, 2, 1, 0, 0,
		     	     0, 0, 0, 0, 2, 0, 0, 0,
		     	     0, 0, 0, 0, 0, 0, 0, 0
		     	     
	ValidBoard:    .word 0, 0, 0, 0, 0, 0, 0, 0,
		     	     0, 0, 0, 0, 0, 0, 0, 0,
		             0, 0, 0, 0, 0, 0, 0, 0,
		             0, 0, 0, 0, 0, 0, 0, 0,
		             0, 0, 0, 0, 0, 0, 0, 0,
		     	     0, 0, 0, 0, 0, 0, 0, 0,
		     	     0, 0, 0, 0, 0, 0, 0, 0,
		     	     0, 0, 0, 0, 0, 0, 0, 0
		     	     
		     	     
	RightBoard:    .word 1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0,
			     1, 1, 1, 1, 1, 1, 0, 0
			
	
	LeftBoard:    .word  0, 0, 1, 1, 1, 1, 1, 1,
			     0, 0, 1, 1, 1, 1, 1, 1,
			     0, 0, 1, 1, 1, 1, 1, 1,
			     0, 0, 1, 1, 1, 1, 1, 1,
		             0, 0, 1, 1, 1, 1, 1, 1,
	                     0, 0, 1, 1, 1, 1, 1, 1,
     	                     0, 0, 1, 1, 1, 1, 1, 1,
			     0, 0, 1, 1, 1, 1, 1, 1
			     
	UpRightBoard:   .word  0, 0, 0, 0, 0, 0, 0, 0,
			       0, 0, 0, 0, 0, 0, 0, 0,
		               1, 1, 1, 1, 1, 1, 0, 0,
			       1, 1, 1, 1, 1, 1, 0, 0,
			       1, 1, 1, 1, 1, 1, 0, 0,
		               1, 1, 1, 1, 1, 1, 0, 0,
			       1, 1, 1, 1, 1, 1, 0, 0,
			       1, 1, 1, 1, 1, 1, 0, 0
			       
	DownRightBoard:   .word  1, 1, 1, 1, 1, 1, 0, 0,
			         1, 1, 1, 1, 1, 1, 0, 0,
		                 1, 1, 1, 1, 1, 1, 0, 0,
			         1, 1, 1, 1, 1, 1, 0, 0,
			         1, 1, 1, 1, 1, 1, 0, 0,
		                 1, 1, 1, 1, 1, 1, 0, 0,
			         0, 0, 0, 0, 0, 0, 0, 0,
			         0, 0, 0, 0, 0, 0, 0, 0
	
	UpLeftBoard:   .word  0, 0, 0, 0, 0, 0, 0, 0,
			      0, 0, 0, 0, 0, 0, 0, 0,
		              0, 0, 1, 1, 1, 1, 1, 1,
		              0, 0, 1, 1, 1, 1, 1, 1,
		              0, 0, 1, 1, 1, 1, 1, 1,
		              0, 0, 1, 1, 1, 1, 1, 1,
	                      0, 0, 1, 1, 1, 1, 1, 1,
                              0, 0, 1, 1, 1, 1, 1, 1
                              
         DownLeftBoard:  .word 0, 0, 1, 1, 1, 1, 1, 1,
		               0, 0, 1, 1, 1, 1, 1, 1,
		               0, 0, 1, 1, 1, 1, 1, 1,
		               0, 0, 1, 1, 1, 1, 1, 1,
		               0, 0, 1, 1, 1, 1, 1, 1,
		               0, 0, 1, 1, 1, 1, 1, 1
		               0, 0, 0, 0, 0, 0, 0, 0,
			       0, 0, 0, 0, 0, 0, 0, 0
			     
			       
	# 0 is invalid location 1 is valid location 
	
	# Variables
	ArraySize : .word 64
	InvalidLocation : .word 0 
	validLocaiton: : .word 1
	Empty : .word 0
	White : .word 2
	Black : .word 1
	mod28 : .word 28
	mod32 : .word 32
	
	.eqv ArrayLocation $s0 
	.eqv ValidLocation $s1 
	
	
##########################################################################################################################################################################
#
#
#									Text Segment
#
#
##########################################################################################################################################################################

.text


	 # 2 for player 1 for computer 
	
	li $s7 , 0 # DO NOT USE THIS REGISTER , RESERVED FOR CHECKING IF GAME IS COMPLETE ; 0 IS UNCOMPLETE 1 IS COMPLETE 
main: 	
	jal PlayerSetUp
	jal Check_Board
	jal Draw_Board
	jal User_Input
	jal FlipPlayer
	jal Draw_Board
	
	
	jal ComputerSetUp
	jal Check_Board
	jal Draw_Board
	jal Computer_Input
	jal FlipPlayer
	jal Draw_Board
	
	
	# Computer Turn
	# Change Board
	bne $s7 , 1 , main   
	beq $s7 , 0 , ExitProgram 
	
	# Change Board
	# Computer_Check_Board
	# Computer Turn
	# Change Board
	#ABOVE NEEDS TO LOOP ILL CHECK_BOARD RETURNS ALL ZERO
	# Calculate/Display Score
	# Exit Game 
	
############################################################################################################################################################################
#
#
# 									FUNCTION FOR HUMAN TURN 
#
#
############################################################################################################################################################################

	
#############################################################################################################################################################################
#
#
#									FUNCTION TAKES IN USER INPUT
#
#
#############################################################################################################################################################################

PlayerSetUp:
	li $s6 , 1
	li $s5 , 2
	li $s4 , 1 
	jr $ra 

ComputerSetUp:
	li $s6 , 2
	li $s5 , 1
	li $s4 , 2 
	jr $ra 
	
User_Input:
	li $s0 , 0
	printString(nl)
	printString(LetterPrompt)
	charIn($t1)
	printString(NumberPrompt)
	numIn($t2)
	calculateLocation($t1,$t2,Invalid_Input,$s0)
	CheckValidBoard(ValidBoard,$s0,$t3,Invalid_Input,Valid_Player_Input)
	 #load the address of the inputed value to t3 , the value is then compared with the valid board which was generated before the humans turn 
	# return to Huuman Turn 
	jr $ra 
#Computer_Input
Computer_Input:
	li $s0 , 0
	printString(nl)
	printString(LetterPrompt)
	charIn($t1)
	printString(NumberPrompt)
	numIn($t2)
	calculateLocation($t1,$t2,Invalid_Input,$s0)
	CheckValidBoard(ValidBoard,$s0,$t3,Invalid_Input,Valid_Computer_Input)
	 #load the address of the inputed value to t3 , the value is then compared with the valid board which was generated before the humans turn 
	# return to Huuman Turn 
	jr $ra 
############################################################################################################################################################################################
#
#
#										Invalid/Valid Board functions
#
#
############################################################################################################################################################################################
	
	Invalid_Input:
			printString(Invalid_Move)
			j User_Input
##############################################################################

	Valid_Player_Input:
			li $t0 , 1
			sw $t0, board($s0)
			jr $ra
	Valid_Computer_Input:
			li $t0 , 2
			sw $t0 , board($s0)
			jr $ra 
		

############################################################################################################################################################################################
#																							   #
#																					  		   #
#										Board Checking Function For Player									   #		   #		           #
#																							   #
#																							   #
############################################################################################################################################################################################	
Check_Board:

	li $t0 , 0 # 
	li $t1 , 1
	li $t2 , 64 #sentinal value 
	li $t4 , 28 #mod values
	li $t5 , 32
	li $s1 , 0 # index 
	
	
################################################################################################################################################
################################################################################################################################################
################################################################################################################################################
################################################################################################################################################
 Check_Loop:
	beq $t2  , 0 , ExitBoardChecker # if the loop has gone through 64 times return to caller 
	#if the input is not empty 
	lw $t3 , board($s1)
	bne $t3 , $zero , Set_To_Invalid
	##############################################################################################
	#                               	   Up Loop      				     #
	##############################################################################################  
	Check_Up:
		####################################################################################
		#	Store the array location in a temporary 
		####################################################################################
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided 
		####################################################################################
		# First check if you are on the first row , if you are not move up once then check
		# if you are on the first row , there needs to be atleast 2 spaces above you for it to be a valid location 
		####################################################################################
		blt $s2 , 64 , Check_Down# if you are already on the first row then skip to the next 
		addi $s2 , $s2 , -32 # move up once 
		#####################################################################################
		#
		#####################################################################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Check_Down  # if the next peice isnt white , its either black or empty ; thus invalid  
		#####################################################################################
		#
		#####################################################################################
		UpLoop:
			addi $s2 , $s2 , -32 # traverse up one row
			blt $s2 , $zero , Check_Down # if moving up would move you to a location outside of memory 
		     	lw $t3 , board($s2) # load the peice in the board to t3 overriding the previous one 
			beq $t3 , $zero , Check_Down # if location is empty skip else....
			beq $t3 , $s5 , UpLoop # if it is white repeat the loop else it must be black and thus the board is valid. 
			beq $t3 , $s6 , Set_To_Valid # set the board to valid 	
	#####################################################################################################			
	Check_Down:
		####################################################################################
		#	Store the array location in a temporary 
		####################################################################################
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided 
		####################################################################################
		# First check if you are on the first row , if you are not move up once then check
		# if you are on the first row , there needs to be atleast 2 spaces above you for it to be a valid location 
		####################################################################################
		bgt $s2 , 88 , Check_Right # if you are already on the first row then skip to the next 
		addi $s2 , $s2 , 32 # move up once 
		#####################################################################################
		#
		#####################################################################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Check_Right  # if the next peice isnt white , its either black or empty ; thus invalid  
		#####################################################################################
		#
		#####################################################################################
		DownLoop:
			addi $s2 , $s2 , 32 # traverse up one row
			blt $s2 , $zero , Check_Right # if moving up would move you to a location outside of memory 
			lw $t3 , board($s2) # load the peice in the board to t3 overriding the previous one 
			beq $t3 , $zero , Check_Right # if location is empty skip else....
			beq $t3 , $s5 , DownLoop # if it is white repeat the loop else it must be black and thus the board is valid. 
			beq $t3 , $s6 , Set_To_Valid # set the board to valid 
	#####################################################################################################################
	Check_Right:
		lw $t7 , RightBoard($s1) 
		beq $t7 , 0 , Check_Left
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided for other loops 
		########################################
		#   move and check the next location   #
		########################################
		addi $s2 , $s2 , 4 # move right once 
		div $s2 , $t5
		mfhi $t6
		beq $t6 , $zero , Check_Left# if on the last location go to next loop else continue 
		##########################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Check_Left # if board peice is black meaning it is your peice , then by default we need to go on to the next check  
		##########################################
		RightLoop:
			addi $s2 , $s2 , 4 # move to the right 
			div $s2 , $t5 
			mflo $t6
			beq $t6 , $zero , Check_Left # Means you have gone to the next line 
			lw $t3 , board($s2)
			beq $t3 , $zero , Check_Left# if location is empty go to next loop 
			bne $t3 , $s6 , RightLoop # if it is not black , restart the loop 
			j Set_To_Valid # if it is black , set to valid 
	################################################################################################	
	Check_Left:
		lw $t7 , LeftBoard($s1) 
		beq $t7 , 0 , Check_UpRight
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided for other loops 
		########################################
		#   move and check the next location   #
		########################################
		addi $s2 , $s2 , -4 # move right once 
		div $s2 , $t5
		mfhi $t6
		beq $t6 , $t4 , Check_UpRight # if on the last location go to next loop else continue 
		##########################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 ,Check_UpRight # if board peice is black meaning it is your peice , then by default we need to go on to the next check  
		##########################################
		LeftLoop:
			addi $s2 , $s2 , -4 # move to the right 
			div $s2 , $t5 
			mflo $t6
			beq $t6 , $t4 , Check_UpRight  # if this is the last location within the row go to last right  
			lw $t3 , board($s2)
			beq $t3 , $zero ,Check_UpRight# if location is empty go to next loop 
			bne $t3 , $s6 , LeftLoop # if it is not black , restart the loop 
			j Set_To_Valid # if it is black , set to valid 
	################################################################################################	
	Check_UpRight:
		lw $t7 , UpRightBoard($s1) 
		beq $t7 , 0 , Check_DownRight
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided for other loops 
		########################################
		#   move and check the next location   #
		########################################
		addi $s2 , $s2 , 4 # move right once
		addi $s2 , $s2 , -32 # move up once 
		##########################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Check_DownRight # if board peice is black meaning it is your peice , then by default we need to go on to the next check  
		##########################################
		UpRightLoop:
			div $s2 , $t5 
			mflo $t6
			beq $t6 , $t4 , Check_DownRight # this means you are at the last possition 
			blt  $s2 , 32 , Check_DownRight
			addi $s2 , $s2 , 4 # move to the right 
			addi $s2 , $s2 , -32
			#beq $t6 , $zero , Last_Right  # if this is the last location within the row go to last right  
			lw $t3 , board($s2)
			beq $t3 , $zero , Check_DownRight# if location is empty go to next loop 
			bne $t3 , $s6 , UpRightLoop # if it is not black , restart the loop 
			j Set_To_Valid # if it is black , set to valid 
	################################################################################################		
		Check_DownRight:
		lw $t7 , DownRightBoard($s1) 
		beq $t7 , 0 , Check_UpLeft
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided for other loops 
		########################################
		#   move and check the next location   #
		########################################
		addi $s2 , $s2 , 4 # move right once
		addi $s2 , $s2 , 32 # move up once 
		##########################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Check_UpLeft # if board peice is black meaning it is your peice , then by default we need to go on to the next check  
		##########################################
		DownRightLoop:	
			div $s2 , $t5 
			mflo $t6
			beq $t6 , $t4, Check_UpLeft # this means you have gone to the next line 
			bgt  $s2 , 220 , Check_UpLeft
			addi $s2 , $s2 , 4 # move to the right 
			addi $s2 , $s2 , 32
			#beq $t6 , $zero , Last_Right  # if this is the last location within the row go to last right  
			lw $t3 , board($s2)
			beq $t3 , $zero , Check_UpLeft# if location is empty go to next loop 
			bne $t3 , $s6 , DownRightLoop # if it is not black , restart the loop 
			j Set_To_Valid # if it is black , set to valid 
	################################################################################################		
	Check_UpLeft:
		lw $t7 , UpLeftBoard($s1) 
		beq $t7 , 0 , Check_DownLeft
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided for other loops 
		########################################
		#   move and check the next location   #
		########################################
		addi $s2 , $s2 , -4 # move right once
		addi $s2 , $s2 , -32 # move up once 
		##########################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Check_DownLeft # if board peice is black meaning it is your peice , then by default we need to go on to the next check  
		##########################################
		UpLeftLoop:	
			div $s2 , $t5 
			mflo $t6
			beq $t6 , $zero , Check_DownLeft # this means you have gone to the next line 
			blt  $s2 , 32 , Check_DownLeft
			addi $s2 , $s2 , -4 # move to the right 
			addi $s2 , $s2 , -32
			#beq $t6 , $zero , Last_Right  # if this is the last location within the row go to last right  
			lw $t3 , board($s2)
			beq $t3 , $zero , Check_DownLeft# if location is empty go to next loop 
			bne $t3 , $s6 , UpLeftLoop # if it is not black , restart the loop 
			j Set_To_Valid # if it is black , set to valid 
	################################################################################################		
	Check_DownLeft:
		lw $t7 , DownLeftBoard($s1) 
		beq $t7 , 0 , Set_To_Invalid
		move $s2 , $s1 # s2 is used for itteration so that s1 is not overided for other loops 
		########################################
		#   move and check the next location   #
		########################################
		addi $s2 , $s2 , -4 # move right once
		addi $s2 , $s2 , 32 # move up once 
		
		##########################################
		lw $t3 , board($s2) # store the value of 
		bne $t3 , $s5 , Set_To_Invalid # if board peice is black meaning it is your peice , then by default we need to go on to the next check  
		##########################################
		DownLeftLoop:
			div $s2 , $t5 
			mflo $t6
			beq $t6 , $zero , Set_To_Invalid # this means you have gone to the next line 
			blt  $s2 , 32 , Set_To_Invalid
			addi $s2 , $s2 , -4 # move to the right 
			addi $s2 , $s2 , 32
			#beq $t6 , $zero , Last_Right  # if this is the last location within the row go to last right  
			lw $t3 , board($s2)
			beq $t3 , $zero , Set_To_Invalid# if location is empty go to next loop 
			bne $t3 , $s6 , DownLeftLoop # if it is not black , restart the loop 
			j Set_To_Valid # if it is black , set to valid 
	################################################################################################	
		
	Set_To_Invalid:
		sw $t0, ValidBoard($s1)
		j Itterate_By_Four
	Set_To_Valid:
		sw $t1 , ValidBoard($s1)
		j Itterate_By_Four
	Itterate_By_Four:
		addi $s1 , $s1 , 4  # go to next location in array
		addi $t2 , $t2 , -1 # decrement the loop counter 
		j Check_Loop
	ExitBoardChecker:
		#jal CheckNoValidMove
		jr $ra 
		
	#CheckNoValidMove:
	# loop through everything at the end of the checking loop , if everything is zero then the game is over.
	#else return to the exit 
	#jr $ra 
###################################################################################################################################################################################
#
#
#										Player Flip Tiles 
#
#
###################################################################################################################################################################################
FlipPlayer:
	
	li $s1 , 0 # temp value for user selected location 
	li $t0 , 0 # temp value used for value of locatoin
	
##############################################################################
##############################################################################
FlipUp:
		move $s1 , $s0 
		blt $s1 , 64 , FlipDown
		addi $s1 , $s1 , -32
		lw $t0 , board($s1) 
		bne $t0 , $s5 , FlipDown 
		#bne $t0 , 2 , FlipDown
		FlipUpLoop:
			blt $s1 , 32 , FlipDown
			addi $s1 , $s1 , -32
			lw $t0 , board($s1)
			beq $t0 , $s5 , FlipUpLoop
			beq $t0 , 0 , FlipDown
			beq $t0 , $s6 , FlipUpMoveDown
		FlipUpMoveDown:
			beq $s0 , $s1 , FlipDown
			addi $s1 , $s1 , 32
			sw $s4 , board($s1)
			j FlipUpMoveDown
###############################################################################
###############################################################################	
	FlipDown:
		move $s1 , $s0
		bgt $s1 , 88 , FlipRight
		addi $s1 , $s1 , 32
		lw $t0 , board($s1) 
		bne $t0 , $s5 , FlipRight
		#bne $t0 , $s5 , FlipRight
		FlipDownLoop:
			bgt $s1, 220 , FlipRight 
			addi $s1 , $s1 , 32
			lw $t0 , board($s1)
			beq $t0 , $s5 , FlipDownLoop
			beq $t0 , 0 , FlipRight
			beq $t0 , $s6 , FlipDownMoveUp
		FlipDownMoveUp:
			beq $s0 , $s1 , FlipRight
			addi $s1 , $s1 , -32
			sw $s4 , board($s1)
			j FlipDownMoveUp
###############################################################################
###############################################################################
	FlipRight:
		li $t2 , 32 
		move $s1 , $s0
		addi $s1 , $s1 , 4
		lw $t0 , board($s1)
		bne $t0 , $s5 , FlipLeft 
		#bne $t0 , $s5 , FlipLeft
		FlipRightLoop:
			addi  $s1 , $s1 , 4
			div $s1 , $t2 
			mflo $t3
			beq $t3 , $zero  , FlipLeft # If adding would cause you to go to the next row jump to the label
			lw $t0 , board($s1)
			beq $t0 , $s5 , FlipRightLoop
			beq $t0 , 0 , FlipLeft
			beq $t0 , $s6 , FlipRightMoveLeft
		FlipRightMoveLeft:
			beq $s0 , $s1 , FlipLeft
			addi $s1 , $s1 , -4
			sw $s4 , board($s1)
			j FlipRightMoveLeft
##############################################################################
###############################################################################		
	FlipLeft:
		li $t2 , 32
		li $t3 , 28
		move $s1 , $s0
		addi $s1 , $s1 -4
		lw $t0 , board($s1)
		bne $t0 , $s5 , FlipURight 
		#bne $t0 , $s5 , FlipURight
		FlipLeftLoop:
			addi  $s1 , $s1 , -4
			div $s1 , $t2 
			mflo $t4
			beq $t4 , $t3  , FlipURight # If adding would cause you to go to the next row jump to the label
			lw $t0 , board($s1)
			beq $t0 , $s5 , FlipLeftLoop
			beq $t0 , 0 , FlipURight
			beq $t0 , $s6 , FlipLeftMoveRight
		FlipLeftMoveRight:
			beq $s0 , $s1 , FlipURight
			addi $s1 , $s1 , 4
			sw $s4 , board($s1)
			j FlipLeftMoveRight
#############################################################################

FlipURight:
	li $t2 , 32
	move $s1 , $s0 
	addi $s1 , $s1 , 4
	addi $s1 , $s1 , -32
	lw $t0 , board($s1)
	bne $t0, $s5 , FlipULeft
	FlipURightLoop:
		div $s1 , $t2 
		mflo $t3
		beq $t3 , $zero  , FlipULeft # If adding would cause you to go to the next row jump to the label
		blt $s1 , 32 , FlipULeft
		addi $s1 , $s1 , -32
		addi  $s1 , $s1 , 4
		lw $t0 , board($s1)
		beq $t0 , $s5 , FlipURightLoop
		beq $t0 , 0 , FlipULeft
		beq $t0 , $s6 , FlipURightMoveDLeft
	FlipURightMoveDLeft:
		beq $s0 , $s1 , FlipULeft
		addi $s1 , $s1 , 32
		addi  $s1 , $s1 , -4
		sw $s4, board($s1)
		j FlipURightMoveDLeft
		
###########################################################################################################

FlipULeft:
	li $t2 , 32
	move $s1 , $s0 
	addi $s1 , $s1 , -4
	addi $s1 , $s1 , -32
	lw $t0 , board($s1)

	bne $t0 , $s5 , FlipDRight
	FlipULeftLoop:
		div $s1 , $t2 
		mflo $t3
		beq $t3 , $zero  , FlipDRight # If adding would cause you to go to the next row jump to the label
		blt $s1 , 32 , FlipDRight
		addi $s1 , $s1 , -32
		addi  $s1 , $s1 , -4
		lw $t0 , board($s1)
		
		#beq $t0 , $s6 , FlipULeftLoop
		beq $t0 , $s5 , FlipULeftLoop
		
		beq $t0 , 0 , FlipDRight
		
		#beq $t0 , $s5 , FlupULeftMoveDRight
		beq $t0 , $s6 , FlipULeftMoveDRight
	FlipULeftMoveDRight:
		beq $s0 , $s1 , FlipDRight
		addi $s1 , $s1 , 32
		addi  $s1 , $s1 , 4
		sw $s4 , board($s1)
		j FlipULeftMoveDRight

#########################################################################################################

FlipDRight:
	li $t2 , 32
	move $s1 , $s0 
	addi $s1 , $s1 , 4
	addi $s1 , $s1 , 32
	lw $t0 , board($s1)
	bne $t0 , $s5 , FlipDLeft
	FlipDRightLoop:
		div $s1 , $t2 
		mflo $t3
		beq $t3 , $zero  , FlipDLeft # If adding would cause you to go to the next row jump to the label
		blt $s1 , 32 , FlipDLeft
		addi $s1 , $s1 , 32
		addi  $s1 , $s1 , 4
		lw $t0 , board($s1)
		beq $t0 , $s5 , FlipDRightLoop
		beq $t0 , 0 , FlipDLeft
		beq $t0 , $s6 , FlipDRightMoveULeft
	FlipDRightMoveULeft:
		beq $s0 , $s1 , FlipULeft
		addi $s1 , $s1 , -32
		addi  $s1 , $s1 , -4
		sw $s4 , board($s1)
		j FlipDRightMoveULeft
		
##################################################################################	
	
FlipDLeft:
	li $t2 , 32
	move $s1 , $s0 
	addi $s1 , $s1 , -4
	addi $s1 , $s1 , 32
	lw $t0 , board($s1)

	bne $t0 , $s5 , ExitFlip
	FlipDLeftLoop:
		div $s1 , $t2 
		mflo $t3
		beq $t3 , $zero  , ExitFlip # If adding would cause you to go to the next row jump to the label
		blt $s1 , 32 , ExitFlip
		addi $s1 , $s1 , 32
		addi  $s1 , $s1 , -4
		lw $t0 , board($s1)
		beq $t0 , $s5 , FlipDLeftLoop
		beq $t0 , 0 , ExitFlip
		beq $t0 , $s6 , FlipDLeftMoveURight
	FlipDLeftMoveURight:
		beq $s0 , $s1 , FlipULeft
		addi $s1 , $s1 , -32
		addi  $s1 , $s1 , 4
		sw $s4 , board($s1)
		j FlipDLeftMoveURight
	


	
	#############################################

ExitFlip:
	jr $ra 
	
	
	
	
	
###################################################################################################################################################################################	
#																						  #
#																					  	  #
#									   Board Drawing Function 									      	  #
#																						  #
#																						  #
###################################################################################################################################################################################	

Draw_Board: 
		li $t0 , 0      # Board value
		li $t1 , 64	# how many itterations 
		li $t2 , 8	# how many new lines
		li $t3 , 0	# Iterate through the letters
		li $t4 , 1	# Check if value is one	
		li $t5 , 2	# Check if value is 2
		li $t6 , 0	# Iterate thorugh the board
		# display horizontal bar
		TopBar:
			li $v0, 4 # print the Horiziontal numerical bar one time  
			la $a0, HorizontalBar 
			syscall
		# print a new line 
		j New_Line
			
		
Print_Loop:
		beq $t1 , $zero , Exit_Display_Board 	# if the loop has exectued 64 times the whole board has been printed 
		beq $t2 , $zero , New_Line # if there have been 8 prints then the system goes to new line 
		addi $t1, $t1, -1  # decrement the amount of iterations for the whole board 
		addi $t2, $t2, -1  # decrement the amount of iterations for each line 				
		lw $t0 ,board($t6) # loaad the value of the board into t0 
		# The following three branches decide what string to print XBOX , OBOX or EBOX
		beqz  $t0 , printE # if the value is 0 print blank 
		beq $t0 , $t4 , printX # if the value is 1 meaning it is white print X
		beq $t0 , $t5 , printO # if the value is 2 meaning it is black print O
		# Loop back to the start of this loop 
		j Print_Loop 

#############################
printX:

li $v0 , 4
la $a0 , XBox 
syscall

addi $t6 , $t6 , 4
j Print_Loop

#############################
printO:

li $v0 , 4
la $a0 , OBox 
syscall

addi $t6 , $t6 , 4
j Print_Loop

#############################
printE:

li $v0 , 4
la $a0 , EBox 
syscall

addi $t6 , $t6 , 4
j Print_Loop

##############################		
New_Line:		
	la $t2 , 8          
	li $v0 , 4 
	la $a0 , nl 
	syscall 
			
	li $v0 , 4 
	la , $a0 , Letters($t3)
	syscall 
	addi $t3 , $t3 , 2
	j Print_Loop 

##############################
Exit_Display_Board:
		printString(nl)
		printString(nl)
		jr $ra


###################################################################################################################################################################################

		
##################################################################################################################################################
#
#
#							Print to valid moves left , game exits  
#
#
##################################################################################################################################################


ExitNoValidMoves: 




#################################################################################################################################################
#
#
#							Exit Program 
#
#
#################################################################################################################################################

ExitProgram:
li $v0 , 10
syscall 


######################################################################################################################################################################################################	
# END OF PROGRAM 	
 	
