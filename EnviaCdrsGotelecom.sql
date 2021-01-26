
ALTER PROCEDURE [dbo].[EnviaCdrsGotelecom] 
AS
BEGIN

declare @fichero varchar (150)
declare @ficheroM varchar (150)
declare @registros varchar(9)
declare @sql varchar(max)
declare @ruta_destino varchar(200)
declare @SQLString varchar(5000)
declare @FechaIni varchar(8)
declare @FechaFin varchar(8)

set @FechaFin=(select convert(varchar,dateadd(day,-day(getdate()),getdate()),112))
set @FechaIni=left(@FechaFin,6)+'01'

set @fichero='D:\GOTELECOM\CDRS_337532_'+@FechaIni+'_'+ @FechaFin
set @ficheroM='D:\GOTELECOM\CDRS_M169698_'+@FechaIni+'_'+ @FechaFin

IF OBJECT_ID ('nfac.dbo.vista_gotelecom', 'view') IS NOT NULL
	begin
		DROP VIEW vista_gotelecom 
	end
	-- La primera consulta es la cabecera
	set @sql='Create view dbo.vista_gotelecom as  '
	set @sql = @sql +' select Calling_Number, Fecha, Hora_Con, Charged_Time, Chart_Time_Sec, Destino_Detalle, Original_Dialed, precio_Fact'
	set @sql = @sql +'		from  cdrs_202011..cdrs_01_telefonia_fija where cliente_fact=''337532'''-- and order by Fecha,Hora_Con'
							
	--print @sql
	exec (@sql)

	--Generamos el fichero
	set @SQLString= '  bcp "select * from nfac..vista_gotelecom " '
	SET @SQLString = @SQLString + ' queryout ' + @fichero + '.xls -c  -T -C ACP'
	exec  master..xp_cmdshell @SQLString--,no_output 
	
	-- Comprimimos el fichero en .zip 
	set @SQLString ='7z a -tzip -mx1 ' + @fichero + '.zip '+ @fichero +'.xls'
	exec master..xp_cmdshell @SQLString --,no_output 

	--Lo mandamos por FTP
	--Ejecuta el archivo ejecuta_337532_ftp.bat para hacer subir los ficheros por FTP
	set @SQLString = 'D:\GOTELECOM\EnviadosM169698\CDRS_337532_'+@FechaIni+'_'+@FechaFin+'.xls'
	exec  master..xp_cmdshell @SQLString
	
	set @ruta_destino='D:\GOTELECOM\Enviados337532\finalFtp'
	-- Muevo el archivo a BAK
	set @SQLString= 'move '+ @fichero +'.xls '+@ruta_destino
	exec  master..xp_cmdshell @SQLString
	
	
	
	
	IF OBJECT_ID ('nfac.dbo.vista_gotelecomM', 'view') IS NOT NULL
	begin
		DROP VIEW vista_gotelecomM 
	end
	-- La primera consulta es la cabecera
	set @sql='Create view dbo.vista_gotelecomM as  '
	set @sql = @sql +' select Calling_Number, Fecha, Hora_Con, Charged_Time, Chart_Time_Sec, Destino_Detalle, Original_Dialed, precio_Fact'
	set @sql = @sql +'		from  cdrs_202011..cdrs_05_telefonia_movil where cliente_fact=''M169698'''
							
	--print @sql
	exec (@sql)

	--Generamos el ficheroM
	set @SQLString= '  bcp "select * from nfac..vista_gotelecomM " '
	SET @SQLString = @SQLString + ' queryout ' + @ficheroM + '.xls -c  -T -C ACP'
	exec  master..xp_cmdshell @SQLString--,no_output 
	
	-- Comprimimos el ficheroM en .zip 
	set @SQLString ='7z a -tzip -mx1 ' + @ficheroM + '.zip '+ @ficheroM +'.xls'
	exec master..xp_cmdshell @SQLString --,no_output 

	--Lo mandamos por FTP
	--Ejecuta el archivo ejecuta_337532_ftp.bat para hacer subir los ficheros por FTP
	set @SQLString = 'D:\GOTELECOM\EnviadosM169698\CDRS_M169698_'+@FechaIni+'_'+ @FechaFin+'.xls'
	exec  master..xp_cmdshell @SQLString
	
	set @ruta_destino='D:\GOTELECOM\EnviadosM169698\finalFtp'
	-- Muevo el archivo a BAK
	set @SQLString= 'move '+ @ficheroM +'.xls '+@ruta_destino
	exec  master..xp_cmdshell @SQLString

	
