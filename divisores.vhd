LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.all;


ENTITY clocks IS

PORT( clk:		IN		STD_LOGIC;
		keyMore:	IN		STD_LOGIC;
		clk_out:	OUT	STD_LOGIC;
		clk_1hz:	OUT	STD_LOGIC
		);
END clocks;


ARCHITECTURE clock_divider OF clocks IS

	signal vel:			integer range 0 to 3 			:=0;
	signal clk_s:		STD_LOGIC:='0';
	signal clk1_s:		STD_LOGIC:='0';

BEGIN

---Proceso que cambia la velocidad del raton ante pulsacion de key---------
	process (keyMore)
	begin		
		IF (keyMore'event AND keyMore='0') THEN
			IF (vel<3) THEN
				vel <= vel+1;
			ELSIF (vel=3) THEN
				vel <= 0;
			END IF;
		END IF;	
	END process;
---------------------------------------------------------------------------
	
---Proceso que divide el reloj---------------------------------------------
	process
		variable contador_1:	integer range 0 to 50000000	:=0;
		variable contador:	integer range 0 to 50000000	:=0;
	begin		
		WAIT UNTIL (clk'event AND clk='1');

		contador_1:=contador_1+1;		
		contador:=contador+1;
		
		IF (contador_1=25000000) THEN
			clk1_s<=NOT clk1_s;
			contador_1:=0;
		END IF;
		
		CASE vel IS
		WHEN 0 =>
			IF (contador=50000000) THEN
				clk_s<=NOT clk_s;
				contador:=0;
			END IF;		
		WHEN 1 =>
			IF (contador=25000000) THEN
				clk_s<=NOT clk_s;
				contador:=0;
			END IF;			
		WHEN 2 =>
			IF (contador=12500000) THEN
				clk_s<=NOT clk_s;
				contador:=0;
			END IF;			
		WHEN 3 =>
			IF (contador=6250000) THEN
				clk_s<=NOT clk_s;
				contador:=0;
			END IF;	
		END CASE;	
	
		IF (contador=50000000) THEN --Esto lo pongo porque si estamos con vel=0 con contador>250000000 y cambiamos a vel=1, nunca reiniciamos el contador. Es por "seguridad"
			contador:=0;
		END IF;	
		
	END process;
---------------------------------------------------------------------------

	clk_out<=clk_s;
	clk_1hz<=clk1_s;

END ARCHITECTURE;