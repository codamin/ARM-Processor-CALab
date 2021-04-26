library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        freeze          : in     vl_logic;
        \in\            : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end PC;
