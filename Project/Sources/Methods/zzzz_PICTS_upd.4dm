//%attributes = {}

var $idx; $vL_imgColor : Integer
var $cE_PICTURES : cs:C1710.PICTURESEntity
var $cES_PICTURES : cs:C1710.PICTURESSelection

If (waz_io_confirm_popup("ARE YOU SURE?"))
	$idx:=0
	$cES_PICTURES:=ds:C1482.PICTURES.all()
	For each ($cE_PICTURES; $cES_PICTURES)
		$vL_imgColor:=$cE_PICTURES.imgColor
		// Multi, white, black, grey, mono => white, black, grey, mono, Multi
		// 0 -> 4 ; 1-4 -= 
		If ($vL_imgColor=0)
			$vL_imgColor:=4
		Else 
			$vL_imgColor-=1
		End if 
		$cE_PICTURES.imgColor:=$vL_imgColor
		$cE_PICTURES.save()
		$idx+=1
	End for each 
End if 
