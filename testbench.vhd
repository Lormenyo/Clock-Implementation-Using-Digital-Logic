library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ClockTb is
end entity;
 
architecture sim of ClockTb is
    component Clock is 
        generic(ClockFrequency : integer;
        		setSeconds: integer;
        		setMinutes: integer;
        		setHours: integer);
        port(
            Clk: in std_logic;
            Rst: in std_logic;
            Seconds: inout integer;
            Minutes: inout integer;
            Hours: inout integer
    );
    end component;
 
    -- slowing down the clock to speed up simulation time
    constant ClockFrequencyHz : integer := 10; -- 10 Hz
    constant ClockPeriod      : time := 1000 ms / ClockFrequencyHz;
    constant tSeconds: integer := 0; --set seconds of clock
    constant tMinutes: integer := 30; --set minutes of clock
 	constant tHours: integer := 3;  -- set hours of clock
    
    signal Clk     : std_logic := '1';
    signal Rst    : std_logic := '0';
    signal Seconds : integer;
    signal Minutes : integer;
    signal Hours   : integer;
    

 
begin
 
    -- The Device Under Test (DUT)
    i_Timer : Clock
    generic map(ClockFrequency => ClockFrequencyHz,
    			setSeconds => tSeconds,
                setMinutes => tMinutes,
                setHours => tHours)
    port map (
      	Clk    => Clk,
        Rst    => Rst );

 
    -- Process for generating the clock
    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    process is
    begin
    
    --- the process begins with Rst => 0; this means that the seconds, minutes and hours are in set mode; Therefore the times is set to the values of tSeconds, tMinutes, tHours constants set above as 0, 30, 3 respectively.
    
    
    --the set time is maintained for 5 ns(just for demonstration purposes). In real life the clock resumes from the set time immediately.
     	wait for 5 ns; 
        
    -- the clock is then toggled to change state of signals(to keep the cloock running)
        wait until rising_edge(Clk);
        wait until rising_edge(Clk);
 
        -- The clock is then taken out of reset mode
       Rst <= '1';
        
        
        
        wait;
    end process;
 
end architecture;