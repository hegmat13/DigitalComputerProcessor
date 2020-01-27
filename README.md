# DigitalComputerProcessor
My partner and I created from scratch a fully pipe-lined digital computer datapath for our Fundamentals of Computer Organization Class, which we programmed solely in verilog and implemented in Xlinx's Vivado Design Suite 2017.2. Our digital datapath optimally runs sets of MIPS Assembly instructions in hex for conducting a full search based motion estimation with a variable block size. We divided up the process into 5 different sections to better keep track of the values on the wires and improve functionality; these sections from left to right were the Instruction Fetch (IF), Instruction Decode (ID), Execution (EX), Memory (ME), and Write Back (WB) stages. Arithmetic calculations were achieved through our Arithmetic Logic Unit (ALU) and we utilized muxes in order to select the necessary value needed for the successful completion of each instruction. The correct value to be selected by each mux was determined by our Controller component. Optimization of the speed and resource usage of the processor was accomplished through pipe-lined registers, forwarding, and hazard detection.