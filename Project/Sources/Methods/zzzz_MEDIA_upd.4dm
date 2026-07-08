//%attributes = {}

var $idx : Integer
var $cE_MEDIA : cs:C1710.MEDIAEntity
var $cES_MEDIA : cs:C1710.MEDIASelection

If (waz_io_confirm_popup("ARE YOU SURE?"))
	$idx:=0
	$cES_MEDIA:=ds:C1482.MEDIA.all()
	For each ($cE_MEDIA; $cES_MEDIA)
		$cE_MEDIA.sourcePNG:=Background color none:K23:10
		$cE_MEDIA.targetPNG:=k_MDcolorGrey
		$cE_MEDIA.save()
		$idx+=1
	End for each 
End if 
