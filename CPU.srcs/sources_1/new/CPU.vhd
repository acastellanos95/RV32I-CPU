----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2022 17:39:25
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
  Port (clk, rst: in std_logic );
end CPU;

architecture Behavioral of CPU is
    signal pc_dir_to_instrmem, mem_instr, read_data1, read_data2, alu_result, read_data_mem, writedata, op2, H: std_logic_vector(31 downto 0);
    signal  ImmOut: std_logic_vector(31 downto 0):=(others => '0');
    signal memread, memtoreg, memwrite, alusrc, regwrite: std_logic;
    signal aluop: std_logic_vector(3 downto 0);
    signal ctrlpc: std_logic_vector(1 downto 0);
    signal immout_down: std_logic_vector(20 downto 0);
    -- todo: read_data2(mux) op2(mux)
begin
    
    op2 <= read_data2 when(alusrc = '0') else ImmOut;
    ImmOut(20 downto 0) <= immout_down;
    writedata <= read_data_mem when(memtoreg = '1') else alu_result;

    instr_mem: entity work.instruction_memory
        generic map(n=>32)
        port map(
            clk => clk,
            rst => rst,
            addr => pc_dir_to_instrmem,
            instruction_out => mem_instr
        );
        
    MemDat: entity work.memoria_datos
        generic map(n=>32)
        port map(
            clk => clk,
            rst => rst,
            en => '1',
            we => memwrite,
            addr => alu_result,
            data_in => read_data2,
            data_out => read_data_mem
        );
        
    reg: entity work.banco_reg
        generic map(n=>32)
        port map(
            clk => clk,
            rst => rst,
            read_reg1 => mem_instr(19 downto 15),
            read_reg2 => mem_instr(24 downto 20),
            regwrt => mem_instr(11 downto 7),
            dato => writedata,
            ctrl_wr => regwrite,
            rd_data1 => read_data1,
            rd_data2 => read_data2
        );
    
    control: entity work.control
        port map(
            opcode => mem_instr(6 downto 0),
            clk => clk,
            rst => rst,
            memread => memread,
            memtoreg => memtoreg,
            memwrite => memwrite,
            alusrc => alusrc,
            regwrite => regwrite,
            aluop => aluop,
            ctrlpc => ctrlpc
        );
        
    PC: entity work.pc
        generic map(n=>32)
        port map(
            dir => x"00000000",
            ctrl_pc => ctrlpc,
            clk => clk,
            rst => rst,
            j => ImmOut(15 downto 0),
            pc_dir => pc_dir_to_instrmem
        );
        
    imm_gen: entity work.immgen
        port map(
            instr => mem_instr,
            ImmOut => immout_down
        );
        
    ALU: entity work.alu
        port map(
            clk => clk,
            rst => rst,
            ctrl_alu => aluop,
            op1 => read_data1,
            op2 => op2,
            sal_alu => alu_result,
            H => H
        );
        

end Behavioral;
