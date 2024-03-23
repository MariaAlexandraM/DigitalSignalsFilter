library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ssd is 
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
end entity;

architecture Behavioral of ssd is 
-- Signals
    signal cnt: std_logic_vector(15 downto 0) := (others => '0');
    signal digit: std_logic_vector(3 downto 0) := (others => '0');
    signal sel: std_logic_vector(1 downto 0) := (others => '0');
begin 
    
    counter: process(clk)
    begin
        if rising_edge(clk) then 
            cnt <= cnt + 1;
        end if;
    end process counter;
    
    sel <= cnt(15 downto 14);
        
    process(sel, digit_0, digit_1, digit_2, digit_3)
    begin 
        case sel is 
            when "00" => digit <= digit_0;
            when "01" => digit <= digit_1;
            when "10" => digit <= digit_2;
            when "11" => digit <= digit_3;
            when others => digit <= "0000";
        end case;
    end process;
    
    process (cnt)
    begin
        case cnt is
            when "00" => an <= "1110";
            when "01" => an <= "1101";
            when "10" => an <= "1011";
            when "11"=> an <= "0111";
            when others => an <= "1111";
        end case;
    end process;  
        
    with digit select 
    cat <= "1111001" when "0001", -- 1
           "0100100" when "0010", -- 2
           "0110000" when "0011", -- 3
           "0011001" when "0100", -- 4
           "0010010" when "0101", -- 5
           "0000010" when "0110", -- 6
           "1111000" when "0111", -- 7
           "0000000" when "1000", -- 8
           "0010000" when "1001", -- 9
           "0001000" when "1010", -- A
           "0000011" when "1011", -- b
           "1000110" when "1100", -- C
           "0100001" when "1101", -- d
           "0000110" when "1110", -- E
           "0001110" when "1111", -- F
           "1000000" when others; -- 0 
    
end Behavioral;