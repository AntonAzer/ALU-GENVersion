library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity partD is
    Generic ( n : integer := 16 );
    Port ( A    : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Cin  : in  STD_LOGIC;
           S0   : in  STD_LOGIC;
           S1   : in  STD_LOGIC;
           F    : out STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out STD_LOGIC);
end partD;

architecture Behavioral of partD is
    signal sel : STD_LOGIC_VECTOR(1 downto 0);
begin
    sel <= S1 & S0;

    -- Carry Out Selection
    with sel select
        Cout <= '0'    when "11",
                A(n-1) when others;

    -- Output F Selection
    with sel select
        F <= A(n-2 downto 0) & '0'    when "00", -- Logic Shift Left
             A(n-2 downto 0) & A(n-1) when "01", -- Rotate Left
             A(n-2 downto 0) & Cin    when "10", -- Rotate Left with Carry
             (others => '0')          when others; -- F = 0000 (11)
end Behavioral;
