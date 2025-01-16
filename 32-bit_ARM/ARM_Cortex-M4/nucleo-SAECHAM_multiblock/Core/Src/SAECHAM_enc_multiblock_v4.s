/*
 * author: Myoungsu Shin (houma757@gmail.com)
 * Cryptographic Algorithm Lab.
 * Graduate School of Cybersecurity, Korea University
 */

.syntax unified
// .thumb

@ void SAECHAM_enc_multiblock_v4(const uint16_t* pt, uint16_t* ct, uint16_t* rk)
.global SAECHAM_enc_multiblock_v4
.type   SAECHAM_enc_multiblock_v4,%function

.align 2


// R0 : pt address -> 0x00010000
// R1 : ct address
// R2 : rk address
// R3 : rk
// R4, R5, R6, R7 : X[0] X[1] X[2] X[3]
// R8 : rc
// R9 : 0x80008000
// R10: tmp0
// R11: tmp1
// R12: 0x7fff7fff
// R14: 0xFFFF

.macro UADD16 A, B, T, D
	EOR		\T, \A, \B
	ADD		\D, \A, \B
	EOR		\T, \T, \D
	AND		\T, \T, R0
	SUB		\D, \D, \T
.endm


.macro INIT_EVEN_ROUND A, B
	// ROL8
	REV16	\A, \A					// A = reverse_16bit(A)
	// ROL8
	REV16	R10, \B					// tmp0 = reverse_16bit(B)

	// add roundkey
	LDRH	R3, [R2], #2				// rk = load(r2+=2)
	EOR		R10, R10, R3				// tmp0 = tmp0 ^ rk
	EOR		R10, R10, R3, LSL #16		// tmp0 = tmp0 ^ (rk << 16)

	// addition16
	UADD16	\A, R10, R11, \A			// uadd16(A, tmp0, tmp1, A)
.endm


.macro EVEN_ROUND A, B
	// ROL8
	REV16	R10, \B					// tmp0 = reverse_16bit(B)

	// add roundkey
	LDRH	R3, [R2], #2				// rk = load(r2+=2)
	EOR		R10, R10, R3				// tmp0 = tmp0 ^ rk
	EOR		R10, R10, R3, LSL #16		// tmp0 = tmp0 ^ (rk << 16)

	// add round counter
	EOR		\A, \A, R8					// A ^= rc
	ADD		R8, R8, R9, LSR #15			// rc += 0x00010001

	// addition16
	UADD16	\A, R10, R11, \A			// uadd16(A, tmp0, tmp1, A)
.endm

.macro ODD_ROUND A, B
	// ROL8
	REV16	\A, \A						// A = reverse_16bit(A)
	// ROR1
	AND		R10, R12, \A, LSR #1		// tmp0 = 0x7fff7fff & (A >> 1)
	AND		R11, R9,  \A, LSL #15		// tmp1 = 0x80008000 & (A << 15)
	ORR		\A, R10, R11				// A = tmp0 | tmp1

	// ROL8
	REV16	\B, \B						// B = reverse_16bit(B)

	// add roundkey
	LDRH	R3, [R2], #2				// rk = load(r2+=2)
	EOR		R10, \B, R3					// tmp0 = B ^ rk
	EOR		R10, R10, R3, LSL #16		// tmp0 = tmp0 ^ (rk << 16)

	// add round counter
	EOR		\A, \A, R8					// A ^= rc
	ADD		R8, R8, R9, LSR #15			// rc += 0x00010001

	// addition16
	UADD16	\A, R10, R11, \A			// uadd16(A, tmp0, tmp1, A)
.endm

