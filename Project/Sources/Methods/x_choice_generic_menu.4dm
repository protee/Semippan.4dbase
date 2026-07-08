//%attributes = {"preemptive":"incapable"}

// *****
// *
// Method: x_lb_headers_calculate_menu
// By Olivier Grimbert — Protée sarl
// on 24/01/2024 13:37:19
//
// Description: 
//
// Date        Init  Description
// ===================================================================
// 24/01/2024   OG   Initial version.
// *
// *****

#DECLARE($vT_prefix : Text; $vT_path_menu : Text; $vT_label : Text; $vC_menu_items : Collection; $vL_value : Integer; $is_numbered : Boolean; $vT_refMenu : Text; $is_inline : Boolean)->$vT_refMenu_answer : Text
var $is_toAttach : Boolean
var $idx : Integer
var $vT_item; $vT_translate; $vT_idx; $vT_item_parameter; $vT_icon; $vT_translated : Text
$is_toAttach:=($vT_refMenu#"")

If ($is_toAttach) && ($is_inline)
	$vT_refMenu_answer:=$vT_refMenu
Else 
	$vT_refMenu_answer:=Create menu:C408
	x_header_menu($vT_refMenu_answer; $vT_label)
End if 

$vT_path_menu:="path:/RESOURCES/"+$vT_path_menu

$idx:=0
For each ($vT_item; $vC_menu_items)
	If ($vT_item="")
		APPEND MENU ITEM:C411($vT_refMenu_answer; "-")
	Else 
		$vT_translate:=$vT_prefix+$vT_item
		If ($is_numbered)
			$vT_idx:=String:C10($idx)
			$vT_item_parameter:=$vT_prefix+$vT_idx
			$vT_icon:=$vT_idx
		Else 
			$vT_item_parameter:=$vT_translate
			$vT_icon:=$vT_item
		End if 
		$vT_translated:=Get localized string:C991($vT_translate)
		$vT_translated:=($vT_translated#"") ? $vT_translated : $vT_translate
		APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_translated; *)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_item_parameter)
		SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_icon+k_png_ext)
		If ($vL_value=$idx)
			SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
		End if 
		$idx+=1
	End if 
End for each 

If ($is_toAttach) && (Not:C34($is_inline))
	APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_answer; *)
	RELEASE MENU:C978($vT_refMenu_answer)
	SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+"infos"+k_png_ext)
End if 

