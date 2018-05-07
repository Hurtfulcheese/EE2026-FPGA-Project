@echo off
set xv_path=C:\\Xilinx\\vivadooo\\Vivado\\2016.2\\bin
call %xv_path%/xsim AUDIO_FX_TOP_behav -key {Behavioral:sim_1:Functional:AUDIO_FX_TOP} -tclbatch AUDIO_FX_TOP.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
