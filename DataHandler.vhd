library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity DataHandler is
	Port ( 
		
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		
		readSig : in STD_LOGIC;
		writeSig : in STD_LOGIC;
		increment : in STD_LOGIC_VECTOR (7 downto 0);
		addr0 : in STD_LOGIC_VECTOR (7 downto 0);
		data_fromCU : in STD_LOGIC_VECTOR (7 downto 0);
		
		mem_data_from_mem : in STD_LOGIC_VECTOR (7 downto 0);
		mem_data_to_mem : out STD_LOGIC_VECTOR (7 downto 0);
		
		REn : out STD_LOGIC;
		WEn : out STD_LOGIC;
		mem_cur_addr : out STD_LOGIC_VECTOR (7 downto 0);
		data_fetched : out STD_LOGIC_VECTOR (7 downto 0)
		
		
	);
end DataHandler;
 
architecture Behavioral of DataHandler is
	signal mem_read : STD_LOGIC := '0';
	signal mem_write : STD_LOGIC := '0';
	signal fetched_reg : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	begin
		
		
		
		
		 process(clk, reset)
		 begin
			  if reset = '1' then
					REn <= '0';
					WEn <= '0';
					mem_data_to_mem <= "ZZZZZZZZ";
					fetched_reg <= "00000000";
			  elsif rising_edge(clk) then
					REn <= readSig;
					WEn <= writeSig;
					mem_cur_addr <= STD_LOGIC_VECTOR(UNSIGNED(addr0) + UNSIGNED(increment));
					if writeSig = '1' then
						 
						 mem_data_to_mem <= data_fromCU;
						 --data_fetched <= "ZZZZZZZZ";
					end if;
					--fetched_reg <= mem_data_from_mem;
						
					
			  end if;
			  
		 end process;
		 --REn <= readSig;
		 data_fetched <= mem_data_from_mem;
		 
				
end Behavioral;