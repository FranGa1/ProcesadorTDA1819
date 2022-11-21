
-- Entidad "usuario":
-- Descripci�n: Aqu� se define el banco de pruebas (testbench) con el objetivo de que 
-- el usuario pueda verificar el funcionamiento de la simulaci�n de la PC. Para ello, 
-- debe escribir previamente un programa en el lenguaje Assembler para su ensamblaje 
-- y ejecuci�n y definir las constantes generic declaradas en esta entidad para
-- especificar la arquitectura del procesador. El repertorio de instrucciones
-- soportado por esta CPU se encuentra determinado en el paquete "repert_cpu".
-- Par�metros:
-- ProgName: Contiene el nombre del programa a ser ensamblado y ejecutado por la PC.
-- El usuario debe acordarse de incluir la extensi�n ".asm" y de ubicar el archivo
-- en la carpeta "Assembler", dentro del espacio de trabajo (Workspace) del proyecto.
-- Pipelining: Determina si la CPU incluida en la PC simulada presentar� (valor "true")
-- o no (valor "false") una segmentaci�n en su cauce. Naturalmente deber�a esperarse una
-- notoria mejora en el rendimiento de un procesador segmentado respecto a uno secuencial.
-- Cores: Esta funcionalidad a�n no se encuentra implementada, por lo que el valor asignado
-- a este par�metro resulta irrelevante. No obstante, cabe mencionar que aqu� se estar�a
-- definiendo la cantidad de n�cleos que posee la arquitectura multi-core.
-- Procesos:
-- Main: Su funci�n es habilitar el ensamblador de la PC para que comience a llevar a cabo
-- su tarea. Una vez completada, procede a recibir la se�al de finalizaci�n del ensamblaje
-- para informar este evento al usuario. Un fen�meno similar ocurre con la ejecuci�n 
-- propiamente dicha del programa: cuando la CPU termina su trabajo, env�a una nueva se�al 
-- a este proceso para que el mismo realice al usuario la notificaci�n correspondiente.


library TDA_1819;
use TDA_1819.tipos_ensamblador.all;


library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;
library std;
use std.TEXTIO.all;

	-- Add your library and packages declaration here ...

entity usuario is
	-- Generic declarations of the tested unit
	generic (
		ProgName	: STRING := "ejercicio3.asm";
		Pipelining	: BOOLEAN := true;
		Cores 		: INTEGER := 1);  	
			
end usuario;

architecture USUARIO_ARCHITECTURE of usuario is
	
	-- Component declaration of the tested unit
	component pc
		generic (
			ProgName		: STRING;
			Pipelining 		: BOOLEAN;
			Cores 			: INTEGER);
		port (
			DoneCompUser	: out std_logic;
			DoneCpuUser		: out std_logic;
			ReadyUser		: in  std_logic);
	end component;
	
	FOR UUT: pc USE ENTITY WORK.pc(pc_architecture);
	
	-- Add your code here ...
	
	SIGNAL DoneCompUser:	std_logic;
	SIGNAL DoneCpuUser:		std_logic;
	SIGNAL ReadyUser:		std_logic;
	

begin
	
	
	-- Unit Under Test port map
	UUT : pc
		generic map (
			ProgName 		=> ProgName,
			Pipelining 		=> Pipelining,
			Cores 			=> Cores
		)
		port map ( 
			DoneCompUser 	=> DoneCompUser,
			DoneCpuUser 	=> DoneCpuUser,
			ReadyUser 		=> ReadyUser
		);
	
	-- Add your stimulus here ...
	
	Main: PROCESS

	BEGIN 
		ReadyUser <= '0';
		WAIT FOR 1 ns;
		ReadyUser <= '1';
		WAIT UNTIL rising_edge(DoneCompUser);
		report "El programa 'Assembler/" & ProgName & "' ha sido ensamblado exitosamente"
		severity WARNING;
		WAIT UNTIL rising_edge(DoneCpuUser);
		report "El programa 'Assembler/" & ProgName & "' ha sido ejecutado exitosamente"
		severity WARNING;
		WAIT;
	END PROCESS Main;


end USUARIO_ARCHITECTURE;



