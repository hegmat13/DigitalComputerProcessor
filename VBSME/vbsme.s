#  Team Members: Matthew Heger, Yasser Alsaif     
#  % Effort    : 50/50  
#
# ECE369A,  
# 

########################################################################################################################
### data
########################################################################################################################
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 0 For the 2x2 frame size and 4X4 window size
# small size for validation and debugging purpose
# The result should be 0, 2
# test 1 For the 16X16 frame size and 4X4 window size
# The result should be 12, 12
asize1:  .word    16, 16, 4, 4    #i, j, k, l
frame1:  .word    0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
         .word    1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 
         .word    2, 3, 32, 1, 2, 3, 12, 14, 16, 18, 20, 1, 1, 2, 3, 4, 
         .word    3, 4, 1, 2, 3, 4, 18, 21, 24, 27, 30, 33, 2, 3, 4, 5, 
         .word    0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 3, 4, 5, 6, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 3, 4, 5, 6, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 10, 3, 100, 3, 
         .word    0, 13, 26, 39, 52, 65, 78, 91, 104, 114, 130, 143, 36, 42, 23, 44, 
         .word    0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 25, 34, 33, 58, 
         .word    0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 35, 74, 55, 66 
window1: .word    0, 1, 2, 3, 
         .word    1, 2, 3, 4, 
         .word    2, 3, 4, 5, 
         .word    3, 4, 5, 6 



########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address
    
    # Start test 1 
    ############################################################
    la      $a0, asize1     # 1st parameter: address of asize1[0]
    la      $a1, frame1     # 2nd parameter: address of frame1[0]
    la      $a2, window1    # 3rd parameter: address of window1[0] 
   
    jal     vbsme           # call function
   
    
    ############################################################
    # End of test 1   
   
    lw      $ra, 0($sp)         # Restore return address
    addi    $sp, $sp, 4         # Restore stack pointer
    jr      $ra                 # Return

################### Print Result ####################################

#####################################################################
### vbsme
#####################################################################


# vbsme.s 
# motion estimation is a routine in h.264 video codec that 
# takes about 80% of the execution time of the whole code
# given a frame(2d array, x and y dimensions can be any integer 
# between 16 and 64) where "frame data" is stored under "frame"  
# and a window (2d array of size 4x4, 4x8, 8x4, 8x8, 8x16, 16x8 
# or 16x16) where "window data" is stored under "window" 
# and size of "window" and "frame" arrays are stored under 
# "asize"

# - initially current sum of difference is set to a very large value
# - move "window" over the "frame" one cell at a time starting with location (0,0)
# - moves are based on zigzag pattern 
# - for each move, function calculates  the sum of absolute difference (SAD) 
#   between the window and the overlapping block on the frame.
# - if the calculated sum of difference is LESS THAN OR EQUAL to the current sum of difference
#   then the current sum of difference is updated and the coordinate of the top left corner 
#   for that matching block in the frame is recorded. 

# for example SAD of two 4x4 arrays "window" and "block" shown below is 3  
# window         block
# -------       --------
# 1 2 2 3       1 4 2 3  
# 0 0 3 2       0 0 3 2
# 0 0 0 0       0 0 0 0 
# 1 0 0 5       1 0 0 4

# program keeps track of the window position that results 
# with the minimum sum of absolute difference. 
# after scannig the whole frame
# program returns the coordinates of the block with the minimum SAD
# in $v0 (row) and $v1 (col) 


# Sample Inputs and Output shown below:
# Frame:
#
#  0   1   2   3   0   0   0   0   0   0   0   0   0   0   0   0 
#  1   2   3   4   4   5   6   7   8   9  10  11  12  13  14  15 
#  2   3  32   1   2   3  12  14  16  18  20  22  24  26  28  30 
#  3   4   1   2   3   4  18  21  24  27  30  33  36  39  42  45 
#  0   4   2   3   4   5  24  28  32  36  40  44  48  52  56  60 
#  0   5   3   4   5   6  30  35  40  45  50  55  60  65  70  75 
#  0   6  12  18  24  30  36  42  48  54  60  66  72  78  84  90 
#  0   7  14  21  28  35  42  49  56  63  70  77  84  91  98 105 
#  0   8  16  24  32  40  48  56  64  72  80  88  96 104 112 120 
#  0   9  18  27  36  45  54  63  72  81  90  99 108 117 126 135 
#  0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 
#  0  11  22  33  44  55  66  77  88  99 110 121 132 143 154 165 
#  0  12  24  36  48  60  72  84  96 108 120 132   0   1   2   3 
#  0  13  26  39  52  65  78  91 104 117 130 143   1   2   3   4 
#  0  14  28  42  56  70  84  98 112 126 140 154   2   3   4   5 
#  0  15  30  45  60  75  90 105 120 135 150 165   3   4   5   6 

