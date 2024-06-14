library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity NIterator is
	Port ( 
		N_i : in STD_LOGIC_VECTOR (7 downto 0);
		init : in STD_LOGIC;
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		
		count : out STD_LOGIC_VECTOR (7 downto 0);
		preemp_done : out STD_LOGIC;
		done : out STD_LOGIC
	);
end NIterator;
 
architecture Behavioral of NIterator is
	signal count_reg : UNSIGNED(7 downto 0) := (others => '0');
   --signal about_to : STD_LOGIC := '0';
	begin
		 process(clk, reset)
		 begin
			  if reset = '1' then
					count_reg <= (others => '0');
					--about_to <= '0';
					
			  elsif rising_edge(clk) then
					if init = '1' then
						 count_reg <= "00000000";
						 --about_to <= '0';
						 
					elsif count_reg <= UNSIGNED(N_i) + 1 then --remember to take clk delay into account...
						 count_reg <= count_reg + 1;
					--elsif count_reg = "00000001" then
						 --count_reg <= count_reg - 1;
						 --about_to <= '1';
						 
					end if;
			  end if;
			  
		 end process;
		 count <= STD_LOGIC_VECTOR(count_reg) when count_reg <= UNSIGNED(N_i);
		 preemp_done <= '1' when (count_reg >= UNSIGNED(N_i)) else '0'; --over here aswell
		 done <= '1' when (count_reg >= UNSIGNED(N_i) + 1) else '0'; --over here aswell
		
end Behavioral;