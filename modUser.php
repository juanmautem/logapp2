<?php 
	include 'connection.php';

/* MODIFICAR E INSERTAR USUARIOS */
	if(isset($_POST['typeOp'])){
    print_r($_POST);
    switch($_POST['typeOp']){
        case 1:
          insertUser($_POST);
          break;
        case 2:
          editUser($_POST);
          break;
        case 3:
          deleteUser($_POST);
          break;
     }
	}
	//$data = $_POST

	function insertUser($data){
    $con = connect();
    $nombre = $data['fName'];
    $apellidos = $data['lName'];
    $rfc = $data['nRFC'];
    $idT = $data['idT'];
    $NickName = $data['nName'];
    $Psw = $data['nPsw'];
    $resultado = mysqli_query( $con, "CALL proAddNwUser('$nombre','$apellidos','$rfc',$idT,'$NickName','$Psw');" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
		if($resultado){
      mysqli_close($con);
      echo "Usuario Creado con Éxito";
    }else{
      echo "Usuario no creado";
    }


	}
/*************************************************************************/
/*CONSULTAS A VISTAS Y CAMBIO DE ESTADOS*/

if(isset($_GET['typeOp'])){
  $con = connect();
  $id = $_GET['userID'];
    switch($_GET['typeOp']){
        
        case 1:
          $resultado = mysqli_query( $con, " CALL proActivate($id);" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
          if($resultado) {
            echo json_encode(true);
            break; 
          }
          else{
            echo json_encode(false);
            break;
          }
        default:
          break;
     }
  }

/*************************************************************************/
