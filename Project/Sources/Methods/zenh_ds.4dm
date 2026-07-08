//%attributes = {"lang":"en"}

#DECLARE()->$cs_ds : cs:C1710.DataStore
var $vJ_prefs : Object
$vJ_prefs:=zen__storage_prefs()
$cs_ds:=ds:C1482($vJ_prefs.t_ds)

