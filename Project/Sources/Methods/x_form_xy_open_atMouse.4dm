//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x_form_xy_open_atMouse
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 08/04/2022   OG   Initial version.

#DECLARE($vP_table : Pointer; $vT_form : Text; $vL_window_type : Integer; $vT_title : Text; $vL_framed : Integer; $vJ_form : Object)->$isOk : Boolean
If (Count parameters:C259<5)
	$vL_framed:=k_form_rightBottom
End if 

var $vL_windowRef : Integer
var $vL_left; $vL_top : Integer
x_form_xy_calculate_mouse($vP_table; $vT_form; ->$vL_left; ->$vL_top; $vL_framed)
If ($vP_table#Null:C1517)
	$vL_windowRef:=Open form window:C675($vP_table->; $vT_form; $vL_window_type; $vL_left; $vL_top)
	SET WINDOW TITLE:C213($vT_title; $vL_windowRef)
	DIALOG:C40($vP_table->; $vT_form; $vJ_form)
Else 
	$vL_windowRef:=Open form window:C675($vT_form; $vL_window_type; $vL_left; $vL_top)
	SET WINDOW TITLE:C213($vT_title; $vL_windowRef)
	DIALOG:C40($vT_form; $vJ_form)
End if 
$isOk:=(OK=1)
CLOSE WINDOW:C154($vL_windowRef)








