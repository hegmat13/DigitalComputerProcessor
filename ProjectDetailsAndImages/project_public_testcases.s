########################################################################################################################
### main
########################################################################################################################
.data
asize0:  .word    100, 200, 300, 400, 500, 600
asize1:  .word	  700, 800, 900, 1000, 1100, 1200
.text

.globl main

main: 
la $s2, asize0		#[s2] = 0x10010000  #mipshelper convert this to ori
lw $s2, 0($s2)		#[s2] = 0x64

la $s3, asize0							#mipshelper convert this to ori
lw $s3, 4($s3)		#[s3] = 0xc8





#Read After Write(RAW) case 1               # Works yea
add $s1, $s2, $s3		#[s1] = 0x12c
sub $s4, $s1, $s3		#[s4] = 0x64
sub $s1, $s1, $s4		#[s1] = 0xc8
mul $s4, $s1, $s3		#[s4] = 0x9c40

#Write after read case 2                   # Works 
sub $s4, $s1, $s3		#[s4] = 0x0
add $s1, $s2, $s3		#[s1] = 0x12c
mul $s6, $s1, $s4		#[s6] = 0x0



#write after write case 3                  # Works 
sub $s1, $s4, $s6		#[s1] = 0x0
add $s1, $s2, $s6		#[s1] = 0x64
ori $s1, $s1, 43690	    #[s1] = 0xaaee
sll $s1, $s1, 10		#[s1] = 0x2abb800

#Stall case 4                               # Doesn't work
addi $s5, $s1, 0		#[s5] = 0x2abb800
addi $s7, $s5, 0		#[s7] = 0x2abb800
la $s2, asize1							#mipshelper convert this to ori
lw $s1, 0($s2)			#[s1] = 0x2bc
sub $s4, $s1, $s5		#[s4] = 0xfd544abc
and $s6, $s1, $s7		#[s6] = 0x0
or $s7, $s1, $s6		#[s7] = 0x2bc


#text book example case 5                 # Works!!!!
sub $s2, $s1, $s3		#[s2] = 0x1f4
and $t0, $s2, $s5		#[t0] = 0x0
or $t1, $s6, $s2		#[t1] = 0x1f4
add $t2, $s2, $s2		#[t2] = 0x3e8     
la $s1, asize0			# mipshelper convert it to ori   
sw $t1, 4($s1)			#                              This works for forwarding 
lw $t2, 4($s1)			#[t2] =  0x1f4



#case 6 
sub   $s2,    $s1,   $s3    #[s2] = ffffff38          # Works!!!
or    $t3,  $s2,   $s5        #[t3] = ffffff38
add   $t4,  $s2,   $s2        #[t4] = fffffe70
or    $t2, $s2, $s2        #[t2] = ffffff38
add   $s4,   $s7,    $t2    #[s4] = 000001f4

#case 7                                              # Works 
la $t1, asize0				# mipshelper convert it to ori
lw $t0, 0($t1)				#[t0] = 0x64
lw $t2, 4($t1)				#[t2] = 0x1f4
sw $t2, 0($t1)				#
sw $t0, 4($t1)				#
lw $t0, 0($t1)				#[t0] = 0x1f4
lw $t2, 4($t1)				#[t2] = 0x64


#branch  cases 8,9,10
la      $a0, asize1			# mipshelper convert it to ori
j       start               # jump to jump1. # the osffest is not correct from mipshelper It should be 08100038
    addi    $a0, $zero, -1      # if $a0 == -1, jump failed.
    addi    $a0, $zero, -1      # if $a0 == -1, jump failed.
    start:
    lw      $s0, 4($a0)  
    sw      $s0, 0($a0)

	branch1:
    bgez    $s0, branch2 
    addi    $s0, $s0, 1
    bgez    $s0, branch1    # you need to subtract 2 from the offset calculated by mipshelper.
    j       error         

    branch2:
    addi    $s0, $zero, -1  
    bltz    $s0, branch3    
    addi    $s0, $zero, 1   
    bgtz    $s0, branch2    # you need to subtract 2 from the offset calculated by mipshelper.
    j       error           

    branch3:
    bltz    $s0, done
    addi    $s0, $zero, -1  
    bltz    $s0, branch3    # you need to subtract 2 from the offset calculated by mipshelper.
    j       error 
	
	done:
	j done
	error:
	j error