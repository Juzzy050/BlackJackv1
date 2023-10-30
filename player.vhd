LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY player IS
  PORT (
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	hit: IN STD_LOGIC;
	stand: IN STD_LOGIC;
	enable: IN STD_LOGIC;
	card: IN INTEGER;
	hand: OUT INTEGER;
	display_hand_tens: OUT STD_LOGIC_VECTOR (3 downto 0);
	display_hand_ones: OUT STD_LOGIC_VECTOR (3 downto 0);

	done: OUT STD_LOGIC
    );
END;
 
ARCHITECTURE behaviour OF player IS
	SIGNAL aces : INTEGER;
	SIGNAL temp_hand : INTEGER;
	SIGNAL hit_registered: STD_LOGIC;
	SIGNAL tens: INTEGER;
	SIGNAL ones: INTEGER;

	BEGIN
	PROCESS(clk, rst, hit, stand, enable, card)
	BEGIN
		IF rst = '1' THEN 
			hand <= 0;
			temp_hand <= 0;
			aces <= 0;
			done <= '0';
		ELSE 
			IF RISING_EDGE(clk) THEN
				IF enable = '1' THEN
					-- check hand
					IF temp_hand > 21 THEN
						IF aces > 0 THEN
							aces <= aces - 1;
							temp_hand <= temp_hand - 10;
						ELSE
							hand <= 0;
							done <= '1';
						END IF;
					END IF;
					
					--hit
					IF hit = '1' AND hit_registered = '0' THEN
						IF card > 10 THEN
							temp_hand <= temp_hand + 10;
						ELSIF card = 1 THEN
							temp_hand <= temp_hand + 11;
							aces <= aces + 1;
						ELSE
							temp_hand <= temp_hand + card;
						END IF;
						
						hit_registered <= '1';
					END IF;
					
					--check for button release
					if hit = '0' THEN
						hit_registered <= '0';
					END IF;
					hand <= temp_hand;
					
					--stand
					IF stand = '1' THEN
						hand <= temp_hand;
						done <= '1';
					END IF;				
				
				END IF;
				
				--on disable
				IF enable = '0' THEN
					done <= '0';
				END IF;
				
				ones <= hand mod 10;
				tens <= hand / 10;
				
				display_hand_ones <= std_logic_vector(to_unsigned(ones, display_hand_ones'length));
				display_hand_tens <= std_logic_vector(to_unsigned(tens, display_hand_tens'length));
				
			END IF;
		END IF;	
	END PROCESS;
END;
					
	
