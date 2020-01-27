
tomato:
addi  $sp, $sp, -12 
sw    $ra, 8($sp) 
sw    $s1  4($sp)
sw    $a0  0($sp) 
slti  $t0, $a0, 3
beq   $t0, $zero, grape
addi  $v0, $zero, 1
j     orange

grape:
addi  $a0, $a0, -1
jal   tomato
add   $s1, $v0, $zero
addi  $a0, $a0, -1
jal   tomato
add   $v0, $v0, $s1

orange:
lw    $a0, 0($sp)
lw    $s1, 4($sp)
lw    $ra, 8($sp)
addi  $sp, $sp, 12
jr    $ra 

.globl  test
test:
addi  $sp, $sp, -4
sw    $ra, 0($sp) 
jal   tomato
lw    $ra,  0($sp)
addi  $sp, $sp, 4
jr    $ra 

.globl main
main: 
addi $sp, $sp, -4 
sw   $ra, 0($sp) 
li   $a0, 2
jal  test 

li   $a0, 3
jal  test 

li   $a0, 4
jal  test 

li   $a0, 10
jal  test 