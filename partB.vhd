library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity partB is
    Generic ( n : integer := 16 );
    Port ( A  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           S0 : in  STD_LOGIC;
           S1 : in  STD_LOGIC;
           F  : out STD_LOGIC_VECTOR (n-1 downto 0));
end partB;

architecture Behavioral of partB is
    signal sel : STD_LOGIC_VECTOR(1 downto 0);
begin
    sel <= S1 & S0;
    
    with sel select
        F <= (A and B) when "00",
             (A or B)  when "01",
             (A xor B) when "10",
             (not A)   when others;
end Behavioral;
