	.arch armv6
	.fpu vfp
	.text

@ print function is complete, no modifications needed
    .global	print
print:
	stmfd	sp!, {r3, lr}
	mov	r3, r0
	mov	r2, r1
	ldr	r0, startstring
	mov	r1, r3
	bl	printf
	ldmfd	sp!, {r3, pc}

startstring:
	.word	string0

    .global	towers
towers:
   /* Save calllee-saved registers to stack */
   
   /* Save a copy of all 3 incoming parameters */

if:
   /* Compare numDisks with 2 or (numDisks - 2)*/
   /* Check if less than, else branch to else */
   
   /* set print function's start to incoming start */
   /* set print function's end to goal */
   /* call print function */
   /* Set return register to 1 */
   /* branch to endif */
else:
   /* Use a callee-saved varable for temp and set it to 6 */
   /* Subract start from temp and store to itself */
   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/

   /* subtract 1 from original numDisks and store it to numDisks parameter */

   /* Set end parameter as temp */
   /* Call towers function */
   /* Save result to callee-saved register for total steps */
   /* Set numDiscs parameter to 1 */
   /* Set start parameter to original start */
   /* Set goal parameter to original goal */
   /* Call towers function */
   /* Add result to total steps so far */
   
   /* Set numDisks parameter to original numDisks - 1 */
   /* set start parameter to temp */
   /* set goal parameter to original goal */
   /* Call towers function */
   /* Add result to total steps so far and save it to return register */

endif:
   /* Restore Registers */

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
