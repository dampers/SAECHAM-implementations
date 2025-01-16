	.global SAECHAM_encrypt_2R
.section .text

; rol8 : swpb a
; rol7 : swpb a, bit #1, a, rrc a
; rol1 : rla a, adc a
; ror1 : bit #1, a, rrc a


SAECHAM_encrypt_2R:
	push r4
	push r5
	push r6
	push r7
	push r9

	; r12 : ct ptr
	; r13 : pt ptr
	; r14 : rk ptr

	mov @r13+, r4		; pt0
	mov @r13+, r5		; pt1
	mov @r13+, r6		; pt2
	mov @r13+, r7		; pt3

	clr r15				; rc
	mov #88, r9			; for loop
	mov #0xFF1F, r11	; for rk ptr

	; r13 tmp

round_loop:
	and  r11, r14		; rk ptr set
	swpb r4				; ROL8(X[0])
	swpb r5				; ROL8(X[1])
	mov  r5, r13		; tmp = X[1]
	xor  r15, r4		; X[0] ^= rc
	xor  @r14+, r5		; X[1] ^= rk
	add  r5, r4			; X[0] += X[1]
	inc  r15

	bit  #1, r13
	rrc  r13			; ROR1(tmp)
	mov  r6, r5			; X[1] = X[2]
	swpb r6				; ROL8(X[2])
	xor  r15, r13		; tmp ^= rc
	xor  @r14+, r6		; X[2] ^= rk
	add  r6, r13		; tmp += X[2]
	inc  r15

	mov  r4, r6			; X[2] = X[0]
	mov  r5, r4			; X[0] = X[1]
	mov  r7, r5			; X[1] = X[3]
	mov  r13,r7			; X[3] = tmp

	cmp  r15, r9
	jne  round_loop


	mov r4, 0(r12)
	mov r5, 2(r12)
	mov r6, 4(r12)
	mov r7, 6(r12)

	pop r9
	pop r7
	pop r6
	pop r5
	pop r4

	ret