# Window:
#  0   1   2   3 
#  1   2   3   4 
#  2   3   4   5 
#  3   4   5   6 

# cord x = 12, cord y = 12 returned in $v0 and $v1 registers

.text
.globl  vbsme

# Your program must follow zigzag pattern.  

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:	
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD





# Begin subroutine
vbsme:    
    li      $v0, 0              # Used for final minlocx 
    li      $v1, 0              # Used for final minlocy 
    li      $t8, 0              # minlocx 
    li      $t9, 0              # minlocy 
    
    
    addi     $t0, $zero, 16        # Number of rows of frame
    lw      $t1, 4($a0)         # Number of columns of frame 
    lw      $t2, 8($a0)         # Number of rows of window
    lw      $t3, 12($a0)        # Number of columns of window 
    
   

    sub     $t4, $t0, $t2       # xmax
    sub     $t5, $t1, $t3       # ymax 
    li      $t6, 0              # locx
    li      $t7, 0              # locy 
    li      $t0, 1000           # min SadCount
    
    addi   $sp, $sp, -4        # create memory on stack for temporary values 
    sw      $ra, 0($sp)         # save return address
    
   # bne     $t2, $t3, end

    jal     sadroutine          # jump to Sad Routine 
    add     $t0, $s0, $zero         # Store Min SadCount after first iteration of the Sad Routine 

StartWhile:
    # sne     $s1, $t6, $t4    
    # Stop
    beq     $s1, $t6, Equal     # locx != xmax 
    ori     $s1, $zero, 1
    beq     $zero, $zero, Skip
    Equal: ori     $s1, $zero, 0 
    # sne     $s2, $t7, $t5     
    Skip: beq $t7, $t5, Equal1   # locy != ymax
    ori     $s2, $zero, 1
    beq     $zero, $zero, Skip1
    Equal1: ori     $s1, $zero, 0 
    Skip1: or      $s1, $s1, $s2       # (locx != xmax || locy != ymax) making sure the window is not in the bottom right corner of the frame
    bne     $s1, $zero, While   # Branch to while loop 
    add     $v0, $t8, $zero     # store minlocx in $v0     END OF THE CODE! STORE minlocx and minlocy in v0 and v1
    add     $v1, $t9, $zero     # store minlocy in $v1  
    lw      $ra, 0($sp)         # Restore Return Address to exit entire while loop 
    addi    $sp, $sp, 4              # Delete the stack 
    jr      $ra                 # Exit the entire code and return back to where vbsme was called in main

While:             
    # Stop             
    # seq     $s1, $t7, $t5       # locy == ymax     
    beq     $t7, $t5, Equal2
    ori     $s1, $zero, 0
    beq     $zero, $zero, Skip2
    Equal2: ori     $s1, $zero, 1
    Skip2: bne     $s1, $zero, ymaxif
    j      ymaxelse 

ymaxif:                         # Check Edge case and move: if met move down, else right, Edge Case: if locy == ymax
    addi    $t6, $t6, 1             # locx++ 
    # seq     $s1, $t6, $t4       # locx == xmax
    beq     $t6, $t4, Equal3
    ori     $s1, $zero, 0 
    beq     $zero, $zero, Skip3
    Equal3: ori     $s1, $zero, 1
    # seq     $s3, $t7, $t5       # locy == ymax
    Skip3:  beq $t7, $t5, Equal4
    ori     $s3, $zero, 0
    beq     $zero, $zero, Skip4
    Equal4: ori     $s3, $zero, 1
    Skip4: and     $s1, $s1, $s3       # (locx == xmax && locy == ymax)
    beq     $s1, $zero, continue  # Jump to after the Right if statement if it is not the last move 
    jal     sadroutine          # Perform Sad Routine on modified location  
    jal     UpdateSad           # Update MinSad Count and minlocx and minlocy 
    add     $v0, $t8, $zero     # store minlocx in $v0
    add     $v1, $t9, $zero     # store minlocy in $v1  
    lw      $ra, 0($sp)         # Restore Return Address to exit entire while loop 
    addi    $sp, $sp, 4              # Delete the stack 
    jr      $ra                 # Exit the entire code and return back to where vbsme was called in main

ymaxelse: 
    addi    $t7, $t7, 1              # locy++ 

