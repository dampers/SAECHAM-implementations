/*
 * author: Myoungsu Shin (houma757@gmail.com)
 * Cryptographic Algorithm Lab.
 * Graduate School of Cybersecurity, Korea University
 */

.syntax unified

@ void SAECHAM_enc_v5(const uint16_t* pt, uint16_t* ct, uint16_t* rk)
.global SAECHAM_enc_v5
.type   SAECHAM_enc_v5,%function

.align 2

// R0 : pt address
// R1 : ct address
// R2 : rk address
// R3 : rk
// R4, R5, R6, R7 : X[0] X[1] X[2] X[3]
// R8 : rc
// R9 : 0xFFFF
// R10: tmp0
// R11: tmp1
// R12
// R13
// R14

.macro EVEN_ROUND A, B, C, D
	REV16 R11, \B

	LDRH R3, [R2], #2				// rk = load(r2+=2)
	EOR  R11, R11, R3				// tmp1 = tmp1 ^ rk

	REV16 \A, \A

	EOR  \A, \A, R8					// A ^= rc
	ADD  R8, R8, #1					// rc += 1

	ADD  \A, \A, R11				// A += tmp1
	AND  \A, \A, R9					// A &= 0xFFFF

.endm

.macro ODD_ROUND A, B, C, D
	REV16 R11, \B

	LDRH R3, [R2], #2				// rk = load(r2+=2)
	EOR  R11, R11, R3				// tmp1 = tmp1 ^ rk

	AND  R10, R9, \A, LSL #7		// tmp0 = 0xFFFF & (A << 7)
	EOR  \A, R10, \A, LSR #9		// A = tmp0 ^ (A >> 9)

	EOR  \A, \A, R8					// A ^= rc
	ADD  R8, R8, #1					// rc += 1

	ADD  \A, \A, R11				// A += tmp1
	AND  \A, \A, R9					// A &= 0xFFFF

.endm

.macro ROUND4 A, B, C, D
	EVEN_ROUND \A, \B, \C, \D
	ODD_ROUND \B, \C, \D, \A
	EVEN_ROUND \C, \D, \A, \B
	ODD_ROUND \D, \A, \B, \C
.endm

.macro ROUND8 A, B, C, D
	EVEN_ROUND \A, \B, \C, \D
	ODD_ROUND \B, \C, \D, \A
	EVEN_ROUND \C, \D, \A, \B
	ODD_ROUND \D, \A, \B, \C
	EVEN_ROUND \A, \B, \C, \D
	ODD_ROUND \B, \C, \D, \A
	EVEN_ROUND \C, \D, \A, \B
	ODD_ROUND \D, \A, \B, \C
.endm

.macro ROUND16 A, B, C, D
	ROUND8 \A, \B, \C, \D
	ROUND8 \A, \B, \C, \D
.endm

SAECHAM_enc_v5:
	PUSH	{R4-R11,LR}

	// LOAD
	EOR  R8, R8, R8
	LDM  R0!, {R4, R6}
	LSR  R5, R4, #16
	LSR  R7, R6, #16
	UXTH R4, R4
	UXTH R6, R6
	MOVW R9, #0xFFFF

	ADD  R14, R2, #32


rounds:
	ROUND8 R4, R5, R6, R7
	CMP  R2, R14
	BNE  check_rk
	SUB  R2, R2, #32

check_rk:
	CMP  R8, #80
	BNE  rounds

	ROUND8  R4, R5, R6, R7


	// STORE
	EOR  R4, R4, R5, LSL #16
	EOR  R6, R6, R7, LSL #16


	// RETURN
	STM 	R1!, {R4, R6}

	// EPILOG
	POP 	{R4-R11,PC}
	// BX      LR
