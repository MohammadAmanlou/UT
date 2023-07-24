@echo off

del *.mem instructions.txt 2>nul
del ..\Verilog\Sim\*.mem 2>nul

..\Utils\Assembler\assembler.exe FindMax.asm > instructions.txt
python ..\Utils\DataGenerator\InstructionDivider.py instructions.txt
python ..\Utils\DataGenerator\ConvertFromBase10.py ArrayData.txt

copy *.mem ..\Verilog\Sim
pause
