//%attributes = {}

var $vJ_wok_prefs : Object

If (wok__registered("wom").first()#Null:C1517)
	EXECUTE METHOD:C1007("wom_configurate_vJ"; *; app__storage_prefs())
End if 

//$vJ_wok_prefs:=wok__storage_prefs()
//Use ($vJ_wok_prefs)
////$vJ_prefs.is_ignore_files:=true
//$vJ_wok_prefs.is_desc:=True
////$vJ_wok_prefs.is_splashes:=True
//End use 

// If (Startup in a new process) -> DO IT MANUALLY
//wok_splashes_display()

