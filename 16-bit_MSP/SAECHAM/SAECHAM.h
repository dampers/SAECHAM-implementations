/*
 * SAECHAM.h
 *
 *  Created on: 2024. 9. 12.
 *      Author: MYOUNGSU
 */

#ifndef SAECHAM_H_
#define SAECHAM_H_

#include <stdint.h>

void SAECHAM_encrypt_fastest(uint16_t* dst, const uint16_t* src, const uint16_t* rks);
void SAECHAM_encrypt_4R(uint16_t* dst, const uint16_t* src, const uint16_t* rks);
void SAECHAM_encrypt_4R_2(uint16_t* dst, const uint16_t* src, const uint16_t* rks);
void SAECHAM_encrypt_2R(uint16_t* dst, const uint16_t* src, const uint16_t* rks);


#endif /* SAECHAM_H_ */
