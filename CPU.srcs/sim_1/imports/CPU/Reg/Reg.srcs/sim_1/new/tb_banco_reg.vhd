----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2022 08:17:13 PM
-- Design Name: 
-- Module Name: tb_banco_reg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_banco_reg is
    generic(n:integer:=32; nreg:integer:=32);
--  Port ( );
end tb_banco_reg;

architecture Behavioral of tb_banco_reg is
    component banco_reg

        port (read_reg1 : in std_logic_vector (4 downto 0);
              read_reg2 : in std_logic_vector (4 downto 0);
              regwrt    : in std_logic_vector (4 downto 0);
              dato      : in std_logic_vector (n-1 downto 0);
              clk       : in std_logic;
              rst       : in std_logic;
              ctrl_wr   : in std_logic;
              rd_data1  : out std_logic_vector (n-1 downto 0);
              rd_data2  : out std_logic_vector (n-1 downto 0));
    end component;

    signal read_reg1 : std_logic_vector (4 downto 0);
    signal read_reg2 : std_logic_vector (4 downto 0);
    signal regwrt    : std_logic_vector (4 downto 0);
    signal dato      : std_logic_vector (n-1 downto 0);
    signal clk       : std_logic;
    signal rst       : std_logic;
    signal ctrl_wr   : std_logic;
    signal rd_data1  : std_logic_vector (n-1 downto 0);
    signal rd_data2  : std_logic_vector (n-1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : banco_reg
    port map (read_reg1 => read_reg1,
              read_reg2 => read_reg2,
              regwrt    => regwrt,
              dato      => dato,
              clk       => clk,
              rst       => rst,
              ctrl_wr   => ctrl_wr,
              rd_data1  => rd_data1,
              rd_data2  => rd_data2);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
--        read_reg1 <= (others => '0');
--        read_reg2 <= (others => '0');
--        regwrt <= (others => '0');
        dato <= x"00800450";
        ctrl_wr <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for TbPeriod;
        rst <= '0';
        ctrl_wr <= '0';
        wait for TbPeriod;
        -- for loop to insert to registers
        read_reg1 <= (others => '0');
        read_reg2 <= (others => '0');
        regwrt <= (others => '0');
        -- EDIT Add stimuli here
        ctrl_wr <= '1';
        regwrt <= "00000";
        wait for TbPeriod;
        ctrl_wr <= '0';
        dato <= dato + 1;
        wait for TbPeriod;
        ctrl_wr <= '1';
        regwrt <= "00001";
        wait for TbPeriod;
        ctrl_wr <= '0';
        dato <= dato + 1;
        wait for TbPeriod;
        read_reg1 <= "00001";
        wait for TbPeriod;
        read_reg2 <= "00001";
        wait for TbPeriod;
        read_reg1 <= "00000";
        wait for TbPeriod;
        read_reg2 <= "00000";
        wait for TbPeriod;
        

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
--        wait;
    end process;

end Behavioral;
