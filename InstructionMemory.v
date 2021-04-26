`timescale 1ns/1ns
module InstructionMemory(address, instruction);
  input[31:0] address;
  input[31:0] instruction;
  reg[7:0] storage[0:1023];
  
  assign instruction = {storage[address+3], storage[address+2], storage[address+1], storage[address]};
  
  integer fd, i=0;
  reg[31:0] line;
  initial begin
    fd = $fopen("instructions.txt", "r");
    while(!$feof(fd)) begin
      $fscanf(fd, "%b\n", line);
      {storage[i+3], storage[i+2], storage[i+1], storage[i]} = line;
      i = i+4;
    end
    $fclose(fd);
  end
endmodule