continue:     
    jal     sadroutine          # Do SAD routine at updated location 
    jal     UpdateSad           # Go to Update Sad Routine  
    
    sub     $s3, $t7, $t6       # d = locy - locx 
    slt     $s1, $zero, $s3     # d > 0 
    nop
    nop
    bne     $s1, $zero, DiagonalLeftfor    # if d > 0 go inside the for loop 
    # Jump to Right If 

DiagonalLeftfor: 
    # Start DiagonalLeftFor
    addi    $t6, $t6, 1              # locx++ 
    addi    $t7, $t7, -1             # locy--
    jal     sadroutine          # Perform Sad Routine on modified location 
    jal     UpdateSad           # Update MinSad Count and minlocx and minlocy 
    addi    $s3, $s3, -1             # d--
    slt     $s1, $zero, $s3     # d > 0 
    nop
    nop
    nop
    bne     $s1, $zero, DiagonalLeftfor   # if d > 0 jump back inside the DiagonalLeftfor loop 

    # seq     $s2, $t7, $zero     # Flag that checks if it has reached the left side of the frame
    beq     $zero, $t7, Equal5 
    ori     $s2, $zero, 0
    beq     $zero, $zero, Skip5
    Equal5: ori $s2, $zero, 1 
    # seq     $s1, $t6, $t4       # Flag that chacks if it has reached the xmax
    Skip5:  beq $t6, $t4, Equal6
    ori     $s1, $zero, 0 
    beq     $zero, $zero, Skip6
    Equal6: ori     $s1, $zero, 1 
    Skip6:  or      $s1, $s1, $s2       # If window has not reached its xmax or the left edge of the frame continue moving diagonal 
    beq     $s1, $zero, DiagonalLeftfor 

 #   seq     $s1, $t6, $t4       # Check if end of rectangular edge case 
 #   bne     $s1, $zero, SkipCase  # Rectangular case 

 #   bne     $t7, $zero, DiagonalLeftfor   # if locy != 0 

# SkipCase
    # seq     $s1, $t6, $t4       # locx == xmax     
    # Stop DiagonalLeftfor
    beq     $t6, $t4 Equal7
    ori     $s1, $zero, 0
    beq     $zero, $zero, Skip7
    Equal7: ori     $s1, $zero, 1
    Skip7: bne     $s1, $zero, xmaxif

xmaxelse: 
    addi    $t6, $t6, 1              # locx++     
    j      continue1 

xmaxif:                         # Check Edge case and move: if met move right, else down, Edge Case: if locx == xmax
    addi    $t7, $t7, 1              # locy++ 
   # seq     $s1, $t6, $t4       # locx == xmax   Duplicate from above xmaxelse
   #  beq     $t6, $t4, Equal8 
   #  ori     $s1, $zero, 0
   #  beq     $zero, $zero, Skip8
   #  Equal8: ori $s1 , $zero, 1
   #  Skip8:  
    # seq     $s3, $t7, $t5       # locy == ymax
    beq     $t7, $t5, Equal9
    ori     $s3, $zero, 0 
    beq     $zero, $zero, Skip9 
    Equal9: ori     $s3, $zero, 1 

    # If window reaches bottom right corner from move to the right
    Skip9: and     $s1, $s1, $s3       # (locx == xmax && locy == ymax)   
    beq     $s1, $zero continue1 # Jump to after the Right if statement if it is not the last move 
    jal     sadroutine          # Perform Sad Routine on modified location  
    jal     UpdateSad           # Update MinSad Count and minlocx and minlocy 
    add     $v0, $t8, $zero     # store minlocx in $v0
    add     $v1, $t9, $zero     # store minlocy in $v1    
    lw      $ra, 0($sp)         # Restore Return Address to exit entire while loop 
    addi    $sp, $sp, 4              # Delete the stack 
    jr      $ra                 # Exit the entire code and return back to where vbsme was called in main


continue1: 
    jal     sadroutine          # Do SAD routine at updated location 
    jal     UpdateSad           # Go to Update Sad Routine  
    sub     $s3, $t6, $t7       # f = locx - locy 
    slt     $s1, $zero, $s3     # f > 0 
    nop
    nop
    bne     $s1, $zero, DiagonalRightfor    # if f > 0 go inside the DiagonalRightfor loop 

