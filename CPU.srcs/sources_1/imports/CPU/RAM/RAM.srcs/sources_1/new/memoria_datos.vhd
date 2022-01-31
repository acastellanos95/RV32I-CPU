----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2022 05:15:12 PM
-- Design Name: 
-- Module Name: memoria_datos - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoria_datos is
generic(n:integer:=32);
  Port (
    clk, en, we, rst: in std_logic;
    addr: in std_logic_vector(n-1 downto 0);
    data_in: in std_logic_vector(n-1 downto 0);
    data_out: out std_logic_vector(n-1 downto 0)
  );
end memoria_datos;

architecture Behavioral of memoria_datos is

    type mem_type is array(7 downto 0) of std_logic_vector(n-1 downto 0);
    signal memD: mem_type:=(
        x"0000000E",
        x"0000000D",
        x"0000000B",
        x"00000009",
        x"00000007",
        x"00000005",
        x"00000003",
        x"00000001"
    );
    
begin
    
    process(clk)
    begin
        if clk'event and clk='1' then
            if en='1' then
                if we='1' then
                    memD(conv_integer(addr)) <= data_in;
                end if;
                if rst='1' then
                    data_out <= (others => '0');
                else
                    data_out <= memD(conv_integer(addr));
                end if;
            end if;
        end if;
    end process;

end Behavioral;
