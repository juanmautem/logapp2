<!DOCTYPE html>
<?php
session_destroy();
	include 'connection.php';
	
?>



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

    <!-- Librería Bootstrap 4 Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

    <!-- Librería Google Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Trirong">

    <!-- Librería AJAX -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="functions.js" language="Javascript"></script> 

</head>
<style type="text/css">
	body{
 		font-family: "Trirong", serif;
	}	

</style>
<body>
	<section id="menu">
		<div id="banner" name = "banner">
			<ul class="nav justify-content-center">
			    <li class="nav-item">
			      <a class="nav-link" href="#" onclick="activateN();">Home</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="#" onclick="activateL();">LogIn</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="#" onclick="activateU();">Register</a>
			    </li>
			  </ul>
		</div>
	</section>
	
	<section id="Login" class="container">
		<hr><br>
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

		<br><hr>
		<section class="container" id="newUser">
			<h1>AGREGAR UN NUEVO USUARIO <hr>	</h1>
			<form action="modUser.php" method="POST" accept-charset="utf-8">
				<div class="input-group mb-3">
			    <div class="input-group-prepend">
			      <span class="input-group-text">Nombre(s)</span>
			    </div>
			    <input type="text" class="form-control" placeholder="Nombre(s)" id="fName" name ="fName">
			  </div>

		  	<div class="input-group mb-3">
		      <div class="input-group-prepend">
		        <span class="input-group-text">Apellidos</span>
		      </div>
		      <input type="text" class="form-control" placeholder="Apellidos" id="lName" name ="lName">
		    </div>

	    	<div class="input-group mb-3">
	        <div class="input-group-prepend">
	          <span class="input-group-text">RFC</span>
	        </div>
	        <input type="text" class="form-control" placeholder="RFC" id="nRFC" name ="nRFC">
	      </div>

		  	<div class="input-group mb-3">
		      <div class="input-group-prepend">
		        <span class="input-group-text">NickName</span>
		      </div>
		      <input type="text" class="form-control" placeholder="NickName" id="nName" name ="nName" value ="">
		    </div>


		  	<div class="input-group mb-3">
		      <div class="input-group-prepend">
		        <span class="input-group-text">Contraseña</span>
		      </div>
		      <input type="password" class="form-control" placeholder="Contraseña" id="nPsw" name ="nPsw" value ="">
		    </div>

				<label for="sel1">Tipo de Usuario: </label>
				<select class="form-control" id="list1" name="idT">
				</select>

				<input type="hidden" name="typeOp" value="1">
				<button type="submit" class="btn btn-success btn-md"> Enviar </button>
			</form>
<hr>
		</section>
    
        <section id="allUsers" class="container">
            <table class="table table-dark table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre Completo</th>
                    <th>RFC</th>
                    <th>NickName</th>
                    <th>Activo</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody id = "tbAllUsers">

                </tbody>
            </table>
        </section>
	<footer class="footer"></footer>
</body>
<script type="text/javascript">
window.onload = function() {
    let login = document.getElementById("Login").style.display;
    let usrs = document.getElementById("allUsers").style.display;
    let newUser = document.getElementById("newUser").style.display;
    login = 'block';
    usrs = 'none';
    newUser = 'none';
    var types = <?php print_r(types());?>;
    var users = <?php print_r(allUsers());?>;
    allTypes(types);
    allUsers(users);

    function activateL(){
    	if(login == 'none'){
    		usrs = 'none';
    		newUser = 'none';
    		login = 'block';
    	}
    }
    function activateU(){
    	if(usrs == 'none'){
    		login = 'none';
    		newUser = 'none';
    		usrs = 'block';
    	}
    }
    function activateN(){
    	if(newUser == 'none'){
    		usrs = 'none';
    		newUser = 'block';
    		login = 'none';
    	}
    }

}
</script>
</html>