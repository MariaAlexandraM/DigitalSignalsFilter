library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity display is 
    port (
        -- in 
        clk: in std_logic;
        btn: in std_logic_vector(4 downto 0);
        sw: in std_logic_vector(15 downto 0);
        -- out
        led: out std_logic_vector(15 downto 0);
        an: out std_logic_vector(3 downto 0);
        cat: out std_logic_vector(6 downto 0)
    );
end display;

architecture Behavioral of display is
-- Components

    component filter is
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
    end component filter;
    
    component mpg is 
        port (
            -- in 
            clk: in std_logic;
            btn: in std_logic_vector(4 downto 0);
            -- out 
            en: out std_logic_vector(4 downto 0)
        );
    end component mpg;
    
    component ssd is 
        port (
            -- in 
            clk: in std_logic;
            digit_0: in std_logic_vector(3 downto 0);
            digit_1: in std_logic_vector(3 downto 0);
            digit_2: in std_logic_vector(3 downto 0);
            digit_3: in std_logic_vector(3 downto 0);
            -- out 
            an: out std_logic_vector(3 downto 0);
            cat: out std_logic_vector(6 downto 0)
        );
    end component ssd;
    
    
-- Signals
    signal step : std_logic_vector(4 downto 0);
    signal digits: std_logic_vector(15 downto 0);
    signal en: std_logic_vector(4 downto 0); -- pt mpg
    signal data: std_logic_vector(7 downto 0); -- X(k) introdus
    signal reset, clk_btn: std_logic; -- reset = btn(1), clk = btn(0)
    signal result: std_logic_vector(11 downto 0);
    signal C_out: std_logic;

begin

    mpg_portmap: mpg port map(clk => clk, btn => btn, en => en);
    ssd_portmap: ssd port map(clk => clk,
                              digit_0 => digits(3 downto 0),
                              digit_1 => digits(7 downto 4),
                              digit_2 => digits(11 downto 8),
                              digit_3 => digits(15 downto 12),
                              an => an,
                              cat => cat);
    filter_portmap: filter generic map(8, 4) 
                           port map(clk => clk_btn,
                                    reset => reset,
                                    data => data,
                                    result => result,
                                    C_out => C_out);
    data <= sw(7 downto 0); -- input din switchuri
    
    clk_btn <= en(1);
    reset <= en(0);
    
    digits(11 downto 0) <= result;
    led(0) <= C_out;
    

end Behavioral;
