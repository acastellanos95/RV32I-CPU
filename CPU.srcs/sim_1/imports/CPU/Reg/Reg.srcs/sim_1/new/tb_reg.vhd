----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2022 10:45:20 PM
-- Design Name: 
-- Module Name: tb_reg - Behavioral
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

entity tb_reg is
generic(n:integer:=32);
--  Port ( );
end tb_reg;

architecture Behavioral of tb_reg is
    component reg
        port (reg_in  : in std_logic_vector (n-1 downto 0);
              reg_out : out std_logic_vector (n-1 downto 0);
              clk     : in std_logic;
              rst     : in std_logic;
              we      : in std_logic);
    end component;

    signal reg_in  : std_logic_vector (n-1 downto 0);
    signal reg_out : std_logic_vector (n-1 downto 0);
    signal clk     : std_logic;
    signal rst     : std_logic;
    signal we      : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
begin

    dut : reg
    port map (reg_in  => reg_in,
              reg_out => reg_out,
              clk     => clk,
              rst     => rst,
              we      => we);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        reg_in <= (others => '0');
        we <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for TbPeriod;
        rst <= '0';
        wait for TbPeriod;

        -- EDIT Add stimuli here
        wait for TbPeriod;
        reg_in <= x"00800450";
        we <= '1';
        wait for TbPeriod;
        reg_in <= x"00800452";
        we <= '0';
        wait for TbPeriod;
        reg_in <= x"00800650";
        we <= '1';
        wait for TbPeriod;
        

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;
