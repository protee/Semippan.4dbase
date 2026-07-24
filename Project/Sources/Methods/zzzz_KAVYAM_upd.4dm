//%attributes = {}

var $idx : Integer
var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
var $cES_KAVIYAM : cs:C1710.KAVIYAMSelection
var $vJ_veda_prefs : Object

If (waz_io_confirm_popup("ARE YOU SURE?"))
	$idx:=0
	$cES_KAVIYAM:=ds:C1482.KAVIYAM.all()
	For each ($cE_KAVIYAM; $cES_KAVIYAM)
		$vJ_veda_prefs:=$cE_KAVIYAM.j_veda_prefs
		//$vJ_veda_prefs.is_text_center:=True
		//$vJ_veda_prefs.l_angle_start:=-132
		//$vJ_veda_prefs.l_angle_end:=0
		$vJ_veda_prefs.l_speed:=9
		$cE_KAVIYAM.save()
		$idx+=1
	End for each 
End if 
