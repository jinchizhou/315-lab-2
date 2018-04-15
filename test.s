.text
.global main
.extern printf

main:
   push {lr}
   mov r5, r0
   mov r1, #1024
   mov r2, #6
   mov r4, #90
   mov r3, #67
   mov r5, #21
   mov r6, r5
   ldr r0, =string
   bl printf
   pop {pc}

.data
string: .asciz "r1 is %d, r2 is %d, r3 is %d, r4 is %d, r5 is %d, r6 is %d\n"


