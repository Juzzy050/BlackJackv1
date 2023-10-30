LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY work;
USE work.ALL;

ENTITY blackJack IS 
PORT (
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	hit: IN STD_LOGIC;
	stand: IN STD_LOGIC;
	enable: IN STD_LOGIC;
	player_win: OUT STD_LOGIC;
	finished: OUT STD_LOGIC
	    );
END;
 
ARCHITECTURE structure OF blackJack IS
	SIGNAL player_turn : STD_LOGIC;
	SIGNAL dealer_turn : STD_LOGIC;
	SIGNAL compare_on : STD_LOGIC;
	SIGNAL player_done : STD_LOGIC;
	SIGNAL dealer_done : STD_LOGIC;
	SIGNAL next_card : INTEGER;
	SIGNAL player_hand : INTEGER;
	SIGNAL dealer_hand : INTEGER;
BEGIN
Controller: entity work.controller(behaviour) 
		port map(
			clk => clk,
			rst => rst,
			player_done => player_done,
			dealer_done => dealer_done,
			enable => enable,
			player_turn => player_turn,
			dealer_turn => dealer_turn,
			compare => compare_on
		);
	Player: entity work.player(behaviour)
		port map(
			clk => clk,
			rst => rst,
			hit => hit,
			stand => stand,
			enable => player_turn,
			card => next_card,
			hand => player_hand,
			done => player_done
		);
	Dealer: entity work.dealer(behaviour)
		port map(
			clk => clk,
			rst => rst,
			enable => dealer_turn,
			card => next_card,
			hand => dealer_hand,
			done => dealer_done
		);
	Deck: entity work.deck(behaviour)
		port map(
			clk => clk,
			rst => rst,
			card => next_card
		);
	Compare: entity work.compare(behaviour)
		port map(
			clk => clk,
			rst => rst,
			player => player_hand,
			dealer => dealer_hand,
			enable => compare_on,
			player_win => player_win,
			done => finished
		);

END;
		
	
