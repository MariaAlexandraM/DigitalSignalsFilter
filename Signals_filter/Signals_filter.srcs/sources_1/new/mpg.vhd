library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity mpg is 
    port (
        -- in 
        clk: in std_logic;
        btn: in std_logic_vector(4 downto 0);
        -- out 
        en: out std_logic_vector(4 downto 0)
    );
end entity;


architecture Behavioral of mpg is
-- Signals
    signal q1 : std_logic_vector(4 downto 0) := (others => '0');
    signal q2 : std_logic_vector(4 downto 0) := (others => '0');
    signal cnt : std_logic_vector(15 downto 0) := (others => '0');

begin

    counter: process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process counter;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if cnt = x"FFFF" then
                q1 <= btn;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            q2 <= q1;
        end if;
    end process;
    
    en <= q1 and not q2;

end Behavioral;
    