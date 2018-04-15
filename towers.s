	.arch armv6
	.fpu vfp
	.text
        .extern printf
@ print function is complete, no modifications needed
    .global	print
    .global     p

print:
	stmfd	sp!, {r3, lr}
	mov	r3, r0
	mov	r2, r1
	ldr	r0, startstring
	mov	r1, r3
	bl	printf
	ldmfd	sp!, {r3, pc}

p:
        push {r0, r9, ip, lr}
        mov     r9, r0
        ldr     r0, stri
        bl      printf
        pop {r0, r9, ip, pc}

stri:
        .word   s

startstring:
	.word	string0

    .global	towers
towers:
   /*//sub sp, sp, #4
   //str lr, [sp, #0]

   //push {lr}
   //push {r0-r8}
   //mov r3, #0
   //mov r4, r1
   //mov r5, r2
   //mov r6, #0
   //mov r1, #20
   //mov r2, #15
   //mov r0, #3
   //mov r7, #12
   //mov r8, #13  */


   /* Save calllee-saved registers to stack */
   // represent original copies
   /* r4 is numDiscs
      r5 is start
      r6 is goal
      r7 is steps
      r8 is peg */

   push {lr}
   
   sub sp, sp, #20
   str r4, [sp, #0]
   str r5, [sp, #4]
   str r6, [sp, #8]
   str r7, [sp, #12]
   str r8, [sp, #16]

   //bl p
   /* Save a copy of all 3 incoming parameters as original parameters*/
   
   mov r4, r0
   mov r5, r1
   mov r6, r2
   
   //bl p

if:
   /* Compare numDisks with 2 or (numDisks - 2)*/
   cmp r0, #2
   /* Check if less than, else branch to else */
   bge else
   /* set print function's start to incoming start */
   mov r0, r1
   /* set print function's end to goal */
   mov r1, r2
   /* call print function */
   bl print
   /* Set return register to 1 */
   mov r0, #1
   /* branch to endif */
   bl endif

else:
   /* Use a callee-saved varable for temp and set it to 6 */
   // r8 = temp = peg
   mov r8, #6
   /* Subract start from temp and store to itself */
   sub r8, r8, r1
   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/
   sub r8, r8, r2
   /* subtract 1 from original numDisks and store it to numDisks parameter */
   sub r0, r0, #1
   /* Set end parameter as temp */
   mov r2, r8
   /* Call towers function */
   bl towers
   /* Save result to callee-saved register for total steps */
   mov r7, r0
   /* Set numDiscs parameter to 1 */
   mov r0, #1
   /* Set start parameter to original start */
   mov r1, r5
   /* Set goal parameter to original goal */
   mov r2, r6
   /* Call towers function */
   bl towers
   /* Add result to total steps so far */
   add r7, r7, r0
   /* Set numDisks parameter to original numDisks - 1 */
   sub r0, r4, #1
   /* set start parameter to temp */
   mov r1, r8
   /* set goal parameter to original goal */
   mov r2, r6
   /* Call towers function */
   bl towers
   /* Add result to total steps so far and save it to return register */
   add r0, r7, r0
endif:
   /* Restore Registers */
   //ldmfd   sp!, {pc}
   ldr r4, [sp, #0]
   ldr r5, [sp, #4]
   ldr r6, [sp, #8]
   ldr r7, [sp, #12]
   ldr r8, [sp, #16]
   add sp, sp, #20

   pop {pc}

@ Function main is complete, no modifications needed
    .global	main
main:
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r0, printdata
	bl	printf
	ldr	r0, printdata+4
	add	r1, sp, #12
	bl	scanf
	ldr	r0, [sp, #12]
	mov	r1, #1
	mov	r2, #3
	bl	towers
	str	r0, [sp]
	ldr	r0, printdata+8
	ldr	r1, [sp, #12]
	mov	r2, #1
	mov	r3, #3
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	ldr	pc, [sp], #4
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

s:
        .asciz "r1 is %d, r2 is %d, r3 is %d, r4 is %d, r5 is %d, r6 is %d, r7 is %d, r8 is %d, r9 is %d\n"
string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"
