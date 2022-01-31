----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 16:51:20
-- Design Name: 
-- Module Name: tb_immgen - Behavioral
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

entity tb_immgen is
--  Port ( );
end tb_immgen;

architecture Behavioral of tb_immgen is

    component immgen
        port (instr  : in std_logic_vector (31 downto 0);
              ImmOut : out std_logic_vector (20 downto 0));
    end component;

    signal instr  : std_logic_vector (31 downto 0);
    signal ImmOut : std_logic_vector (20 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : immgen
    port map (instr  => instr,
              ImmOut => ImmOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        instr <= (others => '0');
        wait for Tbperiod;
        instr <= "00000000000000001001000010001011";
        wait for Tbperiod;
        instr <= "00000000000000011001000100001011";
        wait for Tbperiod;
        instr <= "00000000000000101001000110001011";
        wait for Tbperiod;
        instr <= "00000000001100010000000010000000";
        wait for Tbperiod;
        instr <= "00000000001100001000001000000010";
        wait for Tbperiod;
        instr <= "00000000001000001000001000000001";
        wait for Tbperiod;
        instr <= "00000000011100000010001000001100";
        wait for Tbperiod;
    end process;

end Behavioral;
