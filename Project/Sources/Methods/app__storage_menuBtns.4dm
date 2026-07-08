//%attributes = {}

#DECLARE($vT_menuBtn : Text)->$vj_menuBtns : Object
$vj_menuBtns:=zen__storage_prefs().j_menuBtns
If ($vT_menuBtn#"")
	$vj_menuBtns:=$vj_menuBtns[$vT_menuBtn]
End if 
