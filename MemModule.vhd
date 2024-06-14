library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MemModule is
    generic (
        ADDR_WIDTH : integer := 8;  
        DATA_WIDTH : integer := 8   
    );
    port (
        clk         : in  std_logic;
        WEn          : in  std_logic;  
        REn          : in  std_logic;  
        Addr        : in  std_logic_vector(8-1 downto 0);
        data_in     : in  std_logic_vector(8-1 downto 0);
        data_out    : out std_logic_vector(8-1 downto 0)
    );
end entity MemModule;

architecture Behavioral of MemModule is
    type mem_type is array (0 to 2**8-1) of std_logic_vector(8-1 downto 0);
    
    signal read_data : std_logic_vector(8-1 downto 0);
	 --signal mem : mem_type := (others => (others => '0'));
	 signal mem : mem_type := (
        0 => "00010001",  -- Initializing address 0 with 1
        1 => "00000010",  -- Initializing address 1 with 2
        2 => "00000011",  -- Initializing address 2 with 3
        3 => "00000100",  
		  4 => "00011100",
		  5 => "00000100",
		  6 => "00001100",
		  7 => "00010100",
		  8 => "01101100",
        others => (others => '0')  -- Default initialization for all other addresses
    );
	 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if WEn = '1' then
                mem(to_integer(signed(addr))) <= data_in;
            end if;
            if REn = '1' then
                read_data <= mem(to_integer(signed(addr)));
            else
                read_data <= (others => 'Z');  -- High impedance when read is disabled
            end if;
        end if;
    end process;

    data_out <= read_data;
end architecture Behavioral;