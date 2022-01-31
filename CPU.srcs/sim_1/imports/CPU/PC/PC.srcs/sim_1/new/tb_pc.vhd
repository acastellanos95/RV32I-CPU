----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2022 07:32:09 PM
-- Design Name: 
-- Module Name: tb_pc - Behavioral
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

entity tb_pc is
generic(n:integer:=32; j_size:integer:=16);
--  Port ( );
end tb_pc;

architecture Behavioral of tb_pc is
    component pc
        port (dir     : in std_logic_vector (n-1 downto 0);
              ctrl_pc : in std_logic_vector (1 downto 0);
              clk     : in std_logic;
              rst     : in std_logic;
              j       : in std_logic_vector (j_size-1 downto 0);
              pc_dir  : out std_logic_vector (n-1 downto 0));
    end component;

    signal dir     : std_logic_vector (n-1 downto 0);
    signal ctrl_pc : std_logic_vector (1 downto 0);
    signal clk     : std_logic;
    signal rst     : std_logic;
    signal j       : std_logic_vector (j_size-1 downto 0);
    signal pc_dir  : std_logic_vector (n-1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : pc
    port map (dir     => dir,
              ctrl_pc => ctrl_pc,
              clk     => clk,
              rst     => rst,
              j       => j,
              pc_dir  => pc_dir);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        dir <= x"00000010";
        ctrl_pc <= "01";
        j <= x"0006";

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for TbPeriod;
        rst <= '0';
        -- EDIT Add stimuli here
        ctrl_pc <= "00";
        j <= x"0006";
        wait for TbPeriod;
        ctrl_pc <= "01";
        j <= x"0003";
        wait for TbPeriod;
        ctrl_pc <= "10";
        j <= x"0008";
        wait for TbPeriod;
        ctrl_pc <= "11";
        j <= x"000A";
        wait for TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;
