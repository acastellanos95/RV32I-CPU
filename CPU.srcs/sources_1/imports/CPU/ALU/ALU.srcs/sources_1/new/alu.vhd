----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2022 01:35:10 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
--use IEEE.std_logic_signed.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
generic(
data_path_size : integer:= 32
);
--    N :
  Port (
    op1, op2 : in std_logic_vector(data_path_size-1 downto 0);
    sal_alu : out std_logic_vector(data_path_size-1 downto 0);
--    H : out std_logic_vector(data_path_size-1 downto 0); --parte alta de la multiplicación
    ctrl_alu : in std_logic_vector(3 downto 0)
--    clk, rst : in std_logic
  );
end ALU;

architecture Behavioral of ALU is

--signal c_op2: std_logic_vector(data_path_size-1 downto 0);
signal mult: std_logic_vector(2*data_path_size-1 downto 0);
signal aux_out: std_logic_vector(data_path_size-1 downto 0):=(others => '0');
-- load
signal load_base, store_src: std_logic_vector(4 downto 0):=(others => '0');
signal offset: std_logic_vector(11 downto 0):=(others => '0');
signal store_offset: std_logic_vector(6 downto 0):=(others => '0');
signal op_imm1, op_imm2: std_logic_vector(data_path_size-1 downto 0):=(others => '0');
begin

alu_proc: process(op1, op2, ctrl_alu)
begin

--c_op2 <=  not(op2) + 1;
--    mult <= op1 * op2;
    case ctrl_alu is
        when "0000" => -- adición(ADD)
            sal_alu <= std_logic_vector(unsigned(op1) + unsigned(op2));
        when "0001" => -- substracción(SUB)
    --        sal_alu <= op1 + c_op2;-- complemento a 2
            sal_alu <= std_logic_vector(unsigned(op1) - unsigned(op2));
        when "0010" => -- multiplicación(MUL)
--            mult <= op1 * op2;
            sal_alu <= std_logic_vector(to_unsigned((to_integer(unsigned(op1)) * to_integer(unsigned(op2))),data_path_size)) ;
--            H <= mult(2*data_path_size-1 downto data_path_size);
--            sal_alu <= mult(data_path_size-1 downto 0);
--        when "0011" => -- shift izquierdo lógico(SLL)
--            aux_out <= std_logic_vector(unsigned(op1) sll to_integer(unsigned(op2(4 downto 0))));
    --        aux_out <= std_logic_vector(shift_left(unsigned(op1), to_integer(unsigned(op2(4 downto 0))))); -- recomendado en stackoverflow por alguna razón aunque funciona con ambas
--        when "0100" => -- shift derecho lógico(SRL)
--            aux_out <= std_logic_vector(unsigned(op1) srl to_integer(unsigned(op2(4 downto 0))));
    --        aux_out <= std_logic_vector(shift_right(unsigned(op1), to_integer(unsigned(op2(4 downto 0))))); -- recomendado también en stackoverflow
        when "0101" => -- AND lógico(AND)
            sal_alu <= op1 and op2;
        when "0110" => -- OR lógico(OR)
            sal_alu <= op1 or op2;
        when "0111" => -- XOR lógico(XOR)
            sal_alu <= op1 xor op2;
--        when "1000" => -- colocar menor que(SLT)
--            if signed(op1) < signed(op2) then
--                aux_out <= (0 => '1', others => '0');
--            else
--                aux_out <= (others => '0');
--            end if;
--        when "1001" => -- colocar menor que sin signo(SLTU)
--            if unsigned(op1) < unsigned(op2) then
--                aux_out <= (0 => '1', others => '0');
--            else
--                aux_out <= (others => '0');
--            end if;
--        when "1010" => -- shift derecho aritmético(SRA)
--            aux_out <= to_stdlogicvector(to_bitvector(std_logic_vector(op1)) sra to_integer(unsigned(op2(4 downto 0))));
        when "1011" => -- load
            sal_alu <= std_logic_vector(to_signed(to_integer(signed(op2(4 downto 0))) + to_integer(signed(op2(16 downto 5))), aux_out'length));
        when "1100" => -- store
--            store_src <= op2(4 downto 0);
--            store_offset <= op2(16 downto 10);
--            op_imm1(4 downto 0) <= store_src(4 downto 0); 
--            op_imm2(6 downto 0) <= store_offset(6 downto 0);
            sal_alu <= std_logic_vector(to_signed(to_integer(signed(op2(9 downto 5))) + to_integer(signed(op2(4 downto 0))), aux_out'length));
        when others =>
            sal_alu <= (others=>'U');
    end case;

end process alu_proc;


-- reloj
--sin: process(clk, rst)
--begin

--    if rst = '1' then
    
--        sal_alu <= (others=>'0');
--    elsif rising_edge(clk) then
        
--        sal_alu <= aux_out;
--    end if;
--end process sin;

end Behavioral;