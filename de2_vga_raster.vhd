-------------------------------------------------------------------------------
--
-- Simple VGA raster display
--
-- Stephen A. Edwards
-- sedwards@cs.columbia.edu
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de2_vga_raster is
  
  port (
    reset : in std_logic;
    clk   : in std_logic;                    -- Should be 25.125 MHz
	 MidpointXpin : in std_logic_vector (10 downto 0);
	 MidpointYpin : in std_logic_vector (10 downto 0);
    VGA_CLK,                         -- Clock
    VGA_HS,                          -- H_SYNC
    VGA_VS,                          -- V_SYNC
    VGA_BLANK,                       -- BLANK
    VGA_SYNC : out std_logic;        -- SYNC
    VGA_Rpin,                           -- Red[9:0]
    VGA_Gpin,                           -- Green[9:0]
    VGA_Bpin : out std_logic_vector (9 downto 0) -- Blue[9:0]
    );

end de2_vga_raster;

architecture rtl of de2_vga_raster is
  
  -- Video parameters
  
  constant HTOTAL       : integer := 800;
  constant HSYNC        : integer := 96;
  constant HBACK_PORCH  : integer := 48;
  constant HACTIVE      : integer := 640;
  constant HFRONT_PORCH : integer := 16;
  
  constant VTOTAL       : integer := 525;
  constant VSYNC        : integer := 2;
  constant VBACK_PORCH  : integer := 33;
  constant VACTIVE      : integer := 480;
  constant VFRONT_PORCH : integer := 10;

  constant RECTANGLE_HSTART : integer := 295;
  constant RECTANGLE_HEND   : integer := 345;
  constant RECTANGLE_VSTART : integer := 215;
  constant RECTANGLE_VEND   : integer := 265;
  
  constant CIRCLE_RADIUS : integer := 25;

  -- Signals for the video controller
  signal Hcount : signed(10 downto 0);  -- Horizontal position (0-800)
  signal Vcount : signed(10 downto 0);  -- Vertical position (0-524)
  signal EndOfLine, EndOfField : std_logic;
  signal CircleX, CircleY, CircleRadiusSignal : signed (10 downto 0);
  signal CircleRadiussq : signed (21 downto 0);
  signal Hsigned, Vsigned : signed (10 downto 0);
  signal Hcountsq, Vcountsq : signed (21 downto 0);
  signal MidpointX, MidpointY : signed (10 downto 0);
  signal VGA_R : unsigned (9 downto 0);
  signal VGA_G : unsigned (9 downto 0);
  signal VGA_B : unsigned (9 downto 0);

  
  signal vga_hblank, vga_hsync,
    vga_vblank, vga_vsync : std_logic;  -- Sync. signals

  signal rectangle_h, rectangle_v, rectangle : std_logic;  -- rectangle area

begin
  -- Horizontal and vertical counters
  
  MidpointX <= signed(MidpointXpin);
  MidpointY <= signed(MidpointYpin);

  HCounter : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        Hcount <= (others => '0');
      elsif EndOfLine = '1' then
        Hcount <= (others => '0');
      else
        Hcount <= Hcount + 1;
      end if;      
    end if;
  end process HCounter;

  EndOfLine <= '1' when Hcount = HTOTAL - 1 else '0';
  
  VCounter: process (clk)
  begin
    if rising_edge(clk) then      
      if reset = '1' then
        Vcount <= (others => '0');
      elsif EndOfLine = '1' then
        if EndOfField = '1' then
          Vcount <= (others => '0');
        else
          Vcount <= Vcount + 1;
        end if;
      end if;
    end if;
  end process VCounter;

  EndOfField <= '1' when Vcount = VTOTAL - 1 else '0';

  -- State machines to generate HSYNC, VSYNC, HBLANK, and VBLANK

  HSyncGen : process (clk)
  begin
    if rising_edge(clk) then     
      if reset = '1' or EndOfLine = '1' then
        vga_hsync <= '1';
      elsif Hcount = HSYNC - 1 then
        vga_hsync <= '0';
      end if;
    end if;
  end process HSyncGen;
  
  HBlankGen : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        vga_hblank <= '1';
      elsif Hcount = HSYNC + HBACK_PORCH then
        vga_hblank <= '0';
      elsif Hcount = HSYNC + HBACK_PORCH + HACTIVE then
        vga_hblank <= '1';
      end if;      
    end if;
  end process HBlankGen;

  VSyncGen : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        vga_vsync <= '1';
      elsif EndOfLine ='1' then
        if EndOfField = '1' then
          vga_vsync <= '1';
        elsif Vcount = VSYNC - 1 then
          vga_vsync <= '0';
        end if;
      end if;      
    end if;
  end process VSyncGen;

  VBlankGen : process (clk)
  begin
    if rising_edge(clk) then    
      if reset = '1' then
        vga_vblank <= '1';
      elsif EndOfLine = '1' then
        if Vcount = VSYNC + VBACK_PORCH - 1 then
          vga_vblank <= '0';
        elsif Vcount = VSYNC + VBACK_PORCH + VACTIVE - 1 then
          vga_vblank <= '1';
        end if;
      end if;
    end if;
  end process VBlankGen;

  -- Rectangle generator.

Hsigned <= Hcount - MidpointX;
Vsigned <= Vcount - MidpointY;
Hcountsq <= Hsigned * Hsigned;
Vcountsq <= Vsigned * Vsigned;
CircleRadiusSignal <= "00000011001";
CircleRadiussq <= CircleRadiusSignal * CircleRadiusSignal;

  RectangleHGen : process (clk)
  begin
    if rising_edge(clk) then     
		if reset = '1' or CircleRadiussq >= Hcountsq + Vcountsq then
        rectangle_h <= '1';
		else
        rectangle_h <= '0';
      end if;      
    end if;
  end process RectangleHGen;

--  RectangleVGen : process (clk)
--  begin
--    if rising_edge(clk) then
--      if reset = '1' then       
--        rectangle_v <= '0';
--      elsif EndOfLine = '1' then
--        if Vcount = VSYNC + VBACK_PORCH - 1 + RECTANGLE_VSTART then
--          rectangle_v <= '1';
--        elsif Vcount = VSYNC + VBACK_PORCH - 1 + RECTANGLE_VEND then
--          rectangle_v <= '0';
--        end if;
--      end if;      
--    end if;
--  end process RectangleVGen;

  --rectangle <= rectangle_h and rectangle_v;
  rectangle <= rectangle_h;

  -- Registered video signals going to the video DAC

  VideoOut: process (clk, reset)
  begin
    if reset = '1' then
      VGA_R <= "0000000000";
      VGA_G <= "0000000000";
      VGA_B <= "0000000000";
    elsif clk'event and clk = '1' then
      if rectangle = '1' then
        VGA_R <= "1111111111";
        VGA_G <= "1111111111";
        VGA_B <= "1111111111";
      elsif vga_hblank = '0' and vga_vblank ='0' then
        VGA_R <= "0000000000";
        VGA_G <= "0100101100";
        VGA_B <= "0100101100";
      else
        VGA_R <= "0000000000";
        VGA_G <= "0000000000";
        VGA_B <= "0000000000";    
      end if;
    end if;
	VGA_Rpin <= std_logic_vector(VGA_R);
  VGA_Gpin <= std_logic_vector(VGA_G);
  VGA_Bpin <= std_logic_vector(VGA_B);

  end process VideoOut;

  VGA_CLK <= clk;
  VGA_HS <= not vga_hsync;
  VGA_VS <= not vga_vsync;
  VGA_SYNC <= '0';
  VGA_BLANK <= not (vga_hsync or vga_vsync);

end rtl;
