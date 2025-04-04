/*
 * main.c
 *
 * Created: 2024-09-02 오후 12:13:45
 *  Author: MYOUNGSU
 */ 
#include <avr/io.h>
#include "SAECHAM.h"

uint8_t mk[16] __attribute__ ((section(".MKSection"))) = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
};

uint8_t rks[32] __attribute__ ((section(".RKSection"))) = {
	0x01, 0x03, 0x05, 0x07, 0x09, 0x0b, 0x0d, 0x0f,
	0x11, 0x13, 0x15, 0x17, 0x19, 0x1b, 0x1d, 0x1f,
	0x1e, 0x15, 0x08, 0x03, 0x32, 0x39, 0x24, 0x2f,
	0x46, 0x4d, 0x50, 0x5b, 0x6a, 0x61, 0x7c, 0x77
	};
/*
uint16_t rks[16] __attribute__ ((section(".RKSection"))) = {0x0301, 0x0705, 0x0B09, 0x0F0D,
															0x1311, 0x1715, 0x1B19, 0x1F1D,
															0x151E, 0x0308, 0x3932, 0x2F24,
														0x4D46, 0x5B50, 0x616A, 0x777C};
*/
uint8_t PT0[16] = {
	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
};


uint8_t CT1[8] = {0x00, };
int8_t CT2[8] = {0x00, };




int main(void)
{
//	SAECHAM_encrypt(CT1, PT0, rks);							// 
//	SAECHAM_encrypt(CT1, PT0, rks);							// 1096 CYCLES - 137 CPB
	SAECHAM_encrypt_fastest(CT1, PT0, rks);							// 
//	SAECHAM_encrypt_2R(CT1, PT0, rks);						// 
	SAECHAM_encrypt_2R(CT1, PT0, rks);						//  1640 CYCLES - 205 CPB, 132 bytes code size, 2byte ram, RANK : 35.86
//	SAECHAM_encrypt_2R(CT1, PT0, rks);						// 
//	SAECHAM_encrypt_4R(CT1, PT0, rks);
	SAECHAM_encrypt_4R(CT1, PT0, rks);						// 1573 CYCLES - 196.75 CPB 
//	SAECHAM_encrypt_4R(CT1, PT0, rks);
	return 0;
}