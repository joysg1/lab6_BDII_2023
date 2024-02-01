use ALMACEN

-- 1. Creacion de procedimiento almacenado para determinar si un numero es par o no

CREATE PROCEDURE VNumParImpar
@num int 
AS
BEGIN 

 IF @num %2 = 0
 BEGIN
  PRINT 'El numero ' + CAST(@num as varchar) + ' es par.'
 END
 ELSE
 BEGIN
  PRINT 'El numero ' + CAST(@num as varchar) + ' es impar.'
 END
END

exec VNumParImpar @num = 5
exec VNumParImpar @num = 2



---- 2. Realizar un procedimiento que proyecte los datos de un pais, donde al dar un codigo de un pais si se encuentra que
--- lo actualice con el que se ingrese, sino que lo inserte como un registro nuevo

--- Cree una base de datos llamada Paises_info y dentro una tabla llamada pais

CREATE DATABASE PAISES_INFO

USE PAISES_INFO




CREATE TABLE PAIS(
  nombre varchar (50),
  codigo int PRIMARY KEY,
  capital varchar(50)

);


INSERT INTO PAIS (nombre, codigo, capital)
VALUES ('Canada', '001' ,'Toronto'),
 ('Argentina', '002' ,'Buenos Aires'),
('Paraguay', '003' ,'Asuncion'),
('Uruguay', '004' ,'Montevideo')

select * from pais


CREATE PROCEDURE VerificarCodPais
    @Codigo INT,
    @Nombre VARCHAR(50),
    @Capital VARCHAR(50)
AS
BEGIN
    
    IF EXISTS (SELECT 1 FROM pais WHERE codigo = @Codigo)
    BEGIN
        
        UPDATE pais
        SET nombre = @Nombre, capital = @Capital
        WHERE codigo = @Codigo;
    END
    ELSE
    BEGIN
        
        INSERT INTO pais (codigo, nombre, capital)
        VALUES (@Codigo, @Nombre, @Capital);
    END
END;


exec VerificarCodPais @codigo = 005,  @nombre='Mexico' , @capital='Distrito_Federal'    ---- Insercion de un nuevo pais

select * from pais

exec VerificarCodPais @codigo = 005,  @nombre='Panama' , @capital='Panama'   ---- Actualizacion de datos 

select * from pais



---- 3. Usando la istruccion select con la estrucrtura case realice un script sencillo
--- muestre el dia de la semana x en letras, dado un parametro en numero
--- ejemplo si se coloca 1 indicar lunes. Adicional que diga si no se encuentra el numero
--- encontonces no existe el dia de la semana

use PAISES_INFO

CREATE PROCEDURE DiaSemana
    @numDia INT
AS
BEGIN
    DECLARE @NombreDia VARCHAR(20)

    SET @NombreDia = 
        CASE @numDia
            WHEN 1 THEN 'Lunes'
            WHEN 2 THEN 'Martes'
            WHEN 3 THEN 'Miércoles'
            WHEN 4 THEN 'Jueves'
            WHEN 5 THEN 'Viernes'
            WHEN 6 THEN 'Sábado'
            WHEN 7 THEN 'Domingo'
            ELSE 'Numero no asociado'
        END

    PRINT 'El número ' + CAST(@numDia AS VARCHAR) + ' se vincula al dia: ' + @NombreDia
END;





exec DiaSemana  @numDia = 3
exec DiaSemana  @numDia = 8




--- 4. Usando la tabla producto, cree una instruccion select con estructura case, que muestre el id del producto, la descripcion,
---- y el modelo. La respuesta del case debe mostar una columna llamada siglas donde coloque la primera letra de la descripcion.
----- Ejemplo: si es Laptop, que ponga una L y asi con los demas. 

use almacen

select * from producto

CREATE PROCEDURE ProdSiglas
AS
BEGIN
    SELECT
        IDPRODUCTO AS "ID del Producto",
        DESCRIPCCIÓN AS "Descripción",
        MODELO AS "Modelo",
        CASE
            WHEN DESCRIPCCIÓN LIKE 'LAPTOP%' THEN 'L'
            WHEN DESCRIPCCIÓN LIKE 'PANEL%' THEN 'P'
            WHEN DESCRIPCCIÓN LIKE 'SERVIDOR%' THEN 'S'
            ELSE 'Otro'
        END AS "Siglas"
    FROM Producto;
END

exec ProdSiglas



--- 5. Ejecutar los siguientes procedimientos almacenados en el sistema y observar los detalles

Sp_columns CLIENTE  --- Procedimiento que muestra las columnas dada una tabla, en este caso se usa la tabla cliente

Sp_databases --- Procedimiento del sistema que muestra las bases de datos del servidor activo 

Sp_server_info --- Procedimiento del sistema que muestra las caracteristicas de nuestro servidor activo

Sp_pkeys CLIENTE --- Procedimiento almacenado que muestra la llave primaria dada una tabla, en este caso se usa la tabla cliente 











