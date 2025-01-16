	.global SAECHAM_encrypt_4R_2
.section .text

; rol8 : swpb a
; rol7 : swpb a, bit #1, a, rrc a
; rol1 : rla a, adc a
; ror1 : bit #1, a, rrc a


SAECHAM_encrypt_4R_2:

	push r4
	push r5
	push r6
	push r7

	; r12 : ct ptr
	; r13 : pt ptr
	; r14 : rk ptr

	mov @r13+, r4		; pt0
	mov @r13+, r5		; pt1
	mov @r13+, r6		; pt2
	mov @r13+, r7		; pt3

	clr r15				; rc
	mov #0xFF1F, r11	; for rk ptr

	; r13 tmp

	swpb r4				; ROL8(X[0])
round_loop:
	and  r11, r14		; rk ptr set
	swpb r5				; ROL8(X[1])
	mov  r5, r13		; tmp = X[1]
	xor  r15, r4			; X[0] ^= rc
	xor  @r14+, r13		; tmp ^= rk
	add  r13, r4		; X[0] += tmp
	inc  r15

	bit  #1, r5
	rrc  r5				; ROR1(X[1])
	swpb r6				; ROL8(X[2])
	mov  r6, r13		; tmp = X[2]
	xor  r15, r5			; X[1] ^= rc
	xor  @r14+, r13		; tmp ^= rk
	add  r13, r5		; X[1] += tmp
	inc  r15

	swpb r7				; ROL8(X[3])
	mov  r7, r13		; tmp = X[3]
	xor  r15, r6			; X[2] ^= rc
	xor  @r14+, r13		; tmp ^= rk
	add  r13, r6		; X[2] += tmp
	inc  r15

	bit  #1, r7
	rrc  r7				; ROR1(X[3])
	swpb r4				; ROL8(X[0])
	mov  r4, r13		; tmp = X[0]
	xor  r15, r7			; X[3] ^= rc
	xor  @r14+, r13		; tmp ^= rk
	add  r13, r7		; X[3] += tmp
	inc  r15

	cmp  #88, r15
	jne  round_loop

	swpb r4

	mov r4, 0(r12)
	mov r5, 2(r12)
	mov r6, 4(r12)
	mov r7, 6(r12)

	pop r7
	pop r6
	pop r5
	pop r4

	ret
