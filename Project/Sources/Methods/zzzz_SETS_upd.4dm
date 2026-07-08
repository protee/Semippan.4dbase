//%attributes = {}

var $cE_SETS : cs:C1710.SETSEntity
var $cES_SETS : cs:C1710.SETSSelection
var $vC_at_bind : Collection
var $vL_brightness; $idx : Integer
var $vJ_picture : Object
var $vT_bind; $vT_bind1; $vT_property : Text

If (waz_io_confirm_popup("ARE YOU SURE?"))
	$vC_at_bind:=sem_get_at_dcox()
	
	$idx:=0
	$cES_SETS:=ds:C1482.SETS.all()
	For each ($cE_SETS; $cES_SETS)
		$vJ_picture:=$cE_SETS.j_picture
		For each ($vT_bind; $vC_at_bind)
			$vT_bind1:=Uppercase:C13(Substring:C12($vT_bind; 1; 1))+Substring:C12($vT_bind; 2)
			$vT_property:="l_br"+$vT_bind1
			If (OB Is defined:C1231($vJ_picture; $vT_property))
				$vL_brightness:=Num:C11($vJ_picture[$vT_property])
				$vJ_picture["l_br_"+$vT_bind]:=$vL_brightness
				OB REMOVE:C1226($vJ_picture; $vT_property)
			End if 
		End for each 
		$cE_SETS.save()
		$idx+=1
	End for each 
End if 
