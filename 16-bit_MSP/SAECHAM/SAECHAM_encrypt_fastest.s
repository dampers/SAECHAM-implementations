	.global SAECHAM_encrypt_fastest
.section .text

; rol8 : swpb a
; rol7 : swpb a, bit #1, a, rrc a


SAECHAM_encrypt_fastest:

	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r12

	; r12 : ct ptr
	; r13 : pt ptr
	; r14 : rk ptr

	mov @r13+, r4		; pt0
	mov @r13+, r5		; pt1
	mov @r13+, r6		; pt2
	mov @r13+, r7		; pt3

	mov #1, r8			; rc

	mov @r14+, r9		; rk0
	mov @r14+, r10		; rk1
	mov @r14+, r11		; rk2
	mov @r14+, r12		; rk3
	mov @r14+, r13		; rk4
	; r15 tmp

	; 0 round
	swpb r4				; X[0] = ROL8(X[0])
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor	 r9, r15		; tmp ^= rk0
	add  r15, r4		; X[0] += tmp

	; 1 round
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r10, r15		; tmp ^= rk1
	xor  r8, r5			; X[1] ^= rc
	add  r15, r5		; X[1] += tmp

	; 2 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  r11, r15		; tmp ^= rk2
	add  r15, r6		; X[2] += tmp

	; 3 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  r12, r15		; tmp ^= rk3
	add  r15, r7		; X[3] += tmp

	; 4 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r13, r15		; tmp ^= rk4
	add  r15, r4		; X[0] += tmp

	; 5 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  0(r14), r15	; tmp ^= rk5
	add  r15, r5		; X[1] += tmp

	; 6 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  2(r14), r15	; tmp ^= rk6
	add  r15, r6		; X[2] += tmp

	; 7 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  4(r14), r15	; tmp ^= rk7
	add  r15, r7		; X[3] += tmp


	; 8 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  6(r14), r15	; tmp ^= rk8
	add  r15, r4		; X[0] += tmp

	; 9 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  8(r14), r15	; tmp ^= rk9
	add  r15, r5		; X[1] += tmp

	; 10 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  10(r14), r15	; tmp ^= rk10
	add  r15, r6		; X[2] += tmp

	; 11 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  12(r14), r15	; tmp ^= rk11
	add  r15, r7		; X[3] += tmp


	; 12 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  14(r14), r15	; tmp ^= rk12
	add  r15, r4		; X[0] += tmp

	; 13 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  16(r14), r15	; tmp ^= rk13
	add  r15, r5		; X[1] += tmp

	; 14 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  18(r14), r15	; tmp ^= rk14
	add  r15, r6		; X[2] += tmp

	; 15 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  20(r14), r15	; tmp ^= rk15
	add  r15, r7		; X[3] += tmp


	; 16 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r9, r15		; tmp ^= rk0
	add  r15, r4		; X[0] += tmp

	; 17 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  r10, r15		; tmp ^= rk1
	add  r15, r5		; X[1] += tmp

	; 18 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  r11, r15		; tmp ^= rk2
	add  r15, r6		; X[2] += tmp

	; 19 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  r12, r15		; tmp ^= rk3
	add  r15, r7		; X[3] += tmp


	; 20 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r13, r15		; tmp ^= rk4
	add  r15, r4		; X[0] += tmp

	; 21 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  0(r14), r15	; tmp ^= rk5
	add  r15, r5		; X[1] += tmp

	; 22 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  2(r14), r15	; tmp ^= rk6
	add  r15, r6		; X[2] += tmp

	; 23 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  4(r14), r15	; tmp ^= rk7
	add  r15, r7		; X[3] += tmp


	; 24 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  6(r14), r15	; tmp ^= rk8
	add  r15, r4		; X[0] += tmp

	; 25 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  8(r14), r15	; tmp ^= rk9
	add  r15, r5		; X[1] += tmp

	; 26 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  10(r14), r15	; tmp ^= rk10
	add  r15, r6		; X[2] += tmp

	; 27 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  12(r14), r15	; tmp ^= rk11
	add  r15, r7		; X[3] += tmp


	; 28 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  14(r14), r15	; tmp ^= rk12
	add  r15, r4		; X[0] += tmp

	; 29 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  16(r14), r15	; tmp ^= rk13
	add  r15, r5		; X[1] += tmp

	; 30 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  18(r14), r15	; tmp ^= rk14
	add  r15, r6		; X[2] += tmp

	; 31 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  20(r14), r15	; tmp ^= rk15
	add  r15, r7		; X[3] += tmp


	; 32 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r9, r15		; tmp ^= rk0
	add  r15, r4		; X[0] += tmp

	; 33 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  r10, r15		; tmp ^= rk1
	add  r15, r5		; X[1] += tmp

	; 34 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  r11, r15		; tmp ^= rk2
	add  r15, r6		; X[2] += tmp

	; 35 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  r12, r15		; tmp ^= rk3
	add  r15, r7		; X[3] += tmp


	; 36 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r13, r15		; tmp ^= rk4
	add  r15, r4		; X[0] += tmp

	; 37 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  0(r14), r15	; tmp ^= rk5
	add  r15, r5		; X[1] += tmp

	; 38 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  2(r14), r15	; tmp ^= rk6
	add  r15, r6		; X[2] += tmp

	; 39 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  4(r14), r15	; tmp ^= rk7
	add  r15, r7		; X[3] += tmp


	; 40 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  6(r14), r15	; tmp ^= rk8
	add  r15, r4		; X[0] += tmp

	; 41 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  8(r14), r15	; tmp ^= rk9
	add  r15, r5		; X[1] += tmp

	; 42 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  10(r14), r15	; tmp ^= rk10
	add  r15, r6		; X[2] += tmp

	; 43 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  12(r14), r15	; tmp ^= rk11
	add  r15, r7		; X[3] += tmp


	; 44 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  14(r14), r15	; tmp ^= rk12
	add  r15, r4		; X[0] += tmp

	; 45 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  16(r14), r15	; tmp ^= rk13
	add  r15, r5		; X[1] += tmp

	; 46 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  18(r14), r15	; tmp ^= rk14
	add  r15, r6		; X[2] += tmp

	; 47 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  20(r14), r15	; tmp ^= rk15
	add  r15, r7		; X[3] += tmp


	; 48 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r9, r15		; tmp ^= rk0
	add  r15, r4		; X[0] += tmp

	; 49 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  r10, r15		; tmp ^= rk1
	add  r15, r5		; X[1] += tmp

	; 50 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  r11, r15		; tmp ^= rk2
	add  r15, r6		; X[2] += tmp

	; 51 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  r12, r15		; tmp ^= rk3
	add  r15, r7		; X[3] += tmp


	; 52 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r13, r15		; tmp ^= rk4
	add  r15, r4		; X[0] += tmp

	; 53 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  0(r14), r15	; tmp ^= rk5
	add  r15, r5		; X[1] += tmp

	; 54 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  2(r14), r15	; tmp ^= rk6
	add  r15, r6		; X[2] += tmp

	; 55 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  4(r14), r15	; tmp ^= rk7
	add  r15, r7		; X[3] += tmp


	; 56 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  6(r14), r15	; tmp ^= rk8
	add  r15, r4		; X[0] += tmp

	; 57 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  8(r14), r15	; tmp ^= rk9
	add  r15, r5		; X[1] += tmp

	; 58 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  10(r14), r15	; tmp ^= rk10
	add  r15, r6		; X[2] += tmp

	; 59 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  12(r14), r15	; tmp ^= rk11
	add  r15, r7		; X[3] += tmp


	; 60 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  14(r14), r15	; tmp ^= rk12
	add  r15, r4		; X[0] += tmp

	; 61 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  16(r14), r15	; tmp ^= rk13
	add  r15, r5		; X[1] += tmp

	; 62 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  18(r14), r15	; tmp ^= rk14
	add  r15, r6		; X[2] += tmp

	; 63 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  20(r14), r15	; tmp ^= rk15
	add  r15, r7		; X[3] += tmp


	; 64 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r9, r15		; tmp ^= rk0
	add  r15, r4		; X[0] += tmp

	; 65 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  r10, r15		; tmp ^= rk1
	add  r15, r5		; X[1] += tmp

	; 66 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  r11, r15		; tmp ^= rk2
	add  r15, r6		; X[2] += tmp

	; 67 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  r12, r15		; tmp ^= rk3
	add  r15, r7		; X[3] += tmp


	; 68 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r13, r15		; tmp ^= rk4
	add  r15, r4		; X[0] += tmp

	; 69 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  0(r14), r15	; tmp ^= rk5
	add  r15, r5		; X[1] += tmp

	; 70 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  2(r14), r15	; tmp ^= rk6
	add  r15, r6		; X[2] += tmp

	; 71 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  4(r14), r15	; tmp ^= rk7
	add  r15, r7		; X[3] += tmp


	; 72 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  6(r14), r15	; tmp ^= rk8
	add  r15, r4		; X[0] += tmp

	; 73 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  8(r14), r15	; tmp ^= rk9
	add  r15, r5		; X[1] += tmp

	; 74 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  10(r14), r15	; tmp ^= rk10
	add  r15, r6		; X[2] += tmp

	; 75 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  12(r14), r15	; tmp ^= rk11
	add  r15, r7		; X[3] += tmp


	; 76 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  14(r14), r15	; tmp ^= rk12
	add  r15, r4		; X[0] += tmp

	; 77 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  16(r14), r15	; tmp ^= rk13
	add  r15, r5		; X[1] += tmp

	; 78 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  18(r14), r15	; tmp ^= rk14
	add  r15, r6		; X[2] += tmp

	; 79 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  20(r14), r15	; tmp ^= rk15
	add  r15, r7		; X[3] += tmp

	; 80 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r9, r15		; tmp ^= rk0
	add  r15, r4		; X[0] += tmp

	; 81 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  r10, r15		; tmp ^= rk1
	add  r15, r5		; X[1] += tmp

	; 82 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  r11, r15		; tmp ^= rk2
	add  r15, r6		; X[2] += tmp

	; 83 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	swpb r4				; X[0] = ROL8(X[0])
	mov  r4, r15		; tmp = X[0]
	xor  r8, r7			; X[3] ^= rc
	xor  r12, r15		; tmp ^= rk3
	add  r15, r7		; X[3] += tmp


	; 84 round
	inc  r8
	swpb r5				; X[1] = ROL8(X[1])
	mov  r5, r15		; tmp = X[1]
	xor  r8, r4			; X[0] ^= rc
	xor  r13, r15		; tmp ^= rk4
	add  r15, r4		; X[0] += tmp

	; 85 round
	inc  r8
	bit  #1, r5
	rrc  r5				; X[1] = ROR1(X[1])
	swpb r6				; X[2] = ROL8(X[2])
	mov  r6, r15		; tmp = X[2]
	xor  r8, r5			; X[1] ^= rc
	xor  0(r14), r15	; tmp ^= rk5
	add  r15, r5		; X[1] += tmp

	; 86 round
	inc  r8
	swpb r7				; X[3] = ROL8(X[3])
	mov  r7, r15		; tmp = X[3]
	xor  r8, r6			; X[2] ^= rc
	xor  2(r14), r15	; tmp ^= rk6
	add  r15, r6		; X[2] += tmp

	; 87 round
	inc  r8
	bit  #1, r7
	rrc  r7				; X[3] = ROR1(X[3])
	mov  r4, r15		; tmp = X[0]
	swpb r15			; X[0] = ROL8(X[0])
	xor  r8, r7			; X[3] ^= rc
	xor  4(r14), r15	; tmp ^= rk7
	add  r15, r7		; X[3] += tmp

	pop r12

	mov r4, 0(r12)
	mov r5, 2(r12)
	mov r6, 4(r12)
	mov r7, 6(r12)


	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
    ret
