@echo off
set xv_path=D:\\Programs\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 3b44a48150c1424799e42eb77512c099 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot project_tb_behav xil_defaultlib.project_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
