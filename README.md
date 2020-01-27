# DigitalComputerProcessor Project Description
My partner and I created from scratch a fully pipe-lined digital computer datapath for our Fundamentals of Computer Organization Class, which we programmed solely in verilog and implemented in Xlinx's Vivado Design Suite 2017.2. Our digital datapath optimally runs sets of MIPS Assembly instructions in hex for conducting a full search based motion estimation with a variable block size. We divided up the process into 5 different sections to better keep track of the values on the wires and improve functionality; these sections from left to right were the Instruction Fetch (IF), Instruction Decode (ID), Execution (EX), Memory (ME), and Write Back (WB) stages. Arithmetic calculations were achieved through our Arithmetic Logic Unit (ALU) and we utilized muxes in order to select the necessary value needed for the successful completion of each instruction. The correct value to be selected by each mux was determined by our Controller component. Optimization of the speed and resource usage of the processor was accomplished through pipe-lined registers, forwarding, and hazard detection.

# File Details in each Folder 

ProjectDetailsAndImages: 

This folder contains a word document containing the specific project requirements created by the professor of the class. There are also two files that list all of the MIPS ASSEMBLY instructions that the processor is capable of, MipsInstructionClassification and MipsInstructionFormat. We also used a paid version of a diagram maker to create fully detailed visual images of our digital processor which are located in the DigitalProcessorImages folder. 

Files for Labs 1-18:

The bulk of all the verilog files created from earlier labs in the class can be found here. Almost all of the files represent a separate component that's instantiated in the DataPath.v file. Almost all of the component files have corresponding names to the labels on our datapath diagram images. All of our Muxes are controlled by signals sent from the Controller.v file. The beggining of the register file names are the stages they are inbetween, and there are four slotted in the five stages mentioned in the top description. 



