//%attributes = {"lang":"en"}

#DECLARE($vP_vL_value : Pointer; $vC_menu_items : Collection; $vT_label : Text)->$isOk : Boolean
var $vT_refMenu; $vT_answer : Text

$vT_refMenu:=x_choice_generic_menu(""; ""; $vT_label; $vC_menu_items; $vP_vL_value->; True:C214)
$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)

$isOk:=$vT_answer#""
If ($isOk)
	$vP_vL_value->:=Num:C11($vT_answer)
End if 

