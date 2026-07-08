//%attributes = {"preemptive":"capable"}

#DECLARE($vL_tag : Integer; $vT_tag : Text; $is_local : Boolean)->$vT_answer : Text
var $vT_tag1 : Text

If ($is_local)
	$vT_answer:=zen_get_localized($vL_tag; $vT_tag)
	
Else 
	If ($vL_tag<0)
		$vT_answer:=$vT_tag
	Else 
		$vT_tag1:=wox_localize_tag($vL_tag; $vT_tag)
		$vT_answer:=Localized string:C991($vT_tag1)
		$vT_answer:=$vT_answer#"" ? $vT_answer : "‼️"+$vT_tag
	End if 
End if 
