LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY divisorfrecuencia2 IS
    PORT (  clk : IN STD_LOGIC;
            out1, out2 : BUFFER STD_LOGIC);
END ENTITY;

ARCHITECTURE example OF divisorfrecuencia2 IS  
        SIGNAL count1: INTEGER RANGE 0 TO 50000000;
       
    BEGIN
        PROCESS (clk)
VARIABLE count2: INTEGER RANGE 0 TO 50000000;
        BEGIN
            IF (clk' EVENT AND clk='1') THEN
                count1 <= count1 + 1;
                count2 := count2 + 1;
               
                IF (count1 = 24999999 ) THEN
                    out1 <= NOT out1;
                    count1 <= 1;
                END IF;
               
                IF (count2 = 25000000 ) THEN
                    out2 <= NOT out2;
                    count2 := 1;
                END IF;
            END IF;
        END PROCESS;
END example;
