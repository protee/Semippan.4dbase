//%attributes = {}

#DECLARE($vT_value : Text; $vC_menu_items : Collection; $vT_label : Text)->$vT_anwer : Text
var $vT_refMenu; $vT_path_menu; $vT_answer : Text
var $isOk : Boolean

$vT_refMenu:=x_choice_generic_menu(""; $vT_path_menu; $vT_label; $vC_menu_items)
$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)

$isOk:=$vT_answer#""
If ($isOk)
End if 

