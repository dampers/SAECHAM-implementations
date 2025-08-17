# SAECHAM: Secure And Efficient Lightweight Block Cipher CHAM Variant

[![IEEE IoT Journal](https://img.shields.io/badge/Published%20in-IEEE%20IoT%20Journal-00629B.svg)](https://ieeexplore.ieee.org/document/YOUR_PAPER_LINK_HERE) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository provides various optimized implementations of **SAECHAM (Secure And Efficient CHAM)**, a lightweight ARX (Addition-Rotation-XOR) based block cipher. SAECHAM significantly enhances the security and efficiency of the original CHAM block cipher.

This research was published in **IEEE Internet of Things Journal**.

DOI: 10.1109/JIOT.2025.3569746

---

## 📖 Overview

SAECHAM is designed for resource-constrained IoT devices and embedded systems. By restructuring the order of operations and rotation amounts of the existing CHAM-64/128 cipher, SAECHAM achieves enhanced security against differential and linear cryptanalysis and delivers faster encryption speeds across various MCU environments.

Key improvements of SAECHAM include:

* **Optimized Operational Structure**: After analyzing six possible operational permutation structures of CHAM, the most efficient structure (CHAM-RXA) was adopted to reduce the number of instructions in 8/16-bit MCU environments.
* **Enhanced Security**: Through an SMT solver-based automated analysis of 62 CHAM variants, SAECHAM was proven to have security equal to or better than CHAM64. It exhibits stronger resistance, particularly against differential cryptanalysis.
* **Superior Performance**: SAECHAM demonstrates superior performance compared to the original CHAM64 on all tested platforms, from low-power MCUs to high-performance CPUs using SIMD instructions.

---

## 🚀 Performance Highlights

SAECHAM shows significant performance improvements over CHAM64 across a wide range of environments. (cpb: cycles per byte)

| Environment | SAECHAM | CHAM64 | Performance Improvement |
| :--- | :--- | :--- | :--- |
| **8-bit AVR** | 137.0 cpb | 148.1 cpb | **~8.1%** |
| **16-bit MSP430** | 99.8 cpb | 114.6 cpb | **~14.7%** |
| **ARM Cortex-M3** | 84.0 cpb | 89.6 cpb | **~6.6%** |
| **ARM Cortex-M4** | 70.8 cpb | 82.4 cpb | **~16.3%** |
| **AVX2 (SIMD)** | 1.885 cpb | 2.071 cpb | **~9.8%** |
| **AVX512 (SIMD)** | 1.503 cpb | 1.631 cpb | **~8.5%** |
| **NEON (SIMD)** | 5.865 cpb | 7.554 cpb | **~28.7%** |

*For a full performance comparison, please refer to Table II in the paper.*

---

## 🛠️ Supported Platforms & IDEs

The implementations in this repository have been tested and verified on the following target MCUs and IDEs. Optimized assembly code is included for each platform directory.

| Platform | Target MCU | IDE |
| :--- | :--- | :--- |
| **8-bit AVR** | Atmel ATmega128 | Microchip Studio |
| **16-bit MSP430** | Texas Instruments MSP430F1611 | Code Composer Studio |
| **32-bit ARM Cortex-M3** | STMicroelectronics STM32F103RB | STM32CubeIDE |
| **32-bit ARM Cortex-M4** | STMicroelectronics STM32F407VGT6 | STM32CubeIDE |

---

## ⚙️ Getting Started

### 1. Clone Repository

First, clone this repository to your local machine.

```bash
git clone [https://github.com/dampers/SAECHAM-implementations.git](https://github.com/dampers/SAECHAM-implementations.git)
cd SAECHAM-implementations
```
### 2. Platform-Specific Instructions

Below are the specific instructions to compile and run the code for each supported platform.

---

#### 📁 **For 8-bit AVR (ATmega128)**

This implementation is optimized for the Atmel ATmega128 MCU and is ready to be compiled using Microchip Studio.

1.  **Navigate to Directory**: Open the `AVR/` folder in your cloned repository.
2.  **Open Project**: Launch **Microchip Studio** and open the solution file (`.sln`) located in the directory.
3.  **Configure Toolchain**:
    * Connect your ATmega128-based board (e.g., via an STK600 or similar programmer).
    * Go to `Project > Properties > Tool` and select your programmer/debugger. Ensure the target device is set to ATmega128.
4.  **Build the Project**: Compile the code by selecting `Build > Build Solution` from the top menu or by pressing `F7`.
5.  **Flash to Device**: Upload the compiled firmware to the microcontroller by selecting `Debug > Start Without Debugging` or pressing `Ctrl+Alt+F5`.
6.  **View Output**: Open a serial terminal program (like Tera Term or the serial monitor in Microchip Studio), connect to the board's COM port, and set the baud rate to view the encryption results and performance benchmarks.

---

#### 📁 **For 16-bit MSP430 (MSP430F1611)**

This implementation targets the Texas Instruments MSP430F1611 and uses a Code Composer Studio project.

1.  **Navigate to Directory**: Locate the `MSP430/` folder in your repository.
2.  **Import Project**:
    * Launch **Code Composer Studio (CCS)**.
    * Select `File > Import...`.
    * Choose `CCS > CCS Projects` and click `Next`.
    * Click `Browse...` and select the `MSP430/` directory as the search directory. The SAECHAM project should appear in the list.
    * Click `Finish` to import the project into your workspace.
3.  **Build the Project**: In the `Project Explorer` panel, right-click on the project name and select `Build Project`.
4.  **Debug and Run**:
    * Connect your MSP430 target board (e.g., an MSP-FET or LaunchPad).
    * Click the **Debug** icon (the green bug) in the toolbar. This will flash the code onto the device and start a debugging session.
    * Press the **Resume** button (or `F8`) to run the code.
5.  **View Output**: The performance results will be printed to the `Console` window within CCS.

---

#### 📁 **For 32-bit ARM Cortex-M3/M4 (STM32)**

These implementations are designed for STMicroelectronics STM32 MCUs and are provided as STM32CubeIDE projects.

1.  **Navigate to Directory**: Choose the appropriate folder for your device: `ARM/Cortex-M3/` for the STM32F103RB or `ARM/Cortex-M4/` for the STM32F407VGT6.
2.  **Import Project**:
    * Launch **STM32CubeIDE**.
    * Select `File > Import...`.
    * Choose `General > Existing Projects into Workspace` and click `Next`.
    * For `Select root directory`, browse to and select the chosen MCU folder (e.g., `ARM/Cortex-M4/`).
    * Ensure the project is checked in the `Projects` list and click `Finish`.
3.  **Build the Project**: Select the project in the `Project Explorer`. Click the **Build** icon (the hammer) in the toolbar or press `Ctrl+B`.
4.  **Run on Device**:
    * Connect your STM32 Nucleo or Discovery board. The ST-Link debugger should be automatically detected.
    * Click the **Run** icon (the green play button) in the toolbar or press `Ctrl+F11`. This will compile, flash, and run the application on the target board.
5.  **View Output**: The encryption results and cycle counts will be displayed in the IDE's console via the Semihosting output or can be monitored through a configured UART serial connection.

---

## 🔐 Security Analysis

SAECHAM has undergone rigorous security validation using automated analysis tools.

* [cite_start]**Differential Analysis**: The optimal differential probability for 39 rounds is $2^{-65}$, which is lower than CHAM64's $2^{-63}$, indicating higher security against differential attacks. [cite: 453, 460, 480]
* [cite_start]**Linear Analysis**: The optimal linear correlation for 36 rounds is $2^{-31}$, maintaining the same level of resistance as CHAM64. [cite: 430, 432]

[cite_start]For detailed round-by-round analysis results, please refer to Table VII and Table VIII in our paper. [cite: 485]

---

## 📜 Citation

If you find this work and its implementations useful in your research, we would appreciate a citation to our paper.

```bibtex
@ARTICLE{SAECHAM_IoTJ,
  author={Shin, Myoungsu and Shin, Hanbeom and Kim, Insung and Kim, Sunyeop and Lee, Dongjae and Hong, Deukjo and Sung, Jaechul and Hong, Seokhie},
  journal={IEEE Internet of Things Journal}, 
  title={SAECHAM: Secure And Efficient Lightweight Block Cipher CHAM Variant}, 
  year={2025},
  volume={12},
  number={15},
  pages={29989 - 30002},
  doi={10.1109/JIOT.2025.3569746}
}
```

---

## 📄 라이선스 (License)

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

---

## 📧 연락처 (Contact)

* **Myoungsu Shin (First Author)**
    * Email: (houma757@gmail.com)
    * GitHub: [dampers](https://github.com/dampers)
* **Seokhie Hong (Corresponding Author)**
    * Email: shhong@korea.ac.kr