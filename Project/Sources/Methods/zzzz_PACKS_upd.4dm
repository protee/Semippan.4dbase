//%attributes = {}

var $idx : Integer
var $cE_PACKS : cs:C1710.PACKSEntity
var $cES_PACKS : cs:C1710.PACKSSelection
var $vJ_alColors : Object

If (waz_io_confirm_popup("ARE YOU SURE?"))
	$vJ_alColors:=woc__storage_widgets().j_alColors.j_value
	
	$idx:=0
	$cES_PACKS:=ds:C1482.PACKS.all()
	For each ($cE_PACKS; $cES_PACKS)
		$cE_PACKS.j_alColors:=$vJ_alColors
		$cE_PACKS.save()
		$idx+=1
	End for each 
End if 
