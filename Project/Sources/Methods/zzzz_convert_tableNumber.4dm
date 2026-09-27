//%attributes = {}

var $c4DC_table : 4D:C1709.DataClass
var $c4E_table : 4D:C1709.Entity
var $c4ES_table : 4D:C1709.EntitySelection
var $vC_at_tables : Collection
var $vL_table : Integer
var $vT_table : Text
$vC_at_tables:=New collection:C1472()
$vC_at_tables.push("ZEN_DOCUMENTS"; "ZEN_REPORTS"; "ZEN_SETS"; "ZEN_USERS_SETTINGS")  // tableNumber
$vC_at_tables.push("ZEN_POPUPS")  // tableNum

For each ($vT_table; $vC_at_tables)
	$c4DC_table:=ds:C1482[$vT_table]
	If ($c4DC_table#Null:C1517)
		$c4ES_table:=$c4DC_table.all()
		For each ($c4E_table; $c4ES_table)
			$vT_table:=$c4E_table.table
			$vL_table:=Num:C11($vT_table)  // Get old num
			If (String:C10($vL_table)=$vT_table)
				$vT_table:=$vL_table#0 ? Table name:C256($vL_table) : ""
				$c4E_table.table:=$vT_table
				zen_entity_save($c4E_table)
			End if 
		End for each 
	End if 
End for each 

