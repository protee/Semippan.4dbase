//%attributes = {}


#DECLARE($vT_host_name : Text; $vT_serial : Text; $is_send : Boolean)->$is_serial_ok : Boolean
var $is_initialization : Boolean
var $vJ_prefs : Object
If (Count parameters:C259<3)
	$is_send:=Is compiled mode:C492  //|| True  // Send rapport if ogTools compiled
End if 


$vJ_prefs:=sem__storage_prefs()

// ***** FIRST INITIALIZE
// *
$is_initialization:=($vJ_prefs=Null:C1517) || Shift down:C543
If ($is_initialization)
	$vJ_prefs:=New shared object:C1526
	Use (Storage:C1525)
		Storage:C1525.j_prefs:=$vJ_prefs
	End use 
	app_init()
	app_init_prefs()
	app_init_stuff()  // Generic stuff...
	app_init_widgets()
End if 
// *
// *****

// ***** THEN REGISTRATION
// *
$is_serial_ok:=wok_license_register($vJ_prefs; $vT_host_name; $vT_serial; $is_send)
// *
// *****
