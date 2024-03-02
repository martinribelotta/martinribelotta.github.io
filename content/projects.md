+++
title = "Projects"
slug = "projects"
+++

# Here's a selection of my most interesting projects.

{{< table_of_contents >}}

## [ELF loader](https://github.com/martinribelotta/elfloader)

The goal of this project is provide a loader for ELF file format for ARMv7-M (thumb-2) architecture (Aka Cortex-M, Cortex-R in Thumb2 mode) over bare-metal or RTOS enviroment.

This loader not required MMU or special OS support (only aligned memory alloc) and run with minimun memory overhead (only required parts of files is loaded in memory).

This is developed using gcc arm embedded compiler from GCC arm embedded (arm-none-eabi) but is successful tested with linaro arm-linux-gnueabihf in freestangin mode.

A very complete blog about this project can be [found here](https://ourembeddeds.github.io/blog/2020/08/16/elf-loader/)

![](https://ourembeddeds.github.io/img/articles/elf-loader/mcu-executable-load.png)

## [Embedded Logger](https://github.com/martinribelotta/elog)

This log system is thinked for embedded systems with minimal resource utilization. It's designed to minimize memory compsumition in flash or RAM, enable an eficient in-ram loggin buffer with very efficient storage.

![](https://github.com/martinribelotta/elog/raw/master/doc/objcopy-process.png)

## [Cortex-M monitor/disassembler](https://github.com/martinribelotta/cmx-debug)

This program intent to provide similar function as MSDOS command DEBUG.COM with hex memory dump and disassembler

![image](https://github.com/martinribelotta/cmx-debug/raw/master/docs/screenshoot.png)

## STM32H7 boards and projects

### [STM32H750 industrial board](https://github.com/martinribelotta/h7dragonman)

This board is an industrial-grade controller with an STM32H750 CPU and a plethora of interfaces required for harsh environments, such as CAN, RS485, Ethernet, USB HOST, and Device, along with many GPIOs exposed on expansion headers.

![](https://github.com/martinribelotta/h7dragonman/raw/master/docs/h7-top.png)

The project has varios subproject that support it:

 - [H7-Boot](https://github.com/martinribelotta/h7-boot): Bootloader with external flash XIP support, SD binary load in RAM, SD QSPI reflash and fallback command line
 - [H7 project template](https://github.com/martinribelotta/h7-projects): A simple template with cmake tool for board usage (runs on external flash)
 - [H7 qspi loader](https://github.com/martinribelotta/h7-qspi-loader): Non standarized loader for external QSPI flash using openocd and semihosting
 - [Zephyr example](https://github.com/martinribelotta/h7-zephyr-examples): This repo contains BSP for this board over Zephyr

### [H750 duino](https://github.com/martinribelotta/h730duino)

Arduino form-factor board for hobbyists based on the new STM32H7 with 550MHz, featuring external RAM and FLASH, along with onboard Ethernet and debugger.

![](https://github.com/martinribelotta/h730duino/raw/master/docs/h730duino.png)

Additionally, [this project](https://github.com/martinribelotta/h730duino-firmware) provides the firmware to start with this board.

## [A makefile based, CH32V307 environment](https://github.com/martinribelotta/openwch-makefile)

![](https://avatars.githubusercontent.com/u/96517772?v=4)

The WCH risc-v processors are great, but the dependence on the oficial IDE is very problematic for old fashinist unix hackers.

This project provides an (unoficial) support for WCH CH32V307 SDK that compiles all exaples.

## [Application Launcher](https://gitlab.com/martinribelotta/launcher)

This program serves as a launcher for an application suite or a set of applications with a common entry point.

The idea behind this project is to provide a single entry point and environment management for disparate tools and programs that can work in conjunction to offer software suites.

It is primarily developed to integrate third-party tools as an IDE.

![](https://gitlab.com/martinribelotta/launcher/-/raw/master/doc/lancher-00.png)

## [Embedded IDE](https://github.com/martinribelotta/embedded-ide)

And unmaintained (but usefull for now) little IDE based on Makefile and command line tools

![](https://github.com/martinribelotta/embedded-ide/raw/master/docs/screen_0.png)

