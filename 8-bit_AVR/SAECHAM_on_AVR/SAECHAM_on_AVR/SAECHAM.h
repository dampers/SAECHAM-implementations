/*
 * SAECHAM.h
 *
 * Created: 2025-01-16 오전 10:21:45
 *  Author: MYOUNGSU
 */ 


#ifndef SAECHAM_H_
#define SAECHAM_H_


#include <stdint.h>
#include <stddef.h>


void SAECHAM_encrypt_fastest(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
void SAECHAM_encrypt_2R(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
void SAECHAM_encrypt_4R(uint8_t* dst, const uint8_t* src, const uint8_t* rks);



#endif /* SAECHAM_H_ */