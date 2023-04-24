library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Tempobot is
    Port ( clk, reset, enable, load : in STD_LOGIC;
			  alarm : out std_logic;
			  dbryan,ebryan : out std_logic_vector(6 downto 0));
          -- count_out_D : out integer;
          -- count_out_U : out integer;
           
end entity;

architecture Behavioral of Tempobot is

    signal count_reg : integer range 0 to 35 := 35;
    signal count_reg_1 : integer range 0 to 63;
    signal evento : integer := 0;
    signal convert : std_logic_vector(1 downto 0);
	 
	 signal count_out_D : integer;
	 signal count_out_U : integer;
    
begin

    process (clk, reset)

    constant data : integer :=  35;
    variable data_in : STD_LOGIC_VECTOR (5 downto 0);

    begin

        if evento = 0 then

            if reset = '0' then
                count_reg <= 35;
                
                elsif (rising_edge(clk)) then
                
                    if enable = '1' then
                
                        if load = '1' then
                
                            count_reg <= data;
                
                            if (count_reg = 0) then
                                count_reg <= data;
                                evento <= 1;
                
                            else
                                count_reg <= count_reg - 1;
                            end if;
                        end if;
                    end if;
                
                if enable = '1' then
                
                    if load = '0' then
                
                        count_reg <= data;
                    end if;
                end if;
                
                if enable = '0' then
                    
                    if load = '0' then
                
                    count_reg <= data;
                    end if;
                end if;
            end if;
            
            count_out_D <= count_reg / 10;
            count_out_U <= count_reg mod 10;

        end if;
        
        if evento = 1 then
            if reset = '0' then
                count_reg_1 <= 0;
                    
                elsif (rising_edge(clk)) then
                
                    if enable = '1' then
                        
                            if load = '1' then
                                
                                count_reg_1 <= to_integer(unsigned(data_in));
                                
                                    if (count_reg_1 = 63) then
                                        count_reg_1 <= 0;
                                        else
                                            count_reg_1 <= count_reg_1 + 1;
                                    end if;
                            end if;
                    end if;
                        
                    if enable = '1' then
                        
                        if load = '0' then
                                
                            count_reg_1 <= to_integer(unsigned(data_in));
                        end if;
                    end if;	
                            
                    if enable = '0' then
                        
                        if load = '0' then
                                
                            count_reg_1 <= to_integer(unsigned(data_in));
                        end if;
                    end if;
            end if;

            count_out_D <= count_reg_1 / 10;
            count_out_U <= count_reg_1 mod 10;
        end if;
    end process;
	 
	 
	 
	 process (count_out_U) begin
		case count_out_U is 
			when 0 =>dbryan<= "0000001";
			when 1 =>dbryan<= "1001111";
			when 2 =>dbryan<= "0010010";
			when 3 =>dbryan<= "0000110";
			when 4 =>dbryan<= "1001100";
			when 5 =>dbryan<= "0100100";
			when 6 =>dbryan<= "0100000";
			when 7 =>dbryan<= "0001111";
			when 8 =>dbryan<= "0000000";
			when 9 =>dbryan<= "0000100";
			when others  =>dbryan<= "1111111";
		end case;
	end process;
		
	process (count_out_D) begin
		case count_out_D is
			when 1 =>ebryan<= "1001111";
			when 2 =>ebryan<= "0010010";
			when 3 =>ebryan<= "0000110";
			when 4 =>ebryan<= "1001100";
			when 5 =>ebryan<= "0100100";
			when 6 =>ebryan<= "0100000";
			when others  =>ebryan<= "1111111";
		end case;
	end process;

    
    convert <= std_logic_vector(to_unsigned(evento, 2));
    alarm <= convert(0);
end Behavioral;
