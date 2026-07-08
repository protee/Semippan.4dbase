//%attributes = {"lang":"en","preemptive":"incapable"}
// *****
// *
// Method: zenh_list_get_user_data
// By Olivier Grimbert — Protée sarl
// on 11/01/2024 11:33:52
//
// Description:
//
// Date        Init  Description
// ===================================================================
// 11/01/2024   OG   Initial version.
// *
// *****

#DECLARE($vT_profile : Text; $vT_table : Text; $vT_view : Text)->$vJ_data : Object

If (False:C215)
	var $vL_table : Integer
	$vL_table:=zen_get_tableNumber($vT_table)
	
	var $vJ_profile : Object
	var $vV_user_id : Variant
	$vJ_profile:=zen__storage_profile()
	$vV_user_id:=$vJ_profile.v_user_id
	
	//var $c4E_entity : 4D.DataClass
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=zen__ds.ZEN_USERS_SETTINGS.query("UIDuser = :1 & profile = :2 & tableNumber = :3 & view = :4"; $vV_user_id; $vT_profile; $vL_table; $vT_view).first()
	If ($c4E_entity#Null:C1517)
		var $vC_data : Collection
		var $vT_json : Text
		$vT_json:=$c4E_entity.settings
		If ($vT_json#"")
			If (Substring:C12($vT_json; 1; 1)="[")
				$vC_data:=JSON Parse:C1218($vT_json)
				$vJ_data:=zen_lists_convertor($vC_data)
			Else 
				$vJ_data:=JSON Parse:C1218($vT_json)
			End if 
		End if 
	End if 
End if 
