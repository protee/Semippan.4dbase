//%attributes = {"lang":"en"}
// Project Method: Compiler_init
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 09/04/2023   OG   Initial version.

//%W-518.5 ARRAY DEF
//%W-518.1 COPY ARRAY
//%W-518.2 SELECTION TO ARRAY
//%W-518.6 ARRAY TO SELECTION
//%W-518.10 DISTINCT VALUES

//%W-533.3 ARRAY INDICE POINTER
//%W-533.1 COLLECTION
//%W-550.26 Undeclared property

// NOK
//%W-529.17 Method masked
//%W-550.2 CLASS
//%W-533.4 PLUGINS

var $vJ_prefs : Object
var $vT_host : Text

$vJ_prefs:=app__storage_prefs()
$vT_host:="Sēmippān"

wox_prefs_set_host_name("zenApp")
Use ($vJ_prefs)
	$vJ_prefs.t_name:=$vT_host
	$vJ_prefs.t_version:="21.1.00"
	$vJ_prefs.t_app:="sem"
	$vJ_prefs.l_make:=2  // HDI
	$vJ_prefs.fo_rsc:=Folder:C1567(fk resources folder:K87:11)
	$vJ_prefs.is_free:=True:C214  // ✅ flag for wok registration
	$vJ_prefs.is_host:=True:C214  // Remove from menu ogToolsSuite
	$vJ_prefs.fu_callback_init:=Formula:C1597(_wom_callback_init)
	//$vJ_prefs.fu_callback_built:=Formula(_wom_callback_built)
	
	$vJ_prefs.l_scale:=2
	
End use 

