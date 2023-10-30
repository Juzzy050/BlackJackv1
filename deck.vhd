LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY deck IS
  PORT (
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	card: OUT INTEGER	
    );
END;
ARCHITECTURE behaviour OF deck IS
	SIGNAL temp_card: INTEGER;
BEGIN
	PROCESS(clk, rst)
	BEGIN
		IF rst = '1' THEN 
			card <= 1;
			temp_card <= 1;
		ELSE 
			IF RISING_EDGE(clk) THEN
				temp_card <= temp_card + 1;
				IF temp_card > 12 THEN
					temp_card <= 1;
				END IF;
				card <= temp_card;
			END IF;		
		END IF;
	END PROCESS;
END;
