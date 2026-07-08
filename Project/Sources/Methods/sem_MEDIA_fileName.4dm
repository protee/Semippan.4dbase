//%attributes = {}

#DECLARE($cE_BANKS : cs:C1710.BANKSEntity; $cE_SETS : cs:C1710.SETSEntity; $cE_MEDIA : cs:C1710.MEDIAEntity)->$vT_fileName : Text
var $vL_orderMode; $vL_orderOffset : Integer
var $vJ_menu : Object
var $vT_order; $vT_fileStart; $vT_mime : Text

$vL_orderMode:=$cE_BANKS.orderMode
$vL_orderOffset:=$cE_BANKS.orderOffset

$vT_fileName:=$cE_MEDIA.fileName
$vT_order:=$vL_orderMode=2 ? String:C10($cE_MEDIA.order+$vL_orderOffset-1) : ""
If ($cE_SETS#Null:C1517)  //&& False
	$vT_fileStart:=$cE_SETS.fileStart
	$vJ_menu:=zen__storage_menuBtns().m_outputMime
	$vT_mime:="."+$vJ_menu.at_lbl[$cE_SETS.mime]
End if 

$vT_fileName:=$vT_fileStart+$vT_fileName+$vT_order+$vT_mime

