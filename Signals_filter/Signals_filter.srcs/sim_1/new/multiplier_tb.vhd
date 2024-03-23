library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity multiplier_tb is
end multiplier_tb;

architecture testbench of multiplier_tb is
    signal X : std_logic_vector(7 downto 0);
    signal Y : std_logic_vector(7 downto 0);
    signal result_out : std_logic_vector(15 downto 0);

    component multiplier
        generic (
            n : integer := 8;
            m : integer := 8
        );
        port (
            X: in std_logic_vector(n - 1 downto 0);
            Y: in std_logic_vector(m - 1 downto 0);
            result: out std_logic_vector(n + m - 1 downto 0)
        );
    end component;

begin
    UUT: multiplier
        generic map (
            n => 8,
            m => 8
        )
        port map (
            X => X,
            Y => Y,
            result => result_out
        );

process
        begin
            X <= "00011001";  -- 25
            Y <= "00000100";  -- 4 
            wait for 10 ns;
        end process;
end testbench;
