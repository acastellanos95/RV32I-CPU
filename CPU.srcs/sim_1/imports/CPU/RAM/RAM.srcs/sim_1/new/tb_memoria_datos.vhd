----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 16:28:19
-- Design Name: 
-- Module Name: tb_memoria_datos - Behavioral
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_memoria_datos is
generic(n:integer:=32);
--  Port ( );
end tb_memoria_datos;

architecture Behavioral of tb_memoria_datos is

    component memoria_datos
        port (clk      : in std_logic;
              en       : in std_logic;
              we       : in std_logic;
              rst      : in std_logic;
              addr     : in std_logic_vector (n-1 downto 0);
              data_in  : in std_logic_vector (n-1 downto 0);
              data_out : out std_logic_vector (n-1 downto 0));
    end component;

    signal clk      : std_logic;
    signal en       : std_logic;
    signal we       : std_logic;
    signal rst      : std_logic;
    signal addr     : std_logic_vector (n-1 downto 0);
    signal data_in  : std_logic_vector (n-1 downto 0);
    signal data_out : std_logic_vector (n-1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
begin

    dut : memoria_datos
    port map (clk      => clk,
              en       => en,
              we       => we,
              rst      => rst,
              addr     => addr,
              data_in  => data_in,
              data_out => data_out);

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
        wait for TbPeriod;
        rst <= '0';
        wait for TbPeriod;

        -- EDIT Add stimuli here
        for I in 0 to 7 loop
            addr <= conv_std_logic_vector(I, addr'length);
            en <= '0';
            we <= '0';
            data_in <= conv_std_logic_vector(I+1, addr'length);
            wait for TbPeriod;
            en <= '1';
            we <= '1';
            data_in <= conv_std_logic_vector(I+2, addr'length);
            wait for TbPeriod;
            en <= '1';
            we <= '0';
            data_in <= conv_std_logic_vector(I+3, addr'length);
            wait for TbPeriod;
        end loop;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;
