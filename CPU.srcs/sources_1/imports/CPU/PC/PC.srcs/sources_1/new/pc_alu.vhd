----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2022 12:17:42 AM
-- Design Name: 
-- Module Name: pc_alu - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc_alu is
    generic(n:integer:=32);
    Port (
        pc_dir, inc: in std_logic_vector(n-1 downto 0);
        res: out std_logic_vector(n-1 downto 0)
    );
end pc_alu;

architecture Behavioral of pc_alu is

begin

    res <= pc_dir + inc;

end Behavioral;
