
function allTypes(types){
        let typeList = document.getElementById("list1");
        var cad = "<option value = '0';>Seleccione Opción</option>";
		for (var row of types){
			cad += "<option title='" + row.Description + "'  value = '" + row.ID + "';>" + row.Type + "</option>";
		}
		typeList.innerHTML = cad;	
	}

    function allUsers(allUsers){
        let usersList = document.getElementById("tbAllUsers");
        var cad = "";
        for (var row of allUsers){
            cad += "<tr>";
            cad += "<td>" + row.UserID + "</td>";
            cad += "<td>" + row.txtNombre + " " + row.txtApellidos + "</td>";
            cad += "<td>" + row.txtRFC + "</td>";
            cad += "<td>" + row.txtNombreCorto + "</td>";
            cad += "<td>";
                if(row.bActivo == 1)
                    cad += "<button value='"+row.UserID +"' class='btn btn-success btn-sm ' onclick = 'change(this.value);' > <i class='fas fa-thumbs-up'></i></button>";
                if(row.bActivo == 0)
                    cad += "<button value='"+row.UserID +"' class='btn btn-danger btn-sm ' onclick = 'change(this.value);' > <i class='fas fa-thumbs-down'></i></button>";
            cad += "</td>";
            cad += "<td> </td>";
            cad+= "</tr>"
        }
        usersList.innerHTML = cad;
    }
	function change(id){
	var usrData = {
            "userID" : id,
            "typeOp" : 1
        };
		$.ajax({
            method: "GET",
            url: "modUser.php",
            data: usrData,
            success: function(data){
            	data = $.trim(data);
            	if(data)
                    confirm("Usuario Actualizado Correctamente");
                    window.location.href = "./index.php";
            }
        });
	}

	function login(){
        var usr = document.getElementById("usr");
        let psw = document.getElementById("psw");
        var usrData = {
            "user" : usr.value,
            "pass" : psw.value,
            "typeOp" : 1
        };
		
        $.ajax({
            method: "GET",
            url: "modLogin.php",
            data: usrData,
            success: function(data){
            	data = $.trim(data);
            	switch(data){
            		case '1':
            			alert("BIENVENIDO SUPERADMIN");
            			window.location.href = "./superAdmin.php?access=true";
            			break;
            		case '2':
            			alert("BIENVENIDO ADMIN");
            			window.location.href = "./admin.php";
            			break;
        			case '3':
	        			alert("BIENVENIDO EMPLEADO");
            			window.location.href = "./empleados.php";
	        			break;
        			case '4':
	        			alert("BIENVENIDO CLIENTE");
            			window.location.href = "./clientes.php";
	        			break;
        			default:
	        			alert("USUARIO NO ENCONTRADO");
	        			break;
            	}
            }
        });
	}