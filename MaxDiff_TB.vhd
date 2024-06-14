library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MaxDiff_TB is
end MaxDiff_TB;

architecture TB_ARCH of MaxDiff_TB is
    constant CLOCK_PERIOD : time := 10 ns;

		signal start    :   STD_LOGIC;
      
		signal N_i :  STD_LOGIC_VECTOR (7 downto 0);
		signal addr    :   STD_LOGIC_VECTOR(7 downto 0);
		signal clk :  STD_LOGIC;
		signal reset :  STD_LOGIC;		
		  
      signal debug_Diff    :  std_logic_vector(7 downto 0);		
		signal debug_data_fetched    :  std_logic_vector(7 downto 0);
		signal debug_count    :  std_logic_vector(7 downto 0);
		signal done :  STD_LOGIC;

begin
    -- Clock Generation Process
    CLK_GEN_PROCESS: process
        variable cycle_count : integer := 0;
    begin
            clk <= '0';
            wait for CLOCK_PERIOD / 2;
            clk <= '1';
            wait for CLOCK_PERIOD / 2;
              
    end process CLK_GEN_PROCESS;

    STIMULUS_PROCESS: process
    begin
        -- Reset
        reset <= '1';
        wait for CLOCK_PERIOD;
        reset <= '0';

        wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;

        -- Initialize
        start <= '1';
        N_i <= "00000010";
		  addr <= "00000000";
        wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;
		  wait for CLOCK_PERIOD;

        
		  

        wait;
    end process STIMULUS_PROCESS;

    DUT : entity work.MaxDiff
        port map (
				start => start,   
				--Data => Data,
				N_i => N_i,
				addr => addr,
				clk => clk,
				reset => reset, 
				
				
				debug_Diff => debug_Diff,  
				debug_data_fetched => debug_data_fetched,		
				debug_count =>   debug_count,
				done => done
        );

end TB_ARCH;