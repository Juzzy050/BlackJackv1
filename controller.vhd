LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY controller IS
  PORT (
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	player_done: IN STD_LOGIC;
	dealer_done: IN STD_LOGIC;
	enable: IN STD_LOGIC;
	player_turn: OUT STD_LOGIC;
	dealer_turn: OUT STD_LOGIC;
	compare: OUT STD_LOGIC
    );
END;
 
ARCHITECTURE behaviour OF controller IS
BEGIN
	PROCESS(clk, rst, player_done, dealer_done, enable)
	BEGIN
		IF rst = '1' THEN 
			player_turn <= '0';
			dealer_turn <= '0';
			compare <= '0';
		ELSE 
			IF RISING_EDGE(clk) THEN
				IF enable = '1'THEN
					IF player_done = '0' THEN
						player_turn <= '1'; 
					ELSIF dealer_done = '0' THEN
						dealer_turn <= '1';
					ELSE 
						compare <= '1';
					END IF;
				ELSIF enable = '0' THEN
					player_turn <= '0';
					dealer_turn <= '0';
					compare <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
END;
	
