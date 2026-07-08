//%attributes = {"lang":"en","preemptive":"incapable"}
// *****
// *
// Method: zenh_list_set_user_data
// By Olivier Grimbert — Protée sarl
// on 11/01/2024 11:34:37
//
// Description:
//
// Date        Init  Description
// ===================================================================
// 11/01/2024   OG   Initial version.
// *
// *****

#DECLARE($vT_profile : Text; $vT_table : Text; $vT_view : Text; $vJ_data : Object)

If (False:C215)
	var $vL_table : Integer
	$vL_table:=zen_get_tableNumber($vT_table)
	
	var $vJ_profile : Object
	var $vV_user_id : Variant
	$vJ_profile:=zen__storage_profile()
	$vV_user_id:=$vJ_profile.v_user_id
	
	var $vT_json : Text
	var $cE_zen_users_settings : cs:C1710.ZEN_USERS_SETTINGSEntity
	var $cES_zen_users_settings : cs:C1710.ZEN_USERS_SETTINGSSelection
	$cES_zen_users_settings:=zen__ds.ZEN_USERS_SETTINGS.query("UIDuser = :1 & profile = :2 & tableNumber = :3 & view = :4"; $vV_user_id; $vT_profile; $vL_table; $vT_view)
	If ($vJ_data#Null:C1517)
		$vT_json:=JSON Stringify:C1217($vJ_data)
		If ($cES_zen_users_settings.length=1)
			$cE_zen_users_settings:=$cES_zen_users_settings.first()
		Else 
			$cE_zen_users_settings:=zen_entity_new(zen__ds.ZEN_USERS_SETTINGS)
			$cE_zen_users_settings.UIDuser:=$vV_user_id
			$cE_zen_users_settings.profile:=$vT_profile
			$cE_zen_users_settings.tableNumber:=$vL_table
			$cE_zen_users_settings.view:=$vT_view
		End if 
		$cE_zen_users_settings.settings:=$vT_json
		zen_entity_save($cE_zen_users_settings)
	Else 
		If ($cES_zen_users_settings.length>=1)
			$cES_zen_users_settings.drop()
		End if 
	End if 
End if 