END

GO



*********************Opcion1(EstaOkUsala)*********************************************************

ALTER PROCEDURE [dbo].[EnviaCdrsGotelecom] 
AS
BEGIN

declare @fichero varchar (150)
declare @ficheroM varchar (150)
declare @registros varchar(9)
declare @sql varchar(max)
declare @ruta_destino varchar(200)
declare @SQLString varchar(5000)
declare @FechaIni varchar(8)
declare @FechaFin varchar(8)

set @FechaFin=(select convert(varchar,dateadd(day,-day(getdate()),getdate()),112))
set @FechaIni=left(@FechaFin,6)+'01'

set @fichero='D:\GOTELECOM\CDRS_337532_'+@FechaIni+'_'+ @FechaFin
set @ficheroM='D:\GOTELECOM\CDRS_M169698_'+@FechaIni+'_'+ @FechaFin

IF OBJECT_ID ('nfac.dbo.vista_gotelecom', 'view') IS NOT NULL
	begin
		DROP VIEW vista_gotelecom 
	end
	-- La primera consulta es la cabecera
	set @sql='Create view dbo.vista_gotelecom as  '
	set @sql = @sql +' select Calling_Number, Fecha, Hora_Con, Charged_Time, Chart_Time_Sec, Destino_Detalle, Original_Dialed, precio_Fact'
	set @sql = @sql +'		from  cdrs_202011..cdrs_01_telefonia_fija where cliente_fact=''337532'''-- and order by Fecha,Hora_Con'
							
	--print @sql
	exec (@sql)

	--Generamos el fichero
	set @SQLString= '  bcp "select * from nfac..vista_gotelecom " '
	SET @SQLString = @SQLString + ' queryout ' + @fichero + '.xls -c  -T -C ACP'
	exec  master..xp_cmdshell @SQLString--,no_output 
	
	-- Comprimimos el fichero en .zip 
	set @SQLString ='7z a -tzip -mx1 ' + @fichero + '.zip '+ @fichero +'.xls'
	exec master..xp_cmdshell @SQLString --,no_output 

	--Lo mandamos por FTP
	--Ejecuta el archivo ejecuta_337532_ftp.bat para hacer subir los ficheros por FTP
	set @SQLString = 'D:\GOTELECOM\Enviados337532\ejecuta_337532_ftp.bat '
	exec  master..xp_cmdshell @SQLString
	
	set @ruta_destino='D:\GOTELECOM\Enviados337532\finalFtp'
	-- Muevo el archivo a BAK
	set @SQLString= 'move '+ @fichero +'.xls '+@ruta_destino
	exec  master..xp_cmdshell @SQLString
	
	
	
	
	IF OBJECT_ID ('nfac.dbo.vista_gotelecomM', 'view') IS NOT NULL
	begin
		DROP VIEW vista_gotelecomM 
	end
	-- La primera consulta es la cabecera
	set @sql='Create view dbo.vista_gotelecomM as  '
	set @sql = @sql +' select Calling_Number, Fecha, Hora_Con, Charged_Time, Chart_Time_Sec, Destino_Detalle, Original_Dialed, precio_Fact'
	set @sql = @sql +'		from  cdrs_202011..cdrs_05_telefonia_movil where cliente_fact=''M169698'''
							
	--print @sql
	exec (@sql)

	--Generamos el ficheroM
	set @SQLString= '  bcp "select * from nfac..vista_gotelecomM " '
	SET @SQLString = @SQLString + ' queryout ' + @ficheroM + '.xls -c  -T -C ACP'
	exec  master..xp_cmdshell @SQLString--,no_output 
	
	-- Comprimimos el ficheroM en .zip 
	set @SQLString ='7z a -tzip -mx1 ' + @ficheroM + '.zip '+ @ficheroM +'.xls'
	exec master..xp_cmdshell @SQLString --,no_output 

	--Lo mandamos por FTP
	--Ejecuta el archivo ejecuta_337532_ftp.bat para hacer subir los ficheros por FTP
	set @SQLString = 'D:\GOTELECOM\EnviadosM169698\ejecuta_M169698_ftp.bat '
	exec  master..xp_cmdshell @SQLString
	
	set @ruta_destino='D:\GOTELECOM\EnviadosM169698\finalFtp'
	-- Muevo el archivo a BAK
	set @SQLString= 'move '+ @ficheroM +'.xls '+@ruta_destino
	exec  master..xp_cmdshell @SQLString

	
