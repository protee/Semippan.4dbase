//%attributes = {}
// Project Method: x_form_xy_calculate
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 02/04/2022   OG   Initial version.

#DECLARE($vP_table : Pointer; $vT_form : Text; $vP_left : Pointer; $vP_top : Pointer; $vL_framed : Integer)  // {#5} optionals 
If (Count parameters:C259<5)
	$vL_framed:=k_form_rightBottom
End if 

var $vL_width; $vL_height : Integer
If ($vP_table=Null:C1517)
	FORM GET PROPERTIES:C674($vT_form; $vL_width; $vL_height)
Else 
	FORM GET PROPERTIES:C674($vP_table->; $vT_form; $vL_width; $vL_height)
End if 
wox_form_xy_calculate($vL_width; $vL_height; $vP_left; $vP_top; $vL_framed)


