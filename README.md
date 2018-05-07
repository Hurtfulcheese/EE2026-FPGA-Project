# EE2026 FPGA Design Project

This module is all about CLOCK and endless simulation, synthesis, implementation and writing bitstream on Vivaldo.
and painful debugging.

## Hareware Requirements
* Basys 3<sub>TM</sub> FPGA Board
* PmodMIC3
* PmodDA2
* PmodAMP2
* Speaker
* Monitor
* VGA Cable
<br/>

## Software Environment
* Vivado Design Suite - HLx Editions - V2016.2
<br/>

## Features
* Real-time Microphone-Speaker System
* Microphone-Speaker System
* Electronic Musical Instrument
* 7 segment display
* A **Very** Simple Pong Game
<br/>

## User Guidelines
**1.** SW14 & SW15 to switch between the output.
```
- 2'b00 - real-time audio signal with 7 segment scrolling display of EE2026.
- 2'b01 - requirement 1: real-time audio signal with delays
- 2'b10 - requirement 2: electronic musical instrument
- 2'b11 - extra feature: a very simple pong game
```
<br/>

**2.** SW11 & SW12 (with corresponding SW14 & SW15)
```
- 2'b00 - 0s delay
- 2'b01 - 1s delay 
- 2'b10 - 2s delay
- 7 segment displays the corresponding delays
```
<br/>

**3.** SW0 ~ SW6 & SW7 ~ SW10 (with corresponding SW14 & SW15)
```
- Each of SW0 ~ SW6 switches corresponds to nots of C, D, ..., A, B respectively
- Each of SW7 ~ SW10 switches shift the pitch by 1, 2, 3 or 4 octaves further.
- 7 segment displays the corresponding pitch of C4, C5, C6, etc.
```
<br/>

**4.** BTNL, BTNR & BTNC (with corresponding SW14 & SW15)
```
- BTNL - left
- BTNR - right
- BTNC - reset
- VGA displays **only** a paddle and a moving ball.
- Audio sound presses when the ball hits the paddle
```
<br/>

# Acknowledgements
* NUS Faculty of Engineering
* NUS School of Computing (?)
* http://simplefpga.blogspot.sg
* https://embeddedthoughts.com
<br/>

# Copyright & License
Copyright (c) [@linnnruoo](https://github.com/linnnruoo) & [@QzSG](https://github.com/QzSG) - Released under the [GNU GPLv3 License](LICENSE).
