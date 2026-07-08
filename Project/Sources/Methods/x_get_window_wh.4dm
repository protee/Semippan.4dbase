//%attributes = {}

#DECLARE($vL_winRef : Integer; $vP_vL_width : Pointer; $vP_vL_height : Pointer; $vJ_params : Object)
var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height : Integer
var $vJ_form_prefs : Object

GET WINDOW RECT:C443($vL_left; $vL_top; $vL_right; $vL_bottom; $vL_winRef)
$vL_width:=$vL_right-$vL_left
$vL_height:=$vL_bottom-$vL_top

$vP_vL_width->:=$vL_width
$vP_vL_height->:=$vL_height

If ($vJ_params#Null:C1517)
	$vJ_form_prefs:=$vJ_params.j_prefs
	$vJ_form_prefs.l_width:=$vL_width
	$vJ_form_prefs.l_height:=$vL_height
End if 
