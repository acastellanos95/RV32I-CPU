----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2022 03:03:50 PM
-- Design Name: 
-- Module Name: banco_reg - Behavioral
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

entity banco_reg is
    generic(n:integer:=32; nreg:integer:=8);
    Port (read_reg1, read_reg2, regwrt: in std_logic_vector(4 downto 0);
         dato: in std_logic_vector(n-1 downto 0);
         clk, rst: in std_logic;
         ctrl_wr: in std_logic;
         rd_data1, rd_data2: out std_logic_vector(n-1 downto 0)

        );
end banco_reg;

architecture Behavioral of banco_reg is

    signal datareg: std_logic_vector((n*nreg)-1 downto 0):=(31 downto 0 => '0', others => 'U'); -- x0 is zero
    signal ctrl_wrt_al: std_logic_vector(nreg-1 downto 0);
    signal we_al, we_al2: std_logic_vector(nreg-1 downto 0);

begin

    ctrl_wrt_al <= (others => ctrl_wr);
    we_al2 <= we_al and ctrl_wrt_al;

    gen_reg:
 for I in 0 to nreg-1 generate
        regx: entity work.reg
            generic map(n=>32)
            port map(
                reg_in => dato,
                reg_out => datareg((i+1)*n-1 downto n*i),
                clk => clk,
                rst => rst,
                we => we_al2(i)
            );
    end generate;


    process(regwrt, clk)
    begin
        case regwrt is
            when "00000" => -- demux write to x0
                we_al <= x"01";
            when "00001" => -- demux write to x1
                we_al <= x"02";
            when "00010" => -- demux write to x2
                we_al <= x"04";
            when "00011" => -- demux write to x3
                we_al <= x"08";
            when "00100" => -- demux write to x4
                we_al <= x"10";
            when "00101" => -- demux write to x5
                we_al <= x"20";
            when "00110" => -- demux write to x6
                we_al <= x"40";
            when "00111" => -- demux write to x7
                we_al <= x"80";
--            when "01000" => -- demux write to x8
--                we_al <= x"00000100";
--            when "01001" => -- demux write to x9
--                we_al <= x"00000200";
--            when "01010" => -- demux write to x10
--                we_al <= x"00000400";
--            when "01011" => -- demux write to x11
--                we_al <= x"00000800";
--            when "01100" => -- demux write to x12
--                we_al <= x"00001000";
--            when "01101" => -- demux write to x13
--                we_al <= x"00002000";
--            when "01110" => -- demux write to x14
--                we_al <= x"00004000";
--            when "01111" => -- demux write to x15
--                we_al <= x"00008000";
--            when "10000" => -- demux write to x16
--                we_al <= x"00010000";
--            when "10001" => -- demux write to x17
--                we_al <= x"00020000";
--            when "10010" => -- demux write to x18
--                we_al <= x"00040000";
--            when "10011" => -- demux write to x19
--                we_al <= x"00080000";
--            when "10100" => -- demux write to x20
--                we_al <= x"00100000";
--            when "10101" => -- demux write to x21
--                we_al <= x"00200000";
--            when "10110" => -- demux write to x22
--                we_al <= x"00400000";
--            when "10111" => -- demux write to x23
--                we_al <= x"00800000";
--            when "11000" => -- demux write to x24
--                we_al <= x"01000000";
--            when "11001" => -- demux write to x25
--                we_al <= x"02000000";
--            when "11010" => -- demux write to x26
--                we_al <= x"04000000";
--            when "11011" => -- demux write to x27
--                we_al <= x"08000000";
--            when "11100" => -- demux write to x28
--                we_al <= x"10000000";
--            when "11101" => -- demux write to x29
--                we_al <= x"20000000";
--            when "11110" => -- demux write to x30
--                we_al <= x"40000000";
--            when "11111" => -- demux write to x31
--                we_al <= x"80000000";
            when others =>
                we_al <= (others => '0');
        end case;
    end process;

    process(read_reg1, clk)
    begin
        case read_reg1 is
            when "00000" => -- mux to read x0
                rd_data1 <= datareg(n-1 downto 0);
            when "00001" => -- mux to read x1
                rd_data1 <= datareg(2*n-1 downto n);
            when "00010" => -- mux to read x2
                rd_data1 <= datareg(3*n-1 downto 2*n);
            when "00011" => -- mux to read x3
                rd_data1 <= datareg(4*n-1 downto 3*n);
            when "00100" => -- mux to read x4
                rd_data1 <= datareg(5*n-1 downto 4*n);
            when "00101" => -- mux to read x5
                rd_data1 <= datareg(6*n-1 downto 5*n);
            when "00110" => -- mux to read x6
                rd_data1 <= datareg(7*n-1 downto 6*n);
            when "00111" => -- mux to read x7
                rd_data1 <= datareg(8*n-1 downto 7*n);
