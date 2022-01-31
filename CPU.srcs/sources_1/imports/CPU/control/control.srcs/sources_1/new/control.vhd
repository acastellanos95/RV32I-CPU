----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2022 10:01:35 PM
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
  Port (
    opcode: in std_logic_vector(6 downto 0);
    clk, rst: in std_logic;
    memread, memtoreg, memwrite, alusrc, regwrite: out std_logic;
    aluop: out std_logic_vector(3 downto 0);
    ctrlpc: out std_logic_vector(1 downto 0)
  );
end control;

architecture Behavioral of control is

   -- Selection of what is out of the PC
   constant PC_INC                      : STD_LOGIC_VECTOR(1 downto 0) := "00";
   constant PC_ADR                     : STD_LOGIC_VECTOR(1 downto 0) := "01";
   constant PC_JUMP                     : STD_LOGIC_VECTOR(1 downto 0) := "10";

   -- Logical and addition functions
   constant ALU_OR                      : STD_LOGIC_VECTOR(3 downto 0) := "0110";
   constant ALU_AND                     : STD_LOGIC_VECTOR(3 downto 0) := "0101";
   constant ALU_XOR                     : STD_LOGIC_VECTOR(3 downto 0) := "0111";
   constant ALU_MULT                    : STD_LOGIC_VECTOR(3 downto 0) := "0010";
   constant ALU_ADD                     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
   constant ALU_SUB                     : STD_LOGIC_VECTOR(3 downto 0) := "0001";
   constant ALU_LESS_THAN_SIGNED        : STD_LOGIC_VECTOR(3 downto 0) := "1000";
   constant ALU_LESS_THAN_UNSIGNED      : STD_LOGIC_VECTOR(3 downto 0) := "1001";
   constant SHIFTER_LEFT_LOGICAL        : STD_LOGIC_VECTOR(3 downto 0) := "0011";
   constant SHIFTER_RIGHT_LOGICAL       : STD_LOGIC_VECTOR(3 downto 0) := "0100";
   constant SHIFTER_RIGHT_ARITH         : STD_LOGIC_VECTOR(3 downto 0) := "1010";
   constant LOAD                        : STD_LOGIC_VECTOR(3 downto 0) := "1011";
   constant STORE                       : STD_LOGIC_VECTOR(3 downto 0) := "1100";
   
begin

process(opcode)
begin
    case opcode is
        -- R-type
        when "0000000" => -- add r1, r2, r3
            aluop <= ALU_ADD;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000001" => -- sub r1, r2, r3
            aluop <= ALU_SUB;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000010" => -- mult r1, r2, r3
            aluop <= ALU_MULT;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000011" => -- and r1, r2, r3
            aluop <= ALU_AND;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000100" => -- or r1, r2, r3
            aluop <= ALU_OR;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000101" => -- xor r1, r2, r3
            aluop <= ALU_XOR;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000110" => -- lts r1, r2, r3
            aluop <= ALU_LESS_THAN_SIGNED;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0000111" => -- lts(u) r1, r2, r3
            aluop <= ALU_LESS_THAN_UNSIGNED;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0001000" => -- slt r1, r2, r3
            aluop <= SHIFTER_LEFT_LOGICAL;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0001001" => -- srt r1, r2, r3
            aluop <= SHIFTER_RIGHT_LOGICAL;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0001010" => -- sra r1, r2, r3
            aluop <= SHIFTER_RIGHT_ARITH;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '1';
        when "0001011" => -- ldr r1, addr
            aluop <= LOAD;
            ctrlpc <= PC_INC;
            memread <= '1'; 
            memtoreg <= '1';
            memwrite <= '0';
            alusrc <= '1';
            regwrite <= '1';
        when "0001100" => -- str r1, addr
            aluop <= STORE;
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '1';
            alusrc <= '1';
            regwrite <= '0';
        when "0001101" => -- jump r1, addr
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '1';
            alusrc <= '0';
            regwrite <= '0';
        when others =>
            ctrlpc <= PC_INC;
            memread <= '0'; 
            memtoreg <= '0';
            memwrite <= '0';
            alusrc <= '0';
            regwrite <= '0';
    end case;
end process;

end Behavioral;
