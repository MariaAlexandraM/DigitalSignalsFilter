----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2024 09:30:11 AM
-- Design Name: 
-- Module Name: project_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_tb is
--  Port ( );
end project_tb;

architecture Behavioral of project_tb is
component filter is
    generic (
        n : integer := 8;
        m : integer := 4
    );
    port (
        -- in 
        clk: in std_logic;
        rst: in std_logic;
        data: in std_logic_vector(n - 1 downto 0);
        -- out
        result: out std_logic_vector(n + m - 1 downto 0);
        C_out: out std_logic
    );
end component filter;

constant n : integer := 8;
signal data : STD_LOGIC_VECTOR (7 downto 0);
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal result : STD_LOGIC_VECTOR (11 downto 0);
signal C_out : STD_LOGIC;


begin
FILTER_UNIT : filter generic map (8, 4) port map (clk, reset, data, result, C_out);
    
process 
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
	process
	begin
		reset <= '0';
		data <= x"02";
		wait for 20 ns;
		reset <= '0';
		data <= x"05";
		wait for 20 ns;
		reset <= '0';
		data <= x"03";
		wait for 20 ns;
		reset <= '0';
		data <= x"09";
		wait for 20 ns;
		reset <= '0';
		data <= x"01";
		wait for 20 ns;
		reset <= '0';
		data <= x"11";
		wait for 20 ns;
		reset <= '0';
		data <= x"14";
		wait for 20 ns;
		reset <= '0';
		data <= x"06";
		wait for 20 ns;
		reset <= '0';
		data <= x"00";
		wait for 20 ns;
		reset <= '0';
		data <= x"20";
		wait for 20 ns;
		wait;
	end process;

end Behavioral;
