<!DOCTYPE html>
<?php
$servername = "127.0.0.1"; // Nombre/IP del servidor
$database = "dblogin"; // Nombre de la BBDD
$username = "root"; // Nombre del usuario
$password = ""; // Contraseña del usuario
// Creamos la conexión
$con = mysqli_connect($servername, $username, $password, $database);
// Comprobamos la conexión
if (!$con) {
	die("La conexión ha fallado: " . mysqli_connect_error());
}else{
		$resultado = mysqli_query( $con, "SELECT * FROM cattipopersona;" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
					print_r($resultado);
?>

<script type="text/javascript">
	//alert("Conexión satisfactoria");
</script>


<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>LOGIN PHP</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

	<!-- jQuery library -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>

	<!-- Popper JS -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>


	<!-- Librería Google Fonts-->
	
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Trirong">

</head>
<style type="text/css">
	body{
 		font-family: "Trirong", serif;
	}	

</style>
<body>
	<section id="Login" >
		<div id="banner" name = "banner">
			<ul class="nav justify-content-center">
			    <li class="nav-item">
			      <a class="nav-link" href="#">Link</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="#">Link</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="#">Link</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link disabled" href="#">Disabled</a>
			    </li>
			  </ul>
		</div>
		<div id="cuerpo" name = "cuerpo"  class="container-fluid">
			<div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">User</span>
	      </div>
	      <input type="text" class="form-control" id="usr" name="usr">
	    </div>

	    <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">Password</span>
	      </div>
	      <input type="password" class="form-control" id="psw" name="psw">
	    </div>
	      <button type="submit" class="btn btn-primary btn-lg" onclick="login();" >Ingresar</button>
			</div>
		</section>
		<section class="container" >
			<label for="sel1">Tipo de Usuario </label>
			
			<select class="form-control" id="sel1">
			    <option value>1</option>
			    <option>2</option>
			    <option>3</option>
			    <option>4</option>
			  </select>
		</section>
	<footer class="footer"></footer>
</body>
<?php
}
mysqli_close($con);
?>
<script type="text/javascript">
	var usr = document.getElementById("usr");
	let psw = document.getElementById("psw");

	function login(){
		alert("Estoy en el Login, Usuario: " + usr.value + "; Password : " + md5(psw.value));
	}
</script>
</html>