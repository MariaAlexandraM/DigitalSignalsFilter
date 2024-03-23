library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity multiplier is
    generic (
        n : integer := 8;
        m : integer := 4 -- dimensiunea la constanta cu care inmultesc in filter
    );
    port (
    -- in 
    X: in std_logic_vector(n - 1 downto 0);
    Y: in std_logic_vector(m - 1 downto 0);
    -- out
    result: out std_logic_vector(n + m - 1 downto 0)
    );
end multiplier;

architecture Behavioral of multiplier is 
begin 
    process(X, Y)
        variable A: std_logic_vector(n + m - 1 downto 0); -- accumulator
        variable B: std_logic_vector(n + m - 1 downto 0); -- multiplicand  
        variable Q: std_logic_vector(m - 1 downto 0);     -- multiplier    
        variable i: integer;
    begin 
        A := (others => '0');
        B := std_logic_vector(resize(signed(X), B'length));
        Q := std_logic_vector(resize(signed(Y), Q'length));
        i := m;
        
        while (i /= 0) loop -- p != 0
            if Q(0) = '1' then 
                A := A + B;
            end if;
            B := B((B'length - 2) downto 0) & '0'; -- shift right
            Q := '0' & Q(m - 1 downto 1); -- shift right
            i := i - 1;
        end loop;
        
        result <= A;
    end process; 
    
end Behavioral;
