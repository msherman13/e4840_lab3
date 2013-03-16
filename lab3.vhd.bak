library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab3 is  
  port (
    signal CLOCK_50 : in std_logic; -- 50 MHz
    signal LEDR : out std_logic_vector(17 downto 0); -- LEDs

    SRAM_DQ : inout std_logic_vector(15 downto 0);
    SRAM_ADDR : out std_logic_vector(17 downto 0);
    SRAM_UB_N,            -- High-byte Data Mask
    SRAM_LB_N,            -- Low-byte Data Mask
    SRAM_WE_N,            -- Write Enable
    SRAM_CE_N,            -- Chip Enable
    SRAM_OE_N : out std_logic  -- Output Enable
    );  
end lab3;

architecture rtl of lab3 is
  signal counter : unsigned(15 downto 0);
  signal reset_n : std_logic;
begin

  LEDR(17) <= '1';
  LEDR(16) <= '1';

  process (CLOCK_50)
  begin
    if rising_edge(CLOCK_50) then
      if counter = x"ffff" then
        reset_n <= '1';
      else
        reset_n <= '0';
        counter <= counter + 1;
      end if;
    end if;
  end process;

  nios : entity work.nios_system port map (
    clk_0                         => CLOCK_50,
    reset_n                      => reset_n,
    leds_from_the_leds       => LEDR(15 downto 0),
    SRAM_ADDR_from_the_sram      => SRAM_ADDR,
    SRAM_CE_N_from_the_sram      => SRAM_CE_N,
    SRAM_DQ_to_and_from_the_sram => SRAM_DQ,
    SRAM_LB_N_from_the_sram      => SRAM_LB_N,
    SRAM_OE_N_from_the_sram      => SRAM_OE_N,
    SRAM_UB_N_from_the_sram      => SRAM_UB_N,
    SRAM_WE_N_from_the_sram      => SRAM_WE_N
    );

end rtl;
