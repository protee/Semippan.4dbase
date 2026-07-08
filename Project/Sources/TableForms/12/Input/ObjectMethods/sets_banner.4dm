
//x_io_banner("isActive")
var $cE_sets : cs:C1710.SETSEntity
$cE_sets:=Form:C1466.cE_SETS
If (x_io_banner_sets($cE_sets))
	Form:C1466.fc._sets_chgt()
End if 