END

GO


************************************2da posible*******************************************

ALTER PROCEDURE [dbo].[EnviaCdrsGotelecom] 
AS
BEGIN

declare @fichero varchar (150)
declare @ficheroM varchar (150)
declare @registros varchar(9)
declare @sql varchar(max)
declare @ruta_destino varchar(200)
declare @SQLString varchar(5000)
declare @FechaIni varchar(8)
declare @FechaFin varchar(8)

set @FechaIni='20201101'
set @FechaFin='20201130'

set @fichero='\\10.134.16.161\D$\Gotelecom\CDRS_337532_'+@FechaIni+'_'+ @FechaFin
set @ficheroM='\\10.134.16.161\D$\Gotelecom\CDRS_M169698_'+@FechaIni+'_'+ @FechaFin

IF OBJECT_ID ('nfac.dbo.vista_gotelecom', 'view') IS NOT NULL
	begin
		DROP VIEW vista_gotelecom 
	end
	-- La primera consulta es la cabecera
	set @sql='Create view dbo.vista_gotelecom as  '
	set @sql = @sql +' select Calling_Number, Fecha, Hora_Con, Charged_Time, Chart_Time_Sec, Destino_Detalle, Original_Dialed, precio_Fact'
	set @sql = @sql +'		from  cdrs_202011..cdrs_01_telefonia_fija where cliente_fact=''337532'''-- and order by Fecha,Hora_Con'
							
	--print @sql
	exec (@sql)

	--Generamos el fichero
	set @SQLString= '  bcp "select * from nfac..vista_gotelecom " '
	SET @SQLString = @SQLString + ' queryout ' + @fichero + '.csv -c  -T -C ACP'
	exec  master..xp_cmdshell @SQLString--,no_output 
	
	-- Comprimimos el fichero en .zip 
	set @SQLString ='7z a -tzip -mx1 ' + @fichero + '.zip '+ @fichero +'.csv'
	exec master..xp_cmdshell @SQLString --,no_output 

	--Lo mandamos por FTP
	--Ejecuta el archivo ejecuta_337532_ftp.bat para hacer subir los ficheros por FTP
	set @SQLString = '\\10.134.16.161\D$\Gotelecom\ejecuta_337532_ftp.bat '
	--exec  master..xp_cmdshell @SQLString
	
	set @ruta_destino='\\10.134.16.161\D$\Gotelecom\Enviados'
	-- Muevo el archivo a BAK
	set @SQLString= 'move '+ @fichero +'.csv '+@ruta_destino
	exec  master..xp_cmdshell @SQLString
	

	-- La valida la existencia de la vista
	IF OBJECT_ID ('nfac.dbo.vista_gotelecomM', 'view') IS NOT NULL
	begin
		DROP VIEW vista_gotelecomM 
	end
	-- La primera consulta es la cabecera
	set @sql='Create view dbo.vista_gotelecomM as  '
	set @sql = @sql +' select Calling_Number, Fecha, Hora_Con, Charged_Time, Chart_Time_Sec, Destino_Detalle, Original_Dialed, precio_Fact'
	set @sql = @sql +'		from  cdrs_202011..cdrs_05_telefonia_movil where cliente_fact=''M169698'''
							
	--print @sql
	exec (@sql)

	--Generamos el ficheroM
	set @SQLString= '  bcp "select * from nfac..vista_gotelecomM " '
	SET @SQLString = @SQLString + ' queryout ' + @ficheroM + '.csv -c  -T -C ACP'
	exec  master..xp_cmdshell @SQLString--,no_output 
	
	-- Comprimimos el ficheroM en .zip 
	set @SQLString ='7z a -tzip -mx1 ' + @ficheroM + '.zip '+ @ficheroM +'.csv'
	exec master..xp_cmdshell @SQLString --,no_output 

	--Lo mandamos por FTP
	--Ejecuta el archivo ejecuta_337532_ftp.bat para hacer subir los ficheros por FTP
	set @SQLString = '\\10.134.16.161\D$\Gotelecom\ejecuta_M169698_ftp.bat '
	--exec  master..xp_cmdshell @SQLString
	
	set @ruta_destino='\\10.134.16.161\D$\Gotelecom\Enviados'
	-- Muevo el archivo a BAK
	set @SQLString= 'move '+ @ficheroM +'.csv '+@ruta_destino
	exec  master..xp_cmdshell @SQLString

	
END

GO



