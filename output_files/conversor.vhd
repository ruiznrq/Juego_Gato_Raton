LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY conversor IS

PORT( 
		salida1:	OUT	integer range 0 to 15;
		salida2:	OUT	integer range 0 to 15;
		entrada:	IN		integer range 0 to 99
		);
END conversor;


ARCHITECTURE conversor_arch OF conversor IS

BEGIN


lsb:	salida1<= 	entrada 	  when (entrada < 10) else
						entrada-10 when (entrada < 20) else
						entrada-20 when (entrada < 30) else
						entrada-30 when (entrada < 40) else
						entrada-40 when (entrada < 50) else
						entrada-50 when (entrada < 60) else
						entrada-60 when (entrada < 70) else
						entrada-70 when (entrada < 80) else
						entrada-80 when (entrada < 90) else
						entrada-90 when (entrada < 99) else
						unaffected;
						
msb:	salida2<= 	0 when (entrada < 10) else
						1 when (entrada < 20) else
						2 when (entrada < 30) else
						3 when (entrada < 40) else
						4 when (entrada < 50) else
						5 when (entrada < 60) else
						6 when (entrada < 70) else
						7 when (entrada < 80) else
						8 when (entrada < 90) else
						9 when (entrada < 99) else
						unaffected;


END ARCHITECTURE;