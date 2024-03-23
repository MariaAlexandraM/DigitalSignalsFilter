library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity adder is 
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
end adder;

architecture Behavioral of adder is 
-- Signals
    signal result: std_logic_vector(n downto 0) := (others => '0');
begin 
    sum: process(A, B, C)
    begin
        result <= std_logic_vector(resize(signed(A + B + C), result'length));
    end process sum;
    C_out <= result(n);
    S <= result(n - 1 downto 0);
end Behavioral;

