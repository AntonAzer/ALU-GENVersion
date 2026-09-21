library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Generic ( n : integer := 16 );
    Port ( A    : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B    : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Cin  : in  STD_LOGIC;
           S    : in  STD_LOGIC_VECTOR (3 downto 0);
           F    : out STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out STD_LOGIC);
end ALU;

architecture Structural of ALU is

    -- Component Declarations with Generics
    component PartA
        Generic ( n : integer := 16 );
        Port ( A    : in  STD_LOGIC_VECTOR (n-1 downto 0);
               B    : in  STD_LOGIC_VECTOR (n-1 downto 0);
               Cin  : in  STD_LOGIC;
               S0   : in  STD_LOGIC;
               S1   : in  STD_LOGIC;
               F    : out STD_LOGIC_VECTOR (n-1 downto 0);
               Cout : out STD_LOGIC);
    end component;

    component partB
        Generic ( n : integer := 16 );
        Port ( A, B : in STD_LOGIC_VECTOR (n-1 downto 0);
               S0, S1 : in STD_LOGIC;
               F : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component;

    component partC
        Generic ( n : integer := 16 );
        Port ( A : in STD_LOGIC_VECTOR (n-1 downto 0);
               Cin, S0, S1 : in STD_LOGIC;
               F : out STD_LOGIC_VECTOR (n-1 downto 0);
               Cout : out STD_LOGIC);
    end component;

    component partD
        Generic ( n : integer := 16 );
        Port ( A : in STD_LOGIC_VECTOR (n-1 downto 0);
               Cin, S0, S1 : in STD_LOGIC;
               F : out STD_LOGIC_VECTOR (n-1 downto 0);
               Cout : out STD_LOGIC);
    end component;

    -- Internal Signals
    signal F_A, F_B, F_C, F_D : STD_LOGIC_VECTOR(n-1 downto 0);
    signal Cout_A, Cout_C, Cout_D : STD_LOGIC;
    signal sel_top : STD_LOGIC_VECTOR(1 downto 0);

begin
    sel_top <= S(3) & S(2);

    -- Port Mapping using generic map
    U0: PartA generic map (n => n) port map (A => A, B => B, Cin => Cin, S0 => S(0), S1 => S(1), F => F_A, Cout => Cout_A);
    U1: partB generic map (n => n) port map (A => A, B => B, S0 => S(0), S1 => S(1), F => F_B);
    U2: partC generic map (n => n) port map (A => A, Cin => Cin, S0 => S(0), S1 => S(1), F => F_C, Cout => Cout_C);
    U3: partD generic map (n => n) port map (A => A, Cin => Cin, S0 => S(0), S1 => S(1), F => F_D, Cout => Cout_D);

    -- Top-Level Multiplexer
    process(sel_top, F_A, F_B, F_C, F_D, Cout_A, Cout_C, Cout_D)
    begin
        case sel_top is
            when "00" => -- Part A selected
                F <= F_A;
                Cout <= Cout_A;
            when "01" => -- Part B selected
                F <= F_B;
                Cout <= '0';
            when "10" => -- Part C selected
                F <= F_C;
                Cout <= Cout_C;
            when "11" => -- Part D selected
                F <= F_D;
                Cout <= Cout_D;
            when others =>
                F <= (others => '0');
                Cout <= '0';
        end case;
    end process;

end Structural;
