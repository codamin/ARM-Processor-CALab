library verilog;
use verilog.vl_types.all;
entity DataMemory is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        readSig         : in     vl_logic;
        writeSig        : in     vl_logic;
        address         : in     vl_logic_vector(17 downto 0);
        dataIn          : in     vl_logic_vector(31 downto 0);
        dataOut         : out    vl_logic_vector(31 downto 0)
    );
end DataMemory;
