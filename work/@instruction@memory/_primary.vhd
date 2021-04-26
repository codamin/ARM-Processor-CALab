library verilog;
use verilog.vl_types.all;
entity InstructionMemory is
    port(
        address         : in     vl_logic_vector(31 downto 0);
        instruction     : in     vl_logic_vector(31 downto 0)
    );
end InstructionMemory;
