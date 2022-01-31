----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2022 06:52:24 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
    generic(n: integer:= 32);
    Port ( reg_in : in std_logic_vector(n-1 downto 0);
         reg_out : out std_logic_vector(n-1 downto 0);
         clk, rst, we : in std_logic
        );
end reg;

architecture Behavioral of reg is

begin

    reg: process(we, clk, rst)
    begin

        if rst='1' then
            reg_out <= (others => '0');
        elsif rising_edge(clk) and we='1' then
            reg_out <= reg_in;
--        else
--            reg_out <= reg_out;
        end if;

    end process;

end Behavioral;
