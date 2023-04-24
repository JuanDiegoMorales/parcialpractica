library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity Vehiculos2 is

  port ( parqueadero : in std_logic_vector(3 downto 0);
			posicion : in std_logic_vector(2 downto 0);
			clock, reset, enable : in std_logic;
			alarm : out std_logic_vector(3 downto 0);
			decenas, unidades, numero_vehiculo : out std_logic_vector(6 downto 0)) ;

end entity;

architecture arch of Vehiculos2 is

signal u1,u2,u3,u4 : std_logic_vector(6 downto 0);
signal d1,d2,d3,d4 : std_logic_vector(6 downto 0);

signal load1	: STD_LOGIC := '1';

component Tempobot
Port ( clk, reset, enable, load : in STD_LOGIC;
		 alarm : out std_logic;
		 dbryan,ebryan : out std_logic_vector(6 downto 0));
end component;

begin

P1 : Tempobot port map (clk => clock, reset => reset, enable => parqueadero(0), alarm => alarm(0), load => load1, dbryan => u1, ebryan => d1);
P2 : Tempobot port map (clk => clock, reset => reset, enable => parqueadero(1), alarm => alarm(1), load => load1, dbryan => u2, ebryan => d2);
P3 : Tempobot port map (clk => clock, reset => reset, enable => parqueadero(2), alarm => alarm(2), load => load1, dbryan => u3, ebryan => d3);
P4 : Tempobot port map (clk => clock, reset => reset, enable => parqueadero(3), alarm => alarm(3), load => load1, dbryan => u4, ebryan => d4);
--P5 : ContadorAs port map (clk => clock, reset => reset, enable => parqueadero(4), alarm => alarm(4), dbryan => u5, ebryan => d5);
--P6 : ContadorAs port map (clk => clock, reset => reset, enable => parqueadero(5), alarm => alarm(5), dbryan => u6, ebryan => d6);
--P7 : ContadorAs port map (clk => clock, reset => reset, enable => parqueadero(6), alarm => alarm(6), dbryan => u7, ebryan => d7);
--P8 : ContadorAs port map (clk => clock, reset => reset, enable => parqueadero(7), alarm => alarm(7), dbryan => u8, ebryan => d8);


 with posicion select
 unidades <= u1 when "000",
u2 when "001",
u3 when "010",
u4 when "011",
--u5 when "100",
--u6 when "101",
--u7 when "110",
--u8 when "111",
"1111111" when others;

 with posicion select
 decenas <= d1 when "000",
d2 when "001",
d3 when "010",
d4 when "011",
--d5 when "100",
--d6 when "101",
--d7 when "110",
--d8 when "111",
"1111111" when others;

 deco_vehiculos : process(posicion) is
 begin
case posicion is
when "000" =>numero_vehiculo<= "1001111";
when "001" =>numero_vehiculo<= "0010010";
when "010" =>numero_vehiculo<= "0000110";
when "011" =>numero_vehiculo<= "1001100";
--when "100" =>numero_vehiculo<= "0100100";
--when "101" =>numero_vehiculo<= "0100000";
--when "110" =>numero_vehiculo<= "0001111";
--when "111" =>numero_vehiculo<= "0000000";
when others  =>numero_vehiculo<= "1111111";
end case;
end process;

end architecture ;