DiagonalRightfor: 
    # Start DiagonalRightFor
    addi    $t6, $t6, -1             # locx-- 
    addi    $t7, $t7, 1             # locy++
    jal     sadroutine          # Perform Sad Routine on modified location 
    jal     UpdateSad           # Update MinSad Count and minlocx and minlocy 
    addi    $s3, $s3, -1            # f-- 
    slt     $s1, $zero, $s3     # f > 0  deleted this line

    # seq     $s1, $t7, $t5       # Flag that chacks if it has reached right side of frame, locy = ymax
     beq     $t7, $t5, Equal10 
     ori     $s1, $zero, 0 
    beq     $zero, $zero, Skip10
    Equal10: ori     $s1, $zero, 1
    Skip10: 
    # seq     $s2, $t6, $zero     # locx equals zero for top edge of the frame 
    beq     $zero, $t6, Equal11
    ori     $s2, $zero, 0 
    beq     $zero, $zero, Skip11
    Equal11: ori     $s2, $zero, 1
    Skip11: or      $s1, $s2, $s1  
    beq     $s1, $zero, DiagonalRightfor 
    
    # Stop Diagonal Right for
    # bne   $s1, $zero, Jump   # switched to beq

   # bne     $s1, $zero, DiagonalRightfor   # if f > 0 jump back inside the DiagonalLeftfor loop 

   

 #   bne     $t6, $zero, DiagonalRightfor   # if locx != 0 
 #  Jump: 
    j      StartWhile          # Continue at the start of the While loop
    

# Beginning of Sad Routine and returns $s0, the value of the sadroutine at coordinate (locx, locy)
sadroutine: 
    li      $s0, 0              # SadCount 
    li      $s1, 0              # integer m 
    li      $s2, 0              # integer n 

for: 
    slt     $s6, $s1, $t2       # m < k 
    nop
    nop
    bne     $s6, $zero, for1
    jr      $ra

for1: 
    slt     $s6, $s2, $t3       # n < l 
    nop
    nop
    bne     $s6, $zero, Insidefor
    addi    $s1, $s1, 1          # Increments m 
    add     $s2, $zero, $zero          # Reset n to zero 
    j      for 


Insidefor:  
    # To get the value of the frame
    add     $s4, $s1, $t6       # m + locx 
    add     $s5, $s2, $t7       # n + locy 
    addi    $s6, $t1, 0         # Account for the newline character 
    mult    $s6, $s4            # This will be used to traverse to the row number m + locx
    mflo    $s6                 # Gets the lowest 32 bits from multiplication result
    add     $s6, $s5, $s6       # This is the number of moves to get to the (m + locx, n + locy) coordinate in the matrix
    sll     $s6, $s6, 2         # multipy $s6 by 4, Get the number of moves in bytes 
    add     $s6, $s6, $a1       # Get the address of (m + locx, n + locy)
    nop
    nop
    nop
    lw      $s5, 0($s6)          # Get the value of the frame at (m + locx, n + locy)
    
    # To get the value of the window
    addi    $s6, $t3, 0         # Account for the newline character, # of rows + 1
    mult    $s6, $s1            # This will be used to traverse to the row number m
    mflo    $s6                 # Gets the lowest 32 bits from multiplication result
    add     $s6, $s2, $s6       # This is the number of moves to get to the (m, n) coordinate in the matrix, 
    sll     $s6, $s6, 2         # multiply $s6 by 4, get in bytes
    add     $s6, $s6, $a2       # Get the address of (m, n)
    nop
    nop
    nop
    lw      $s7, 0($s6)          # get the value of the window at (m, n) 

    sub     $s6, $s7, $s5       # Subtract window[m][n] - frame[m + locx][n + locy] and store in $s6
    slt     $s7, $s6, $zero     # Check to see if $s6 is less than 0 
    nop
    nop
    beq     $s7, $zero, Insidefor1  
    sub     $s6, $zero, $s6     # make $s6 positive if less than 0 (Absolute Value)

Insidefor1: 
    add     $s0, $s6, $s0       # Add (window[m][n] - frame[m + locx][n + locy]) + SadCount 
    addi    $s2, $s2, 1              # increment n 
    j      for1                # jump to outside of loop 

UpdateSad: 
   # add     $s2, $s0, $zero 
    # seq     $s2, $s2, $zero 
   # beq     $s2, $zero, Equal12
   # ori     $s2, $zero, 0 
   # beq     $zero, $zero, Skip12
   # Equal12: ori     $s2, $zero, 1
    # Skip12: 
    slt      $s1, $s0, $t0       # SadCount < MinSad 
  #  nop
  #  or      $s1, $s1, $s2   
   #  nop
    nop 
    nop
    beq     $s1, $zero, End      # branch if SadCount !< MinSad 
    add     $t0, $s0, $zero         # MinSad = Sadcount 
    add     $t8, $t6, $zero         # minlocx = locx 
    add     $t9, $t7, $zero         # minlocy = locy 
End:   
    jr      $ra                 # Return to address location 

end:
    addiu   $sp, $sp, 4
    jr      $ra


   
