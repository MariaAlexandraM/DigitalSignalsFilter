library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity filter is
    generic (
        n : integer := 8;
        m : integer := 4
    );
    port (
        -- in 
        clk: in std_logic;
        reset: in std_logic;
        data: in std_logic_vector(n - 1 downto 0);
        -- out
        result: out std_logic_vector(n + m - 1 downto 0);
        C_out: out std_logic
    );
end filter;

architecture Behavioral of filter is
-- Components

    component adder is 
        generic (
            n : integer := 8
        );
        port (
            -- in
            A: in std_logic_vector(n - 1 downto 0);
            B: in std_logic_vector(n - 1 downto 0);
            C: in std_logic_vector(n - 1 downto 0);
            -- out
            S: out std_logic_vector(n - 1 downto 0);
            C_out: out std_logic
        );
    end component adder;
    
    component multiplier is
        generic (
            n : integer := 8;
            m : integer := 8
        );
        port (
        -- in 
        X: in std_logic_vector(n - 1 downto 0);
        Y: in std_logic_vector(m - 1 downto 0);
        -- out
        result: out std_logic_vector(n + m - 1 downto 0)
        );
    end component multiplier;

-- Constants
    -- se pot modifica in functie de preferinta
    constant a1: std_logic_vector(3 downto 0) := "0010"; -- 2
    constant a2: std_logic_vector(3 downto 0) := "0011"; -- 3
    constant a3: std_logic_vector(3 downto 0) := "0100"; -- 4

-- Signals
    -- X(k), X(k - 1), X(k - 2)
    signal reg1 : std_logic_vector (n - 1 downto 0) := (others => '0');          
    signal reg2 : std_logic_vector (n - 1 downto 0) := (others => '0');          
    signal reg3 : std_logic_vector (n - 1 downto 0) := (others => '0');          
                                                                               
    signal mul_1 : std_logic_vector (n + a1'length - 1 downto 0);               
    signal mul_2 : std_logic_vector (n + a1'length - 1 downto 0);               
    signal mul_3 : std_logic_vector (n + a1'length - 1 downto 0);               
   
begin 
    process (clk, reset)
    begin
        if reset = '1' then
			reg1 <= (others => '0');
			reg2 <= (others => '0');
			reg3 <= (others => '0');
		elsif (rising_edge(clk)) then 
		    reg1 <= data;
		    reg2 <= reg1;
		    reg3 <= reg2; 
		end if;
    end process;
    
    -- X(k) * a1
    prod_1: multiplier generic map (n => n, m => a1'length) 
                                 port map (X => reg1, Y => a1, result => mul_1);
    
    -- X(k - 1) * a2                             
    prod_2: multiplier generic map (n => n, m => a2'length) 
                                 port map (X => reg2, Y => a2, result => mul_2);
   
    -- X(k - 2) * a3
    prod_3: multiplier generic map (n => n, m => a3'length) 
                                port map (X => reg3, Y => a3, result => mul_3);
                                     
    -- X(k) + X(k - 1) * a2 + X(k - 2) * a3
    add: adder generic map (n => n + m) -- m = pe cati biti ii constanta
                     port map (A => mul_1, B => mul_2, C => mul_3, S => result, C_out => C_out);

end Behavioral;