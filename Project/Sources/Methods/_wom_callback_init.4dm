//%attributes = {}

// *****
// *
// Method: _wom_callback_init
// Olivier Grimbert — Protée sarl — 16/08/2024 22:52:24
//
// Description: Called by wom before all, used here to update name and version
//
// Date       | Who | Comment
// 28/12/2022 | OG | Initial version Protée sarl
// 16/08/2024 | OG  | Updated
// *
// *****

#DECLARE($vJ_dbf : Object; $vJ_build_options : Object)->$isOk : Boolean
$isOk:=True:C214

app_init  // Initialize values
wox_vJ_overload(app__storage_prefs; $vJ_build_options; "t_name"; "t_version")


