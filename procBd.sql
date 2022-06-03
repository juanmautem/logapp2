DELIMITER $
CREATE PROCEDURE proAddNwUser 
(nombre VARCHAR(30), apellidos VARCHAR(70), 
	rfc VARCHAR(15), idT INT, NickName VARCHAR(21), 
	Psw VARCHAR(50)) 
	BEGIN 
		INSERT INTO catpersonas(txtNombre, txtApellidos, txtRFC) 
		VALUES (nombre, apellidos, rfc); 
		SELECT MAX(nIdPersona) INTO @idP FROM catpersonas; 
		INSERT INTO relusuario (fk_eIdPersona, fk_eIdTipoP, txtNombreCorto, txtPassword)
		VALUES (@idP,idT,NickName,MD5(Psw));
	END$