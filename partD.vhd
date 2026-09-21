library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity partD is
    Port ( A    : in  STD_LOGIC_VECTOR (15 downto 0);
           Cin  : in  STD_LOGIC;
           S0   : in  STD_LOGIC;
           S1   : in  STD_LOGIC;
           F    : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end partD;

architecture Behavioral of partD is
    signal sel : STD_LOGIC_VECTOR(1 downto 0);
begin
    sel <= S1 & S0;

    -- Multiplexer for Carry Out
    with sel select
        Cout <= A(15) when "00",
                A(15) when "01",
                A(15) when "10",
                '0'   when others; -- For F=0000 case (11)
    -- MUX part can be written as

    --with sel select
    --Cout <= '0'   when "11",
           -- A(15) when others;

    -- Multiplexer for Output F
    with sel select
        F <= A(14 downto 0) & '0'   when "00", -- Logic Shift Left
             A(14 downto 0) & A(15) when "01", -- Rotate Left
             A(14 downto 0) & Cin   when "10", -- Rotate Left with Carry
             (others => '0')        when others; -- F = 0000 (11)
end Behavioral;
