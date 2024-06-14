library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
    Port (
         start : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 Diff_loaded : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 N_i : in STD_LOGIC_VECTOR (7 downto 0);
		
		 done_actual : out STD_LOGIC;
		 count : out STD_LOGIC_VECTOR (7 downto 0);
		 init : out STD_LOGIC;
		 readSig : out STD_LOGIC;
		 writeSig : out STD_LOGIC
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
    
	 component NIterator is
	   Port ( 
			N_i : in STD_LOGIC_VECTOR (7 downto 0);
			init : in STD_LOGIC;
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			
			count : out STD_LOGIC_VECTOR (7 downto 0);
			preemp_done : out STD_LOGIC;
			done : out STD_LOGIC
		);
	end component;
	 signal  go_init, done_NI, read_buf, doneRead : STD_LOGIC;
	 --signal  read_buf : STD_LOGIC := '0';
	 
begin

	writeSig <= done_NI;
	readSig <= start and (not doneRead);
	
	
	go_init <= start and (not Diff_loaded);
	init <= go_init;
	
	process(clk, reset)
		 begin
			  if reset = '1' then
					done_actual <= '0';
					
			  elsif rising_edge(clk) then
					done_actual <= done_NI;
			  end if;
			  
		 end process;
	
	
	
    NI: NIterator port map( N_i, go_init, clk, reset, count, doneRead, done_NI);
	 
	 
end Behavioral;
