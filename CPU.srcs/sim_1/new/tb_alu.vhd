----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2022 10:31:32
-- Design Name: 
-- Module Name: tb_alu - Behavioral
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

entity tb_alu is
generic(
data_path_size : integer:= 32
);
--  Port ( );
end tb_alu;

architecture Behavioral of tb_alu is

    component ALU
        generic(
    data_path_size : integer:= 32
    );
        port (op1      : in std_logic_vector (data_path_size-1 downto 0);
              op2      : in std_logic_vector (data_path_size-1 downto 0);
              sal_alu  : out std_logic_vector (data_path_size-1 downto 0);
              H        : out std_logic_vector (data_path_size-1 downto 0);
              ctrl_alu : in std_logic_vector (3 downto 0);
              clk      : in std_logic;
              rst      : in std_logic);
    end component;

    signal op1      : std_logic_vector (data_path_size-1 downto 0);
    signal op2      : std_logic_vector (data_path_size-1 downto 0);
    signal sal_alu  : std_logic_vector (data_path_size-1 downto 0);
    signal H        : std_logic_vector (data_path_size-1 downto 0);
    signal ctrl_alu : std_logic_vector (3 downto 0);
    signal clk      : std_logic;
    signal rst      : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ALU
    port map (op1      => op1,
              op2      => op2,
              sal_alu  => sal_alu,
              H        => H,
              ctrl_alu => ctrl_alu,
              clk      => clk,
              rst      => rst);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
--        op1 <= (others => '0');
--        op2 <= (others => '0');
--        ctrl_alu <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for TbPeriod;
        rst <= '0';
        wait for TbPeriod;

        -- EDIT Add stimuli here
        op1 <= x"04200241";
        op2 <= x"05200249";
        ctrl_alu <= "0000"; --adicion
        wait for TbPeriod;
        op1 <= x"05200249";
        op2 <= x"04200241";
        ctrl_alu <= "0001"; --substracción
        wait for TbPeriod;
        op1 <= x"00000110";
        op2 <= x"00000141";
        ctrl_alu <= "0010"; --multiplicacion
        wait for TbPeriod;
        op1 <= x"04200241";
        op2 <= x"05200249";
        ctrl_alu <= "0000"; --adicion
        wait for TbPeriod;
        op1 <= x"04200241";
        op2 <= "00000000000000000000000000100000";
        ctrl_alu <= "1011"; --load
        wait for TbPeriod;
        op1 <= x"04200241";
        op2 <= "00000000000000000000000001100000";
        ctrl_alu <= "1011"; --adicion
        wait for TbPeriod;
        wait for TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;
