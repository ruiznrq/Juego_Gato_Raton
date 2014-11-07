LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.all;


ENTITY juegoensi IS

PORT( clk:		IN		STD_LOGIC;
		--clk_1hz:	IN		STD_LOGIC;
		sw:		IN		STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR:		OUT	STD_LOGIC_VECTOR(17 DOWNTO 0)
		);
END juegoensi;


ARCHITECTURE juegoensi_arch OF juegoensi IS

	signal pos:			integer range 0 to 17 :=0;

BEGIN

---------------------------------------------------------------------------
	process (clk)
	
		variable mov:			integer range -1 to 1 :=1;
	
	begin		
	IF (clk'event AND clk='1') THEN
	
		IF (pos=0) THEN
			IF (sw(1)='1') THEN
				mov:=0;
			ELSIF (sw(1)='0') THEN
				mov:=1;
			END IF;
			
		ELSIF (pos=17) THEN
			IF (sw(16)='1') THEN
				mov:=0;
			ELSIF (sw(16)='0') THEN
				mov:=-1;
			END IF;
			
		ELSE
			IF (sw(pos-1)='1') AND (sw(pos+1)='1') THEN
				mov:=0;
			ELSIF (sw(pos+1)='0') AND (sw(pos-1)='1') THEN
				mov:=1;
			ELSIF (sw(pos-1)='0') AND (sw(pos+1)='1') THEN
				mov:=-1;
			ELSE
				mov:=mov;
			END IF;				
		END IF;
			
		pos <= pos+mov;
			
	END IF;	
	END process;
---------------------------------------------------------------------------


---Asignacion a led (se podría hacer con rotaciones)-----------------------
	LEDR<= "000000000000000001" WHEN pos=0 ELSE
			 "000000000000000010" WHEN pos=1 ELSE
			 "000000000000000100" WHEN pos=2 ELSE
			 "000000000000001000" WHEN pos=3 ELSE
			 "000000000000010000" WHEN pos=4 ELSE
			 "000000000000100000" WHEN pos=5 ELSE
			 "000000000001000000" WHEN pos=6 ELSE
			 "000000000010000000" WHEN pos=7 ELSE
			 "000000000100000000" WHEN pos=8 ELSE
			 "000000001000000000" WHEN pos=9 ELSE
			 "000000010000000000" WHEN pos=10 ELSE
			 "000000100000000000" WHEN pos=11 ELSE
			 "000001000000000000" WHEN pos=12 ELSE
			 "000010000000000000" WHEN pos=13 ELSE
			 "000100000000000000" WHEN pos=14 ELSE
			 "001000000000000000" WHEN pos=15 ELSE
			 "010000000000000000" WHEN pos=16 ELSE
			 "100000000000000000" WHEN pos=17;
---------------------------------------------------------------------------

END ARCHITECTURE;