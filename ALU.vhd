library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A    : in  STD_LOGIC_VECTOR (15 downto 0);
           B    : in  STD_LOGIC_VECTOR (15 downto 0);
           Cin  : in  STD_LOGIC;
           S    : in  STD_LOGIC_VECTOR (3 downto 0);
           F    : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end ALU;

architecture Structural of ALU is

    -- 1. Component Declarations for Lab 1 Parts
    component partB
        Port ( A, B : in STD_LOGIC_VECTOR (15 downto 0);
               S0, S1 : in STD_LOGIC;
               F : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component partC
        Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
               Cin, S0, S1 : in STD_LOGIC;
               F : out STD_LOGIC_VECTOR (15 downto 0);
               Cout : out STD_LOGIC);
    end component;

    component partD
        Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
               Cin, S0, S1 : in STD_LOGIC;
               F : out STD_LOGIC_VECTOR (15 downto 0);
               Cout : out STD_LOGIC);
    end component;

    -- 2. Internal Signals
    signal F_B, F_C, F_D : STD_LOGIC_VECTOR(15 downto 0);
    signal Cout_C, Cout_D : STD_LOGIC;
    signal sel_top : STD_LOGIC_VECTOR(1 downto 0);

begin
    sel_top <= S(3) & S(2); -- Highest 2 bits select the Part

    -- 3. Port Mapping
    U1: partB port map (A => A, B => B, S0 => S(0), S1 => S(1), F => F_B);
    U2: partC port map (A => A, Cin => Cin, S0 => S(0), S1 => S(1), F => F_C, Cout => Cout_C);
    U3: partD port map (A => A, Cin => Cin, S0 => S(0), S1 => S(1), F => F_D, Cout => Cout_D);

    -- 4. Top Level Multiplexer
    process(sel_top, F_B, F_C, F_D, Cout_C, Cout_D)
    begin
        case sel_top is
            when "01" => -- Part B selected
                F <= F_B;
                Cout <= '0'; -- Part B does not affect carry
            when "10" => -- Part C selected
                F <= F_C;
                Cout <= Cout_C;
            when "11" => -- Part D selected
                F <= F_D;
                Cout <= Cout_D;
            when others => -- "00" Part A (Next Time in Lab 1)
                F <= (others => '0');
                Cout <= '0';
        end case;
    end process;

end Structural;
