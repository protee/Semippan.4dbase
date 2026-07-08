
Class extends ZEN__DELETE


Class constructor($is_msg : Boolean)
	$is_msg:=Count parameters:C259>=1 ? $is_msg : True:C214
	Super:C1705($is_msg)
	
	// New functionnal system working like in the past, without transaction mode id requested
	
	
	// ***** External call for delete
	// *
Function records_delete($vT_table : Text; $c4ES_selection : 4D:C1709.EntitySelection)->$isOk : Boolean
	var $vC_aj_delete : Collection
	var $vL_count_records : Integer
	$vL_count_records:=$c4ES_selection.length
	$isOk:=($vL_count_records>0)
	If ($isOk)
		$vC_aj_delete:=This:C1470._aj_delete_fill($vT_table; $c4ES_selection)
		$isOk:=Super:C1706._records_delete($vC_aj_delete; $vT_table)
	Else 
		Super:C1706._nothingToDelete()
	End if 
	
	
Function record_delete($vT_table : Text; $c4E_entity : 4D:C1709.Entity; $is_cancel : Boolean)->$isOk : Boolean
	var $c4ES_selection : 4D:C1709.EntitySelection
	var $vC_aj_delete : Collection
	$c4ES_selection:=zen__ds[$vT_table].newSelection()
	$c4ES_selection:=$c4ES_selection.add($c4E_entity)
	$vC_aj_delete:=This:C1470._aj_delete_fill($vT_table; $c4ES_selection)
	$isOk:=Super:C1706._records_delete($vC_aj_delete; $vT_table; True:C214; $is_cancel)
	// *
	// *****
	
	
	// ***** All tables specific dispatcher
	// *
Function _aj_delete_fill($vT_table : Text; $c4ES_selection : 4D:C1709.EntitySelection)->$vC_aj_delete : Collection
	var $c4ES_related; $c4ES_related1; $c4ES_related2; $c4ES_related3_a; $c4ES_related3_b; $c4ES_related1_a; $c4ES_related1_b : 4D:C1709.EntitySelection
	var $c4ES_related2_b : 4D:C1709.EntitySelection
	$vC_aj_delete:=This:C1470._get_aj_delete()
	
	This:C1470._main_table($vC_aj_delete; $c4ES_selection)
	
	Case of   // True to allow related delete, False to prevent deletion
			
		: ($vT_table=("SLOKAS"))
			
			
		: ($vT_table=("KAVIYAM"))
			$c4ES_related:=This:C1470._related_table($c4ES_selection; "SLOKASD")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related; True:C214)
			
			
		: ($vT_table=("PRODUCTS"))
			$c4ES_related:=This:C1470._related_table($c4ES_selection; "PATHS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related; True:C214)
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "SLOKASD")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			
			
		: ($vT_table=("PATHS"))
			
		: ($vT_table=("PACKS"))
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "PATHS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			$c4ES_related2:=This:C1470._related_table($c4ES_selection; "BANKS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related2; True:C214)
			$c4ES_related2_b:=This:C1470._related_table($c4ES_selection; "TEMPLATES")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related2_b; True:C214)
			$c4ES_related3_a:=This:C1470._related_table($c4ES_related2; "SETS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related3_a; True:C214)
			$c4ES_related3_b:=This:C1470._related_table($c4ES_related2; "MEDIA")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related3_b; True:C214)
			
		: ($vT_table=("BANKS"))
			$c4ES_related1_a:=This:C1470._related_table($c4ES_selection; "SETS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1_a; True:C214)
			$c4ES_related1_b:=This:C1470._related_table($c4ES_selection; "MEDIA")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1_b; True:C214)
			
		: ($vT_table=("TEMPLATES"))
			$c4ES_related:=This:C1470._related_table($c4ES_selection; "SETS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related)
			$c4ES_related:=This:C1470._related_table($c4ES_selection; "MEDIA")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related)
			
		: ($vT_table=("COMBINATIONS"))
			
			
		: ($vT_table=("SETS"))
			
		: ($vT_table=("MEDIA"))
			
		: ($vT_table=("PICTURES"))
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "MEDIA")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			
		: ($vT_table=("CATEGORIES"))
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "PICTURES")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			$c4ES_related2:=This:C1470._related_table($c4ES_related1; "MEDIA")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related2; False:C215)
			
			
		Else   // Impossible to delete non planned tables
			This:C1470._do_set_deletable()  // Make the first (main table) not deletable
			
	End case 
	// *
	// *****
	
	