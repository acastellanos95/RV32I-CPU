----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2022 07:56:26 PM
-- Design Name: 
-- Module Name: instruction_memory - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is
generic(n:integer:=32);
Port (
    clk, rst: in std_logic;
    addr: in std_logic_vector(n-1 downto 0);
    instruction_out: out std_logic_vector(n-1 downto 0)
  );
end instruction_memory;

architecture Behavioral of instruction_memory is

    type mem_type is array(36 downto 0) of std_logic_vector(n-1 downto 0);
    constant ROM: mem_type:= (
        "00000000001100010000000010000000", -- add  x1 x2 x3
        "00000000001000001000001000000001", -- sub x4 x1 x2
        "00000000011100000010001000001100", -- store 7 x4 0
        "00000000001000001000001000000001", -- sub x4 x1 x2
        "00000000001100001000001000000010", -- mult x4 x1 x3
        "00000000001100010000000010000000", -- add  x1 x2 x3
        "00000000000000011001111110001011", -- load x31 3 0
        "00000000000000001001111100001011", -- load x30 1 0
        "00000000000000101001111010001011", -- load x29 5 0
        "00000000000000101001111000001011", -- load x28 5 0
        "00000000000000011001110110001011", -- load x27 3 0
        "00000000000000001001110100001011", -- load x26 1 0
        "00000000000000101001110010001011", -- load x25 5 0
        "00000000000000101001110000001011", -- load x24 5 0
        "00000000000000011001101110001011", -- load x23 3 0
        "00000000000000001001101100001011", -- load x22 1 0
        "00000000000000101001101010001011", -- load x21 5 0
        "00000000000000101001101000001011", -- load x20 5 0
        "00000000000000011001100110001011", -- load x19 3 0
        "00000000000000001001100100001011", -- load x18 1 0
        "00000000000000101001100010001011", -- load x17 5 0
        "00000000000000101001100010001011", -- load x16 5 0
        "00000000000000011001011110001011", -- load x15 3 0
        "00000000000000001001011100001011", -- load x14 1 0
        "00000000000000101001011010001011", -- load x13 5 0
        "00000000000000101001011000001011", -- load x12 5 0
        "00000000000000011001010110001011", -- load x11 3 0
        "00000000000000001001010100001011", -- load x10 1 0
        "00000000000000101001010010001011", -- load x9 5 0
        "00000000000000011001010000001011", -- load x8 3 0
        "00000000000000001001001110001011", -- load x7 1 0
        "00000000000000101001001100001011", -- load x6 5 0
        "00000000000000011001001010001011", -- load x5 3 0
        "00000000000000001001001000001011", -- load x4 1 0
        "00000000000000101001000110001011", -- load x3 5 0
        "00000000000000011001000100001011", -- load x2 3 0
        "00000000000000001001000010001011" -- load x1 1 0
    );

begin

    process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                instruction_out <= (others => '0');
            else
                instruction_out <= ROM(conv_integer(addr));
            end if;
        end if;
    end process;

end Behavioral;
