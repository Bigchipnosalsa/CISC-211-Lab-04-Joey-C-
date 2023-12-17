/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    LDR r1,=balance
    LDR r2,[r1]
    ADD r0,r0,r2
.endif

    /*** STUDENTS: Place your code BELOW this line!!! **************/
   /*constant variable*/
   MOV r3,0
    /*initialize all variables/labels to 0 */
   LDR r1, =transaction
   STR r3, [r1]
   LDR r1, =eat_out
   STR r3, [r1]
   LDR r1, =stay_in
   STR r3, [r1]
   LDR r1, =eat_ice_cream
   STR r3, [r1]
   LDR r1, =we_have_a_problem
   STR r3, [r1]
   
   /*input transaction value passed bc c code in r0 loaded to transaction label mem location*/
   LDR r1, =transaction
   /*copying passed value into memory location pointed to by transaction*/
   STR r0, [r1]
   
   LDR R2, =1000
   CMP r0, r2
   /*test if >1000  signed since negatives are possibilities
   branch activated if Z = 0 and N = V */
   BGT out_of_range
   
   /*bring immediate value to a register so we can use it in instructions*/
   LDR r2, =-1000
   /*CMP updates condition flags based on result and discards result*/
   CMP r0,r2
   /* branches if N is not = V, i.e N=1, V=0 vice versa */
   BLT out_of_range
   
   
   /*if niether branch is tripped then amount is in accceptable range */
   LDR r4, =balance
   LDR r6,[r4]
   /*add balance and transaction. R3 will now be out tmpBalance*/
   ADDS r3,r0,r6
   BVS out_of_range
   BVC no_overflow_a
   
   no_overflow_a:
   /*balance value @ mem location r4 replaced with tmpbalance held at r3 (since registers were not updated)*/
   STR r3,[r4]
   MOV r7,0
   /*branch based on conditional, is balance(r6) greater or less than 0? */
   CMP r6,r7
   BGT update_eat_out
   BLT update_stay_in
   
   MOV r3, 1
   LDR r1, =eat_ice_cream
   STR r3, [r1]
   LDR r4, = balance
   LDR r0, [r4]
   b done 
   
   out_of_range:
   MOV r3,0
   LDR r6, =transaction
   STR r3, [r6]
   MOV r3,1
   LDR r4, =we_have_a_problem
   STR r3, [r4]
   LDR r5, =balance
   LDR r0, [r5]
   /*updates passed value in r0, now equals vaue held at balance label*/
   b done
   
      /* constant of 1 replaces the variable value eat_out it balance > 0 */
   update_eat_out:
   MOV r3, 1
   LDR r1, =eat_out
   STR r3, [r1]
   LDR r4, = balance
   LDR r0, [r4]
   b done
   
      /* constant of 1 replaces the variable value stay_in it balance > 0 */
   update_stay_in:
   MOV r3, 1
   LDR r1, =stay_in
   STR r3, [r1]
   LDR r4, = balance
   LDR r0, [r4]
   b done
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




