<?php
  include 'connection.php';

  $con = connect();
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
           $_SESSION['userID'] = $data['nIdPersona'];
              $_SESSION['nombre'] = $data['txtNombre'];
              $_SESSION['apellidos'] = $data['txtApellidos'];
              $_SESSION['NickName'] = $data['txtNombreCorto'];
              $_SESSION['RFC'] = $data['txtRFC'];
              $_SESSION['Tipo'] = $data['txtTipo'];
              $_SESSION['ID'] = session_id();
           if($data['txtTipo'] == 'Super Administrador'){
              
              echo json_encode(1);
           }
           if($data['txtTipo'] == 'Administrador'){
              echo json_encode(2);
            
           }
           if($data['txtTipo'] == 'Empleado'){
              echo json_encode(3);

           }
           if($data['txtTipo'] == 'Clientes'){
             echo json_encode(4);           }
          
        }
        else
          echo "Usuario sin acceso a Aplicacion!";
         
        break;
        
    }
    

  }