library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DiffBehave is
    Port (
        clk     : in  std_logic;
        reset     : in  std_logic;
        init    : in  std_logic;
        Data    : in  std_logic_vector(7 downto 0);
		  
		  --Diff_loaded : out STD_LOGIC;
        Diff    : out std_logic_vector(7 downto 0)
    );
end DiffBehave;

architecture Behavioral of DiffBehave is
    signal min : signed(7 downto 0) := (others => '0');
    signal max : signed(7 downto 0) := (others => '0');
	 signal init_reg : STD_LOGIC := '0';
	 --signal d_reg : std_logic_vector(7 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            min <= (others => '0');
            max <= (others => '0');
				--d_reg <= (others => '0');
				--Diff_loaded <= '0';
        elsif rising_edge(clk) then
				--d_reg <= Data;
				--init_reg <= init;
            if init = '1' then
                min <= signed(data);
                max <= signed(data);
					 --Diff_loaded <= '1';
            else
                if signed(Data) > max then 
                    max <= signed(Data);
					 end if;
                if signed(Data) < min then
                    min <= signed(Data);
                end if;            
            end if;
        end if;
    end process;
    Diff <= std_logic_vector(max - min);
end Behavioral;
