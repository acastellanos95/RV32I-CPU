----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2022 19:41:33
-- Design Name: 
-- Module Name: immgen - Behavioral
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

entity immgen is
  Port ( instr: in std_logic_vector(31 downto 0);
    ImmOut: out std_logic_vector(20 downto 0)
  );
end immgen;

architecture Behavioral of immgen is

begin

    process(instr)
    begin
        ImmOut <= (others => '0');
        case instr(6 downto 0) is
            when "0001011" => -- load
                ImmOut(16 downto 0) <= instr(31 downto 15);
            when "0001100" =>
                ImmOut(16 downto 0) <= instr(31 downto 15);
            when others =>
                ImmOut(16 downto 0) <= (others => '0');
        end case;
    end process;

end Behavioral;