--            when "01000" => -- mux to read x8
--                rd_data1 <= datareg(9*n-1 downto 8*n);
--            when "01001" => -- mux to read x9
--                rd_data1 <= datareg(10*n-1 downto 9*n);
--            when "01010" => -- mux to read x10
--                rd_data1 <= datareg(11*n-1 downto 10*n);
--            when "01011" => -- mux to read x11
--                rd_data1 <= datareg(12*n-1 downto 11*n);
--            when "01100" => -- mux to read x12
--                rd_data1 <= datareg(13*n-1 downto 12*n);
--            when "01101" => -- mux to read x13
--                rd_data1 <= datareg(14*n-1 downto 13*n);
--            when "01110" => -- mux to read x14
--                rd_data1 <= datareg(15*n-1 downto 14*n);
--            when "01111" => -- mux to read x15
--                rd_data1 <= datareg(16*n-1 downto 15*n);
--            when "10000" => -- mux to read x16
--                rd_data1 <= datareg(17*n-1 downto 16*n);
--            when "10001" => -- mux to read x17
--                rd_data1 <= datareg(18*n-1 downto 17*n);
--            when "10010" => -- mux to read x18
--                rd_data1 <= datareg(19*n-1 downto 18*n);
--            when "10011" => -- mux to read x19
--                rd_data1 <= datareg(20*n-1 downto 19*n);
--            when "10100" => -- mux to read x20
--                rd_data1 <= datareg(21*n-1 downto 20*n);
--            when "10101" => -- mux to read x21
--                rd_data1 <= datareg(22*n-1 downto 21*n);
--            when "10110" => -- mux to read x22
--                rd_data1 <= datareg(23*n-1 downto 22*n);
--            when "10111" => -- mux to read x23
--                rd_data1 <= datareg(24*n-1 downto 23*n);
--            when "11000" => -- mux to read x24
--                rd_data1 <= datareg(25*n-1 downto 24*n);
--            when "11001" => -- mux to read x25
--                rd_data1 <= datareg(26*n-1 downto 25*n);
--            when "11010" => -- mux to read x26
--                rd_data1 <= datareg(27*n-1 downto 26*n);
--            when "11011" => -- mux to read x27
--                rd_data1 <= datareg(28*n-1 downto 27*n);
--            when "11100" => -- mux to read x28
--                rd_data1 <= datareg(29*n-1 downto 28*n);
--            when "11101" => -- mux to read x29
--                rd_data1 <= datareg(30*n-1 downto 29*n);
--            when "11110" => -- mux to read x30
--                rd_data1 <= datareg(31*n-1 downto 30*n);
--            when "11111" => -- mux to read x31
--                rd_data1 <= datareg(32*n-1 downto 31*n);
            when others =>
                rd_data1 <= (others => '0');
        end case;
    end process;

    process(read_reg2, clk)
    begin
        case read_reg2 is
            when "00000" => -- mux to read x0
                rd_data2 <= datareg(n-1 downto 0);
            when "00001" => -- mux to read x1
                rd_data2 <= datareg(2*n-1 downto n);
            when "00010" => -- mux to read x2
                rd_data2 <= datareg(3*n-1 downto 2*n);
            when "00011" => -- mux to read x3
                rd_data2 <= datareg(4*n-1 downto 3*n);
            when "00100" => -- mux to read x4
                rd_data2 <= datareg(5*n-1 downto 4*n);
            when "00101" => -- mux to read x5
                rd_data2 <= datareg(6*n-1 downto 5*n);
            when "00110" => -- mux to read x6
                rd_data2 <= datareg(7*n-1 downto 6*n);
            when "00111" => -- mux to read x7
                rd_data2 <= datareg(8*n-1 downto 7*n);
--            when "01000" => -- mux to read x8
--                rd_data2 <= datareg(9*n-1 downto 8*n);
--            when "01001" => -- mux to read x9
--                rd_data2 <= datareg(10*n-1 downto 9*n);
--            when "01010" => -- mux to read x10
--                rd_data2 <= datareg(11*n-1 downto 10*n);
--            when "01011" => -- mux to read x11
--                rd_data2 <= datareg(12*n-1 downto 11*n);
--            when "01100" => -- mux to read x12
--                rd_data2 <= datareg(13*n-1 downto 12*n);
--            when "01101" => -- mux to read x13
--                rd_data2 <= datareg(14*n-1 downto 13*n);
--            when "01110" => -- mux to read x14
--                rd_data2 <= datareg(15*n-1 downto 14*n);
--            when "01111" => -- mux to read x15
--                rd_data2 <= datareg(16*n-1 downto 15*n);
--            when "10000" => -- mux to read x16
--                rd_data2 <= datareg(17*n-1 downto 16*n);
--            when "10001" => -- mux to read x17
--                rd_data2 <= datareg(18*n-1 downto 17*n);
--            when "10010" => -- mux to read x18
--                rd_data2 <= datareg(19*n-1 downto 18*n);
--            when "10011" => -- mux to read x19
--                rd_data2 <= datareg(20*n-1 downto 19*n);
--            when "10100" => -- mux to read x20
--                rd_data2 <= datareg(21*n-1 downto 20*n);
--            when "10101" => -- mux to read x21
--                rd_data2 <= datareg(22*n-1 downto 21*n);
--            when "10110" => -- mux to read x22
--                rd_data2 <= datareg(23*n-1 downto 22*n);
--            when "10111" => -- mux to read x23
--                rd_data2 <= datareg(24*n-1 downto 23*n);
--            when "11000" => -- mux to read x24
--                rd_data2 <= datareg(25*n-1 downto 24*n);
--            when "11001" => -- mux to read x25
--                rd_data2 <= datareg(26*n-1 downto 25*n);
--            when "11010" => -- mux to read x26
--                rd_data2 <= datareg(27*n-1 downto 26*n);
--            when "11011" => -- mux to read x27
--                rd_data2 <= datareg(28*n-1 downto 27*n);
--            when "11100" => -- mux to read x28
--                rd_data2 <= datareg(29*n-1 downto 28*n);
--            when "11101" => -- mux to read x29
--                rd_data2 <= datareg(30*n-1 downto 29*n);
--            when "11110" => -- mux to read x30
--                rd_data2 <= datareg(31*n-1 downto 30*n);
--            when "11111" => -- mux to read x31
--                rd_data2 <= datareg(32*n-1 downto 31*n);
            when others =>
                rd_data2 <= (others => '0');
        end case;
    end process;

end Behavioral;
