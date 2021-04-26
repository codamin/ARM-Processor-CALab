library verilog;
use verilog.vl_types.all;
entity MUX2t01 is
    generic(
        Length          : integer := 32
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Length : constant is 1;
end MUX2t01;
