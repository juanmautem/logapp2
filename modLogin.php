<?php
  include 'connection.php';

  $con = connect();
  echo "HOLA DESDE LOGIN <br>";
  if(isset($_GET['typeOp'])){
    switch($_GET['typeOp']){
      case 1:
        $usr = $_GET['user'];
        $psw = md5($_GET['pass']);
        $resultado = mysqli_query( $con, "SELECT PersonID FROM vwlogin where NickName = '$usr' AND Pass = '$psw';" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
        $res = mysqli_fetch_array($resultado);
        if(isset($res['PersonID'])){
          $id = $res['PersonID']; 
          $resultado2 = mysqli_query( $con, "SELECT * FROM vwusersdata WHERE nIdPersona = $id" ) or die ( "Algo ha ido mal en la consulta a la base de datos");
           $data = mysqli_fetch_array($resultado2);
           session_start();
              $_SESSION['userID'] = $data['nIdPersona'];
              $_SESSION['nombre'] = $data['txtNombre'];
              $_SESSION['apellidos'] = $data['txtApellidos'];
              $_SESSION['NickName'] = $data['txtNombreCorto'];
              $_SESSION['RFC'] = $data['txtRFC'];
              $_SESSION['Tipo'] = $data['txtTipo'];
           if($data[8] == 'Super Administrador'){

              echo "BIENVENIDO SUPER ADMIN!!";
           }
           if($data[8] == 'Administrador'){
              echo "BIENVENIDO ADMIN!!";
           }
           if($data[8] == 'Empleado'){
              echo "BIENVENIDO EMPLEADO!!";
           }
           if($data[8] == 'Clientes'){
              echo "BIENVENIDO CLIENTE!!";
           }
          
        }
        else
          echo "Usuario sin acceso a Aplicacion!";
         
        break;
        
    }


  }