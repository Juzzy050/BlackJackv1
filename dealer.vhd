LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY dealer IS
  PORT (
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	enable: IN STD_LOGIC;
	card: IN INTEGER;
	hand: OUT INTEGER;
	done: OUT STD_LOGIC
    );
END;
 
ARCHITECTURE behaviour OF dealer IS
	SIGNAL aces : INTEGER;
	SIGNAL temp_hand : INTEGER;
BEGIN
	PROCESS(clk, rst, enable, card)
	BEGIN
		IF rst = '1' THEN 
			hand <= 0;
			temp_hand <= 0;
			aces <= 0;
			done <= '0';
		ELSE 
			IF RISING_EDGE(clk) THEN
				IF  enable = '1' THEN
					IF temp_hand > 21 THEN
						IF aces > 0 THEN
							aces <= aces - 1;
							temp_hand <= temp_hand - 10;
							hand <= temp_hand;
						ELSE
							hand <= 0;
							done <= '1';
						END IF;
					ELSIF	temp_hand > 16 THEN
						hand <= temp_hand;
						done <= '1';
						ELSE
						IF card > 10 THEN
							temp_hand <= temp_hand + 10;
						ELSIF card = 1 THEN
							temp_hand <= temp_hand + 11;
							aces <= aces + 1;
						ELSE
							temp_hand <= temp_hand + card;
						END IF;
						hand <= temp_hand;
					END IF;
				END IF;
				
				IF enable = '0' THEN
					done <= '0';
				END IF;
			END IF;
		END IF;	
	END PROCESS;
END;
					
	
