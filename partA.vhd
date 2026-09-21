library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- FULL ADDER for one bit 
entity my_FA is
    Port ( a, b, cin : in STD_LOGIC;
           sum, cout : out STD_LOGIC);
end my_FA;

architecture Behavioral of my_FA is
begin
    sum <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end Behavioral;

--Generic entity
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- I called the libraries again as I already ended the architecture and started new entity

entity partA is
    Generic ( n : integer := 16 );
    Port ( A    : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B    : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Cin  : in  STD_LOGIC;
           S0   : in  STD_LOGIC;
           S1   : in  STD_LOGIC;
           F    : out STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out STD_LOGIC);
end partA;

architecture Structural of partA is
    
 -- just declaration for what I have written at top
    component my_FA
        Port ( a, b, cin : in STD_LOGIC;
               sum, cout : out STD_LOGIC);
    end component;

   -- intermediate signals
    signal Y         : STD_LOGIC_VECTOR (n-1 downto 0);
    signal temp_C    : STD_LOGIC_VECTOR (n downto 0); 
    signal sel       : STD_LOGIC_VECTOR (1 downto 0);
    signal adder_sum : STD_LOGIC_VECTOR (n-1 downto 0);

begin
    sel <= S1 & S0; --concatenate the selectors

   -- I have to determine y bcz the circuit always evaluate A+Y+cin without logic
    with sel select
        Y <= (others => '0') when "00", 
             B               when "01", -- A+B
             not B           when "10", --A-B
             (others => '1') when others; --A-1

  
    temp_C(0) <= Cin;
    -- FOCUS: I repeat the one bit adder "my_FA" n times and put the cout as cin of the next adder to handle carries bit by bit
	 
	 -- it's called "Ripple Carry Adder"
    GEN_ADDER: for i in 0 to n-1 generate
        FA_i: my_FA port map (
            a    => A(i),
            b    => Y(i),
            cin  => temp_C(i),
            sum  => adder_sum(i),
            cout => temp_C(i+1) 
        );
    end generate;


    process(sel, Cin, adder_sum, temp_C)
    begin
        if (sel = "11" and Cin = '1') then
        
            F <= (others => '0');
            Cout <= '0'; -- this documented in the lab file directly 
        else
            F <= adder_sum;
            Cout <= temp_C(n); -- last carry out
        end if;
    end process;

end Structural;
