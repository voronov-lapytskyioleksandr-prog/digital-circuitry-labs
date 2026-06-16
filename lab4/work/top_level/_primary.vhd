library verilog;
use verilog.vl_types.all;
entity top_level is
    port(
        x1              : in     vl_logic;
        x2              : in     vl_logic;
        x3              : in     vl_logic;
        f_assign        : out    vl_logic;
        f_struct        : out    vl_logic
    );
end top_level;
