@echo off

del data.mem 2>nul
del FindMax.asm FindMax.machine 2>nul
del ..\Verilog\Sim\data.mem 2>nul

python AssemblyGenerator.py
..\Utils\Assembler\Assembler.exe FindMax.asm > FindMax.machine
python ..\Utils\DataGenerator\ConvertFromBase10.py ArrayData.txt
python ..\Utils\DataGenerator\InstGenerator.py FindMax.machine

copy data.mem ..\Verilog\Sim
pause
