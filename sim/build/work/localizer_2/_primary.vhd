library verilog;
use verilog.vl_types.all;
entity localizer_2 is
    port(
        tau1            : in     vl_logic_vector(34 downto 0);
        tau2            : in     vl_logic_vector(34 downto 0);
        tau3            : in     vl_logic_vector(34 downto 0);
        posx            : out    vl_logic_vector(90 downto 0);
        posy            : out    vl_logic_vector(90 downto 0)
    );
end localizer_2;
