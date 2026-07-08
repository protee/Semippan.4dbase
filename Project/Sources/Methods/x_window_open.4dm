//%attributes = {}

#DECLARE($vP_table : Pointer; $vT_form : Text; $vL_form : Integer; $vJ_form_prefs : Object; $is_moveAtStart : Boolean)->$vL_winRef : Integer
var $vL_left; $vL_top : Integer

If ($is_moveAtStart)
	$vL_left:=$vJ_form_prefs.l_left
	$vL_top:=$vJ_form_prefs.l_top
	If ($vP_table#Null:C1517)
		$vL_winRef:=Open form window:C675($vP_table->; $vT_form; $vL_form; $vL_left; $vL_top)
	Else 
		$vL_winRef:=Open form window:C675($vT_form; $vL_form; $vL_left; $vL_top)
	End if 
Else 
	If ($vP_table#Null:C1517)
		$vL_winRef:=Open form window:C675($vP_table->; $vT_form; $vL_form)
	Else 
		$vL_winRef:=Open form window:C675($vT_form; $vL_form)
	End if 
End if 

