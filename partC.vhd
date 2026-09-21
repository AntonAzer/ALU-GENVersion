library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity partC is
    Generic ( n : integer := 16 );
    Port ( A    : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Cin  : in  STD_LOGIC;
           S0   : in  STD_LOGIC;
           S1   : in  STD_LOGIC;
           F    : out STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out STD_LOGIC);
end partC;

architecture Behavioral of partC is
    signal sel : STD_LOGIC_VECTOR(1 downto 0);
begin
    sel <= S1 & S0;
    
    -- In right shifts, the LSB goes to Carry out
    Cout <= A(0);

    with sel select
        F <= '0'    & A(n-1 downto 1) when "00", -- Logic Shift Right
             A(0)   & A(n-1 downto 1) when "01", -- Rotate Right
             Cin    & A(n-1 downto 1) when "10", -- Rotate Right with Carry
             A(n-1) & A(n-1 downto 1) when others; -- Arithmetic Shift Right (11)
end Behavioral;
