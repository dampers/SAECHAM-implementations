#include <msp430.h> 
#include "SAECHAM.h"

/**
 * main.c
 */

    uint16_t pt[4] = {0x1100, 0x3322, 0x5544, 0x7766};
    //uint16_t ct[4] = {0xFE47, 0x5393, 0xE6BA, 0x01F1};
    uint16_t ct[4] = {0, };

//    uint16_t rk[16] = {0x0301, 0x0705, 0x0B09, 0x0F0D,
//                       0x1311, 0x1715, 0x1B19, 0x1F1D,
//                       0x151E, 0x0308, 0x3932, 0x2F24,
//                       0x4D46, 0x5B50, 0x616A, 0x777C};
    uint16_t rk[16] __attribute__((section(".RK_section"))) = {0x0301, 0x0705, 0x0B09, 0x0F0D,
                                                               0x1311, 0x1715, 0x1B19, 0x1F1D,
                                                               0x151E, 0x0308, 0x3932, 0x2F24,
                                                               0x4D46, 0x5B50, 0x616A, 0x777C};

void main(void)
{

	SAECHAM_encrypt_fastest(ct, pt, rk);  // 799 cycles : 99.875cpb, code size : 1418 byte, RAM : 16 byte
	SAECHAM_encrypt_4R(ct, pt, rk);  // 848 cycles : 106cpb, code size : 138 , RAM : 10 byte, RANK : 59.7
	SAECHAM_encrypt_4R_2(ct, pt, rk);  // 863 cycles : 107.875cpb, code size : 132 , RAM : 8 byte, RANK : 62.6
	SAECHAM_encrypt_2R(ct, pt, rk);  //  1154 cycles : 144.25cpb, code size : 116 , RAM : 10 byte, RANK : 50.97
}
