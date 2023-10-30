LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY compare IS
  PORT (
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	player: IN INTEGER;
	dealer: IN INTEGER;
	enable: IN STD_LOGIC;
	player_win: OUT STD_LOGIC;
	done: OUT STD_LOGIC
	
    );
END;
 
ARCHITECTURE behaviour OF compare IS
BEGIN
	PROCESS(clk, rst, player, dealer)
		BEGIN
		IF rst = '1' THEN 
			player_win <= '0';
			done <= '0';
		ELSE 
			IF RISING_EDGE(clk) THEN
				IF enable = '1' THEN
					IF player > dealer THEN
						player_win <= '1';
					ELSE
						player_win <= '0';
					END IF;
					done <= '1';
				ELSIF enable = '0' THEN
					done <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
END;

	
