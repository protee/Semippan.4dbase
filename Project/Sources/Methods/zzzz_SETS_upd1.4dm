//%attributes = {}

var $cE_SETS : cs:C1710.SETSEntity
var $cES_SETS : cs:C1710.SETSSelection
var $idx : Integer
var $vJ_picture : Object
var $vT_property : Text

If (waz_io_confirm_popup("ARE YOU SURE?"))
	$idx:=0
	$cES_SETS:=ds:C1482.SETS.all()
	For each ($cE_SETS; $cES_SETS)
		$vJ_picture:=$cE_SETS.j_picture
		$vT_property:="isGreyDisabled"
		If (OB Is defined:C1231($vJ_picture; $vT_property))
			$vJ_picture.is_greyDisabled:=$vJ_picture.isGreyDisabled
			OB REMOVE:C1226($vJ_picture; $vT_property)
		End if 
		$vT_property:="isOffsetClick"
		If (OB Is defined:C1231($vJ_picture; $vT_property))
			$vJ_picture.is_offsetClick:=$vJ_picture.isOffsetClick
			OB REMOVE:C1226($vJ_picture; $vT_property)
		End if 
		$cE_SETS.save()
		$idx+=1
	End for each 
End if 
