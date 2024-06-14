library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity MaxDiff is
	port (
      start    : in  STD_LOGIC;
      --Data    : in  STD_LOGIC_VECTOR(7 downto 0);
		N_i : in STD_LOGIC_VECTOR (7 downto 0);
		addr : in STD_LOGIC_VECTOR (7 downto 0);
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;		
		  
      debug_Diff    : out std_logic_vector(7 downto 0);
		debug_data_fetched    : out std_logic_vector(7 downto 0);	
		debug_count   : out std_logic_vector(7 downto 0);	
		done : out STD_LOGIC
   );
end MaxDiff;
 
 
architecture Behavioral of MaxDiff is


	component DiffBehave is
		Port (
        clk     : in  std_logic;
        reset     : in  std_logic;
        init    : in  std_logic;
        Data    : in  std_logic_vector(7 downto 0);
		  
		  Diff_loaded : out STD_LOGIC;
        Diff    : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component ControlUnit is
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
	end component;
	
	component MemModule is
    
    port (
        clk         : in  std_logic;
        WEn          : in  std_logic;  
        REn          : in  std_logic;  
        Addr        : in  std_logic_vector(8-1 downto 0);
        data_in     : in  std_logic_vector(8-1 downto 0);
        data_out    : out std_logic_vector(8-1 downto 0)
    );
	end component;
	
	component DataHandler is
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
		end component;
	
	signal Diff_l, go_init  : STD_LOGIC;
	signal readB, writeB, doneB  : STD_LOGIC;
	signal count_buff, diff_buff, addr_buff : STD_LOGIC_VECTOR (7 downto 0);
	signal WEb, REb : STD_LOGIC;
	signal data_mem_Intf, data_Intf_mem, data_Diff_Intf, data_Intf_Diff : STD_LOGIC_VECTOR (7 downto 0);
   
	begin
	
		CalDiff: DiffBehave port map( clk, reset, go_init, data_Intf_Diff, Diff_l, data_Diff_Intf);
		
		Control: ControlUnit port map( start, clk, Diff_l, reset, N_i, done, count_buff, go_init, readB, writeB);
		
		Interface: DataHandler port map( clk, reset, readB, writeB, count_buff, addr, data_Diff_Intf, data_mem_Intf, data_Intf_mem, REb, WEb, addr_buff, data_Intf_Diff);
		
		Mem: MemModule port map( clk, WEb, REb, addr_buff, data_Intf_mem, data_mem_Intf);
  
		debug_count <= count_buff;
		debug_data_fetched <= data_Intf_Diff;
		debug_Diff <= data_Diff_Intf;
end Behavioral;