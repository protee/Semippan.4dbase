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

#DECLARE($vT_table : Text; $vT_prefix : Text; $vT_title : Text; $c4ES_entities : 4D:C1709.EntitySelection; $c4Fu_label : 4D:C1709.Function; $vL_indice : Integer; $is_all : Boolean; $vT_refMenu : Text; $is_inline : Boolean)->$vT_refMenu_answer : Text
var $c4E_entity : 4D:C1709.Entity
var $is_toAttach : Boolean
var $idx; $vL_color : Integer
var $vT_idx; $vT_item_parameter; $vT_label; $vT_path_menu : Text
$is_toAttach:=($vT_refMenu#"")

If ($is_toAttach) && ($is_inline)
	$vT_refMenu_answer:=$vT_refMenu
Else 
	$vT_refMenu_answer:=Create menu:C408
	x_header_menu($vT_refMenu_answer; $vT_title)
End if 

$vT_prefix:=$vT_prefix#"" ? $vT_prefix+"." : $vT_prefix

$idx:=0
For each ($c4E_entity; $c4ES_entities)
	$vT_idx:=String:C10($idx)
	$vT_item_parameter:=$vT_prefix+$vT_idx
	$vT_label:=$c4Fu_label.call($c4E_entity)
	$vT_label:=$vT_label#"" ? $vT_label : " "
	APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_label; *)
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_item_parameter)
	
	If ($c4E_entity.colors#Null:C1517)
		$vL_color:=woc_sp_colors_to_s_or_f($c4E_entity.colors)
		woc_SET_MENU_ITEM_icns($vT_refMenu_answer; -1; $vL_color)
	End if 
	If ($is_all) && ($c4E_entity.isActive#Null:C1517)
		If ($c4E_entity.isActive)
			SET MENU ITEM STYLE:C425($vT_refMenu_answer; -1; Bold:K14:2)
		End if 
	End if 
	If ($vL_indice=$idx)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
	$idx+=1
End for each 

If ($is_toAttach) && (Not:C34($is_inline))
	APPEND MENU ITEM:C411($vT_refMenu; $vT_title; $vT_refMenu_answer; *)
	RELEASE MENU:C978($vT_refMenu_answer)
	$vT_path_menu:="path:/RESOURCES/tables/icn_"
	SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+Lowercase:C14($vT_table)+k_png_ext)
End if 

