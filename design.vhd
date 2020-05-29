library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Clock is
generic(ClockFrequency : integer;
		setSeconds: integer;
        setMinutes: integer;
        setHours: integer);
port(
    Clk     : in std_logic;
    Rst    : in std_logic; -- Negative reset
    Seconds : inout integer;
    Minutes : inout integer;
    Hours   : inout integer);
end entity;
 
architecture behavioral of Clock is
 
    -- Signal for counting clock periods
    signal Ticks : integer;
 
begin
 
    process(Clk) is
    begin
        if rising_edge(Clk) then
 
            -- If the negative reset signal is active
            if Rst = '0' then
                Ticks   <= 0;
                Seconds <= setSeconds; --set seconds of clock to a value
                Minutes <= setMinutes;  -- set Minutes of clock to a value
                Hours   <= setHours;    -- set Hours of clock to a value
            else
 
                -- True once every second
                if Ticks = ClockFrequency - 1 then
                    Ticks <= 0;
 
                    -- True once every minute
                    if Seconds = 59 then
                        Seconds <= 0;
 
                        -- True once every hour
                        if Minutes = 59 then
                            Minutes <= 0;
 
                            -- True once a day
                            if Hours = 23 then
                                Hours <= 0;
                            else
                                Hours <= Hours + 1;
                            end if;
 
                        else
                            Minutes <= Minutes + 1;
                        end if;
 
                    else
                        Seconds <= Seconds + 1;
                    end if;
 
                else
                    Ticks <= Ticks + 1;
                end if;
 
            end if;
        end if;
    end process;
 
end architecture;