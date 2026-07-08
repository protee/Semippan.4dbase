//%attributes = {}

#DECLARE($vP_table : Pointer; $vT_form : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
var $vL_width; $vL_height : Integer

If ($vP_table#Null:C1517)
	FORM GET PROPERTIES:C674($vP_table->; $vT_form; $vL_width; $vL_height)
Else 
	FORM GET PROPERTIES:C674($vT_form; $vL_width; $vL_height)
End if 
$vP_vL_width->:=$vL_width
$vP_vL_height->:=$vL_height
