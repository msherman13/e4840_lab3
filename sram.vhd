-- sram.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sram is
	port (
		write      : in    std_logic                     := '0';             -- avalon_slave_0.write
		read       : in    std_logic                     := '0';             --               .read
		address    : in    std_logic_vector(17 downto 0) := (others => '0'); --               .address
		writedata  : in    std_logic_vector(15 downto 0) := (others => '0'); --               .writedata
		readdata   : out   std_logic_vector(15 downto 0);                    --               .readdata
		byteenable : in    std_logic_vector(1 downto 0)  := (others => '0'); --               .byteenable
		chipselect : in    std_logic                     := '0';             --               .chipselect
		SRAM_ADDR  : out   std_logic_vector(17 downto 0);                    --    conduit_end.export
		SRAM_DQ    : inout std_logic_vector(15 downto 0) := (others => '0'); --               .export
		SRAM_UB_N  : out   std_logic;                                        --               .export
		SRAM_LB_N  : out   std_logic;                                        --               .export
		SRAM_WE_N  : out   std_logic;                                        --               .export
		SRAM_CE_N  : out   std_logic;                                        --               .export
		SRAM_OE_N  : out   std_logic                                         --               .export
	);
end entity sram;

architecture rtl of sram is
	component de2_sram_controller is
		port (
			write      : in    std_logic                     := 'X';             -- write
			read       : in    std_logic                     := 'X';             -- read
			address    : in    std_logic_vector(17 downto 0) := (others => 'X'); -- address
			writedata  : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			readdata   : out   std_logic_vector(15 downto 0);                    -- readdata
			byteenable : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			chipselect : in    std_logic                     := 'X';             -- chipselect
			SRAM_ADDR  : out   std_logic_vector(17 downto 0);                    -- export
			SRAM_DQ    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
			SRAM_UB_N  : out   std_logic;                                        -- export
			SRAM_LB_N  : out   std_logic;                                        -- export
			SRAM_WE_N  : out   std_logic;                                        -- export
			SRAM_CE_N  : out   std_logic;                                        -- export
			SRAM_OE_N  : out   std_logic                                         -- export
		);
	end component de2_sram_controller;

begin

	sram : component de2_sram_controller
		port map (
			write      => write,      -- avalon_slave_0.write
			read       => read,       --               .read
			address    => address,    --               .address
			writedata  => writedata,  --               .writedata
			readdata   => readdata,   --               .readdata
			byteenable => byteenable, --               .byteenable
			chipselect => chipselect, --               .chipselect
			SRAM_ADDR  => SRAM_ADDR,  --    conduit_end.export
			SRAM_DQ    => SRAM_DQ,    --               .export
			SRAM_UB_N  => SRAM_UB_N,  --               .export
			SRAM_LB_N  => SRAM_LB_N,  --               .export
			SRAM_WE_N  => SRAM_WE_N,  --               .export
			SRAM_CE_N  => SRAM_CE_N,  --               .export
			SRAM_OE_N  => SRAM_OE_N   --               .export
		);

end architecture rtl; -- of sram
