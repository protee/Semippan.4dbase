//%attributes = {"shared":true}

var $isOk : Boolean
var $vJ_pref_file; $vJ_prefs; $vJ_form : Object
var $vT_form : Text

$vT_form:="PANEL_KAVIYAM"
$vJ_pref_file:=zen__prefs_get_c4Fo.file($vT_form+".json")  // Common file
$isOk:=wox_prefs_load($vJ_pref_file; ->$vJ_prefs; 1)  // Version, increase to reset
//If (Not($isOk))
////$vJ_prefs.aj_snippets:=New collection
//End if 

$vJ_form:=New object:C1471
$vJ_form.j_prefs:=$vJ_prefs
//$vJ_form.j_prefs_file:=$vJ_pref_file

$isOk:=zenh_form_open(Null:C1517; $vT_form; "Panel KAVIYAM"; $vJ_form)
wox_prefs_save($vJ_pref_file; $vJ_prefs)

