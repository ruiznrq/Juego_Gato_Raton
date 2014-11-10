LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.all;


ENTITY juegoensi IS

PORT( clk:		IN		STD_LOGIC;
		clk_1hz:	IN		STD_LOGIC;
		clk_10hz:	IN		STD_LOGIC;
		restart:	IN		STD_LOGIC;
		prueba:	OUT		STD_LOGIC;
		sw:		IN		STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR:		OUT	STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDG:		OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		suma:		OUT	INTEGER range 0 to 99
		);
END juegoensi;


ARCHITECTURE juegoensi_arch OF juegoensi IS

	signal pos:			integer range 0 to 17 :=0;
	signal running:   STD_LOGIC  :='0'; -- 0==pausado y 1==jugando
	signal parpadeo:	STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal suma_s:		integer range 0 to 99 :=0;
	signal SW_old: 	std_logic_vector (17 downto 0):="000000000000000000";
	signal nada:		std_logic :='0';

BEGIN


---Proceso que elige la posición del ratón---------------------------------
	process (clk, restart)
	
		variable mov:			integer range -1 to 1 :=1;
	
	begin	
	
	IF (restart='0') THEN
		IF ((running = '0') AND (sw="000000000000000000")) THEN
			running <= '1';
		END IF;		
	
	ELSIF ((clk'event AND clk='1') AND (running='1')) THEN
	
		IF (pos=0) THEN
			IF (sw(1)='1') THEN
				mov:=0;
				running<= '0';	
			ELSIF (sw(1)='0') THEN
				mov:=1;
			END IF;
			
		ELSIF (pos=17) THEN
			IF (sw(16)='1') THEN
				mov:=0;
				running<= '0';	
			ELSIF (sw(16)='0') THEN
				mov:=-1;
			END IF;
			
		ELSE
			IF (sw(pos-1)='1') AND (sw(pos+1)='1') THEN
				mov:=0;
				running<= '0';									------NO SE PUEDE ASIGNAR A UNA SEÑAL UN VALOR EN DOS PROCESOS, PENSAR --> truco XD, igual funcionaria con integer...
			ELSIF (sw(pos+1)='0') AND (sw(pos-1)='1') THEN
				mov:=1;
			ELSIF (sw(pos-1)='0') AND (sw(pos+1)='1') THEN
				mov:=-1;
			ELSE
				IF mov=0 THEN
					mov:=1;
				ELSE
					mov:=mov;
				END IF;
			END IF;				
		END IF;
			
		pos <= pos+mov;
			
	END IF;	
	END process;
---------------------------------------------------------------------------

---Asignacion a led (se podría hacer con rotaciones)-----------------------
	LEDR<= "000000000000000001" WHEN ((pos=0)) ELSE
			 "000000000000000010" WHEN ((pos=1)) ELSE
			 "000000000000000100" WHEN ((pos=2)) ELSE
			 "000000000000001000" WHEN ((pos=3)) ELSE
			 "000000000000010000" WHEN ((pos=4)) ELSE
			 "000000000000100000" WHEN ((pos=5)) ELSE
			 "000000000001000000" WHEN ((pos=6)) ELSE
			 "000000000010000000" WHEN ((pos=7)) ELSE
			 "000000000100000000" WHEN ((pos=8)) ELSE
			 "000000001000000000" WHEN ((pos=9)) ELSE
			 "000000010000000000" WHEN ((pos=10)) ELSE
			 "000000100000000000" WHEN ((pos=11)) ELSE
			 "000001000000000000" WHEN ((pos=12)) ELSE
			 "000010000000000000" WHEN ((pos=13)) ELSE
			 "000100000000000000" WHEN ((pos=14)) ELSE
			 "001000000000000000" WHEN ((pos=15)) ELSE
			 "010000000000000000" WHEN ((pos=16)) ELSE
			 "100000000000000000" WHEN ((pos=17));
---------------------------------------------------------------------------

			 
---Cuando ganas, los leds verdes parpadean---------------------------------
	process (clk_1hz)	
	begin		
		IF ((clk_1hz'event AND clk_1hz='1')) THEN	
			parpadeo <= NOT parpadeo;			
		END IF;	
	END process;
	
	LEDG<= "00000000" WHEN ((running='1')) ELSE
			 parpadeo   WHEN ((running='0'));
---------------------------------------------------------------------------

	--process (sw(0), sw(1), sw(2), sw(3), sw(4), sw(5), sw(6), sw(7), sw(8), sw(9), sw(10), sw(11), sw(12), sw(13), sw(14), sw(15), sw(16), sw(17))
	process (clk_10hz)
	begin
	--wait until (nada = '1') for 100 ms;
	--wait until (not(sw=SW_old)) for 100 ms;
		IF (clk_10hz'event AND clk_10hz='1') THEN
			IF (sw_old=sw) THEN
				sw_old<=sw;
				IF (running = '1') THEN
					suma_s <= suma_s + 1;
					prueba<='1';
				ELSIF (running ='0') OR (suma_s=99) THEN
					suma_s <= 0;
					prueba <= '0';
				END IF;
			END IF;
				--nada <= '0';
		END IF;
	END process;

	suma<= 0 WHEN ((running='0')) ELSE
			   suma_s   WHEN ((running='1'));	

END ARCHITECTURE;