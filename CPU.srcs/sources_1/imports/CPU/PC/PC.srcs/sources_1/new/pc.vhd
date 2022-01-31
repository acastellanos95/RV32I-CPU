----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2022 07:08:03 PM
-- Design Name: 
-- Module Name: pc - Behavioral
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

entity pc is
    generic(n:integer:=32; j_size:integer:=16);
    Port (dir: in std_logic_vector(n-1 downto 0);
         ctrl_pc: in std_logic_vector(1 downto 0);
         clk, rst: in std_logic;
         j: in std_logic_vector(j_size-1 downto 0);
         pc_dir: out std_logic_vector(n-1 downto 0)
        );
end pc;

architecture Behavioral of pc is

    signal dir_mux, inc_mux, res_alu, pc_dir_alu_in, j_mask: std_logic_vector(n-1 downto 0):=(others => '0');
    constant inc: std_logic_vector(n-1 downto 0):=x"00000001";
--    signal current_pc   : std_logic_vector(n-1 downto 0) := x"FFFFFFF0";
begin
    dir_mux <= dir when (ctrl_pc(0) = '1') else res_alu;
    
    reg_pc: entity work.reg
        generic map(n=>32)
        port map(
            reg_in => dir_mux,
            reg_out => pc_dir_alu_in,
            clk => clk,
            rst => rst,
            we => '1'
        );

    pc_dir <= pc_dir_alu_in;
    j_mask(j_size-1 downto 0) <= j;
    inc_mux <= j_mask when (ctrl_pc(1) = '1') else inc;

    alu: entity work.pc_alu
        generic map(n=>32)
        port map(
            pc_dir => pc_dir_alu_in,
            inc => inc_mux,
            res => res_alu
        );


end Behavioral;
