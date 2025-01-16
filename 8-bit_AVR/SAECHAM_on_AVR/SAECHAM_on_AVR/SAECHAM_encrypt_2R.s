
/*
 * SAECHAM_encrypt_2R.s
 *
 * Created: 2024-09-27 오후 5:02:19
 *  Author: MYOUNGSU
 */ 


 .macro ROR16 LO, HI
	BST \LO, 0
	ROR \HI
	ROR \LO
	BLD \HI, 7
.endm

.macro EOR_RK A0, A1
	LD RK, Z+
	EOR \A0, RK
	LD RK, Z+
	EOR \A1, RK
.endm


.global SAECHAM_encrypt_2R
.type SAECHAM_encrypt_2R, @function

#define RC R18
#define RK R19

#define PT00 R0
#define PT01 R1
#define PT10 R20
#define PT11 R21
#define PT20 R22
#define PT21 R23
#define PT30 R24
#define PT31 R25

#define TM0 R26
#define TM1 R27


SAECHAM_encrypt_2R:
	PUSH R24					//PUSH CT ADDRESS
	PUSH R25

	MOVW R26, R22				// PT : X pointer
	MOVW R30, R20				// RK : Z pointer

	LD PT00, X+
	LD PT01, X+
	LD PT10, X+
	LD PT11, X+
	LD PT20, X+
	LD PT21, X+
	LD PT30, X+
	LD PT31, X+

	CLR RC

	round_loop:

	// EVEN ROUND

	ANDI  R30, 31				// RK_PTR SET
	MOVW  TM0, PT10				// TMP = X[1]

	LD    RK, Z+
	EOR   PT11, RK
	LD    RK, Z+
	EOR   PT10, RK				// X[1] = ROL8(X[1]) ^ RK

	EOR   PT01, RC				// X[0] = ROL8(X[0]) ^ RC
	ADD   PT01, PT11
	ADC   PT00, PT10			// X[0] += X[1]
	INC   RC
	
	// ODD ROUND
	ROR16 TM1, TM0				// TMP = ROR16(TMP)

	MOVW  PT10, PT20			// X[1] = X[2]
	EOR   TM1, RC				// TMP ^= RC
	LD    RK, Z+
	EOR   PT21, RK
	LD    RK, Z+
	EOR   PT20, RK				// X[2] ^= RK

	ADD   TM1, PT21
	ADC   TM0, PT20				// TMP += X[2]
	INC   RC


	MOV   PT20, PT01
	MOV   PT21, PT00			// X[2] = X[0]

	MOVW  PT00, PT10			// X[0] = X[1]
	MOVW  PT10, PT30			// X[1] = X[3]

	MOV   PT30, TM1
	MOV   PT31, TM0				// X[3] = TMP


	CPI   RC, 88
	BRLO  round_loop




	POP R27						// CT : X pointer
	POP R26

	ST X+, PT00
	ST X+, PT01
	ST X+, PT10
	ST X+, PT11
	ST X+, PT20
	ST X+, PT21
	ST X+, PT30
	ST X+, PT31

	CLR R1


	RET