//%attributes = {}

var $cE_SETS : cs:C1710.SETSEntity
var $cES_SETS : cs:C1710.SETSSelection
var $vJ_dcox : Object
var $vT_property : Text
var $cE_MEDIA : cs:C1710.MEDIAEntity
var $cES_MEDIA : cs:C1710.MEDIASelection
var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
var $cES_TEMPLATES : cs:C1710.TEMPLATESSelection

If (waz_io_confirm_popup("DCOX l_main->l_colors ARE YOU SURE?"))
	$cES_SETS:=ds:C1482.SETS.all()
	For each ($cE_SETS; $cES_SETS)
		$vJ_dcox:=$cE_SETS.j_dcox
		$vT_property:="l_main"
		If (OB Is defined:C1231($vJ_dcox; $vT_property))
			$vJ_dcox.l_colors:=$vJ_dcox.l_main
			OB REMOVE:C1226($vJ_dcox; $vT_property)
		End if 
		$cE_SETS.save()
	End for each 
	
	$cES_MEDIA:=ds:C1482.MEDIA.all()
	For each ($cE_MEDIA; $cES_MEDIA)
		$vJ_dcox:=$cE_MEDIA.j_dcox
		$vT_property:="l_main"
		If (OB Is defined:C1231($vJ_dcox; $vT_property))
			$vJ_dcox.l_colors:=$vJ_dcox.l_main
			OB REMOVE:C1226($vJ_dcox; $vT_property)
		End if 
		$cE_MEDIA.save()
	End for each 
	
	$cES_TEMPLATES:=ds:C1482.TEMPLATES.all()
	For each ($cE_TEMPLATES; $cES_TEMPLATES)
		$vJ_dcox:=$cE_TEMPLATES.j_dcox
		$vT_property:="l_main"
		If (OB Is defined:C1231($vJ_dcox; $vT_property))
			$vJ_dcox.l_colors:=$vJ_dcox.l_main
			OB REMOVE:C1226($vJ_dcox; $vT_property)
		End if 
		$cE_TEMPLATES.save()
	End for each 
	
	
End if 
