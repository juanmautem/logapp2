<?php
	if(isset($_SESSION['userID'])){

?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Vista Clientes</title>
</head>
<body>

</body>
</html>
<?php
}
else{
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ERROR</title>
</head>
<body>
	<h1>ERROR 404. NO TIENES ACCESO A ESTE SITIO</h1>
</body>
</html>
<?php
}
?>