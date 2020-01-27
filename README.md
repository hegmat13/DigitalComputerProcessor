# DigitalComputerProcessor Project Description
My partner and I created from scratch a fully pipe-lined digital computer datapath for our Fundamentals of Computer Organization Class, which we programmed solely in Verilog and implemented in Xlinx's Vivado Design Suite 2017.2. Our digital datapath optimally runs sets of MIPS Assembly language instructions in Hexadecimal for conducting a full Variable Block Search-Based Motion Estimation (VBSME). We divided up the process into 5 different sections to better keep track of the values on the wires and improve functionality; these sections from left to right were the Instruction Fetch (IF), Instruction Decode (ID), Execution (EX), Memory (ME), and Write Back (WB) stages. Arithmetic calculations were computed through our Arithmetic Logic Unit (ALU) and we utilized Muxes in order to select the necessary value needed for the successful completion of each instruction. The correct value to be selected by each Mux was determined by our Controller component. Optimization of the speed, limiting resource usage, and elimination of dependencies of the processor was accomplished through pipe-lined registers, forwarding, and hazard detection.

# Folder and File Details

ProjectDetailsAndImages: 


This folder contains a word document containing the specific project requirements created by the professor of the class. There are also two files that list all the MIPS ASSEMBLY instructions that the processor is capable of, MipsInstructionClassification and MipsInstructionFormat. We also used a paid version of a diagram maker to create fully detailed visual images of our digital processor which are located in the DigitalProcessorImages folder. 


Files for Labs 1-18:

The bulk of all the verilog files created from earlier labs in the class can be found here. Almost all of the files represent a separate component that's instantiated in the DataPath.v file. Almost all the component files have corresponding names to the labels on our datapath diagram images. All our muxes are controlled by signals sent from the Controller.v file. The beggining of the register file names are the stages they are inbetween, and there are four slotted in the five stages mentioned in the top description. Splitting up the digital processor into pipelines greatly increased its speed since 5 instructions could be executed in the pipeline per clock cycle. 


FinalProject.srcs:

This folder contains the newest files that we created for the optimization of the processors speed and resource usage. The forwarding unit (Forward.v) eliminated dependencies present in closely timed instructions that utilized the same registers. Any dependency cases that the forwarding unit could not resolve, the hazard detection unit (HazardDetection.v) took care of. Finally, the data memory unit (data_memory.v) was used to store all the arithmetic and resulting register values. 


VBSME: 

All the files associated with the completion of the Variable Block Size Motion Estimation (VBSME) are included here. First the problem outlined in vbsme.docx was tackled in C++ in the vbsme.c and vbsme.cpp files. Once an accurate computation of the Sum of Absolute Difference for each location in different sized grids was achieved in C++, the problem was then solved in MIPS assembly language located in the vbsme.s file. 


FinalProject.xpr:

This opens the vivado design suite and adds all the files to the verilog project.


All other folders:

All these other folders were created by verilog in its initial setup and will vary if the source files are used in the creation of a new project. 