.macro LAST_ODD_ROUND A, B
	// ROL8
	REV16	\A, \A						// A = reverse_16bit(A)
	// ROR1
	AND		R10, R12, \A, LSR #1		// tmp0 = 0x7fff7fff & (A >> 1)
	AND		R11, R9,  \A, LSL #15		// tmp1 = 0x80008000 & (A << 15)
	ORR		\A, R10, R11				// A = tmp0 | tmp1

	// ROL8
	REV16	R10, \B						// tmp0 = reverse_16bit(B)

	// add roundkey
	LDRH	R3, [R2], #2				// rk = load(r2+=2)
	EOR		R10, R10, R3				// tmp0 = tmp0 ^ rk
	EOR		R10, R10, R3, LSL #16		// tmp0 = tmp0 ^ (rk << 16)

	// add round counter
	EOR		\A, \A, R8					// A ^= rc

	// addition16
	UADD16	\A, R10, R11, \A			// uadd16(A, tmp0, tmp1, A)
.endm


.macro INIT_ROUND4 A, B, C, D
	INIT_EVEN_ROUND \A, \B
	ODD_ROUND \B, \C
	EVEN_ROUND \C, \D
	ODD_ROUND \D, \A
.endm

.macro ROUND4 A, B, C, D
	EVEN_ROUND \A, \B
	ODD_ROUND \B, \C
	EVEN_ROUND \C, \D
	ODD_ROUND \D, \A
.endm

.macro LAST_ROUND4 A, B, C, D
	EVEN_ROUND \A, \B
	ODD_ROUND \B, \C
	EVEN_ROUND \C, \D
	LAST_ODD_ROUND \D, \A
.endm

.macro INIT_ROUND16 A, B, C, D
	INIT_ROUND4 \A, \B, \C, \D
	ROUND4 \A, \B, \C, \D
	ROUND4 \A, \B, \C, \D
	ROUND4 \A, \B, \C, \D
.endm

.macro ROUND16 A, B, C, D
	ROUND4 \A, \B, \C, \D
	ROUND4 \A, \B, \C, \D
	ROUND4 \A, \B, \C, \D
	ROUND4 \A, \B, \C, \D
.endm

SAECHAM_enc_multiblock_v4:
	PUSH	{R4-R12,LR}

	// LOAD
	LDM  R0!, {R4-R7}

	MOVW	R14, #0xFFFF
	MOV		R9,  #0x8000
	LSL		R0, R9, #1
	ADD		R9, R9, R9, LSL #16
	MVN		R12, R9
	LSR		R8, R9, #15

	// SWAPMOVE(A, B, 0x0000FFFF, 16)
    // R10 : tmp
    // P0 = R4, P1 = R6
    EOR     R10, R6, R4, LSR #16
    AND     R10, R10, R14
    EOR     R6, R6, R10
    EOR     R4, R4, R10, LSL #16

    // P2 = R5, P3 = R7
    EOR     R10, R7, R5, LSR #16
    AND     R10, R10, R14
    EOR     R7, R7, R10
    EOR     R5, R5, R10, LSL #16


	// enc
	INIT_ROUND16 R4, R6, R5, R7
	SUB  R2, R2, #32
	ROUND16 R4, R6, R5, R7
	SUB  R2, R2, #32
	ROUND16 R4, R6, R5, R7
	SUB  R2, R2, #32
	ROUND16 R4, R6, R5, R7
	SUB  R2, R2, #32
	ROUND16 R4, R6, R5, R7
	SUB  R2, R2, #32

	ROUND4  R4, R6, R5, R7
	LAST_ROUND4  R4, R6, R5, R7


	// STORE
	// SWAPMOVE(A, B, 0x0000FFFF, 16)

    EOR     R10, R6, R4, LSR #16
    AND     R10, R10, R14
    EOR     R6, R6, R10
    EOR     R4, R4, R10, LSL #16

    EOR     R10, R7, R5, LSR #16
    AND     R10, R10, R14
    EOR     R7, R7, R10
    EOR     R5, R5, R10, LSL #16


	// RETURN
	STM 	R1!, {R4-R7}

	// EPILOG
	POP 	{R4-R12,PC}
	// BX      LR
