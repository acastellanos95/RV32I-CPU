----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 17:23:51
-- Design Name: 
-- Module Name: tb_instrmem - Behavioral
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

entity tb_instrmem is
generic(n:integer:=32);
--  Port ( );
end tb_instrmem;

architecture Behavioral of tb_instrmem is

    component instruction_memory
        port (clk             : in std_logic;
              rst             : in std_logic;
              addr            : in std_logic_vector (n-1 downto 0);
              instruction_out : out std_logic_vector (n-1 downto 0));
    end component;

    signal clk             : std_logic;
    signal rst             : std_logic;
    signal addr            : std_logic_vector (n-1 downto 0);
    signal instruction_out : std_logic_vector (n-1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : instruction_memory
    port map (clk             => clk,
              rst             => rst,
              addr            => addr,
              instruction_out => instruction_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;
