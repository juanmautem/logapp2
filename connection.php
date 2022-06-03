<?php
function connect(){
	$servername = "127.0.0.1"; // Nombre/IP del servidor
	$database = "dblogin_2"; // Nombre de la BBDD
	$username = "root"; // Nombre del usuario
	$password = ""; // Contraseña del usuario
	// Creamos la conexión
	$con = mysqli_connect($servername, $username, $password, $database);
	// Comprobamos la conexión
		if (!$con) {
			die("La conexión ha fallado: " . mysqli_connect_error());
		}

	return $con;
}

	
	function types(){
		$con = connect();
		$res1 = array();
        //$resultado = mysqli_query( $con, "SELECT * FROM cattipopersona;" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
        $resultado = mysqli_query( $con, "SELECT * FROM allTypes;" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
		while($res = mysqli_fetch_array($resultado)){
	    	array_push($res1, $res);
		}
	    /* liberar el conjunto de resultados */
    	mysqli_free_result($resultado);

    	mysqli_close($con);
    	return json_encode($res1);
	}

  function allUsers(){
    $con = connect();
    $res1 = array();
    $resultado = mysqli_query( $con, "SELECT * FROM vwusersdata;" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
    while($res = mysqli_fetch_array($resultado)){
      array_push($res1, $res);
    }
    /* liberar el conjunto de resultados */
    mysqli_free_result($resultado);

    mysqli_close($con);
    return json_encode($res1);
  }



?>