
// *****
// *
//%W-550.26 Undeclared property

Class constructor($is_msg : Boolean)
	var $vC_aj_delete : Collection
	This:C1470.is_msg:=$is_msg
	$vC_aj_delete:=New collection:C1472
	This:C1470.aj_delete_answer:=$vC_aj_delete
	
	
Function _get_aj_delete()->$vC_aj_delete : Collection
	$vC_aj_delete:=This:C1470.aj_delete_answer
	// *
	// *****
	
	
	// *****
	// *
Function _main_table($vC_aj_delete : Collection; $c4ES_selection : 4D:C1709.EntitySelection; $is_delete : Boolean)
	If (Count parameters:C259<3)
		$is_delete:=True:C214
	End if 
	This:C1470._aj_delete_push($vC_aj_delete; $c4ES_selection; $is_delete)
	
	
Function _related_table($c4ES_selection : 4D:C1709.EntitySelection; $vT_related : Text)->$c4ES_related : 4D:C1709.EntitySelection
	var $vT_table; $vT_relation_many : Text
	$vT_table:=This:C1470._get_tableName_from_ES($c4ES_selection)
	$vT_relation_many:=$vT_table+"_"+$vT_related
	$c4ES_related:=$c4ES_selection[$vT_relation_many]
	
	
Function _aj_delete_push($vC_aj_delete : Collection; $c4ES : 4D:C1709.EntitySelection; $is_delete : Boolean)
	var $tt : Integer
	var $vJ_table : Object
	$tt:=$c4ES.length
	If ($tt>0)
		$vJ_table:=New object:C1471
		$vJ_table.c4ES:=$c4ES
		$vJ_table.l_count:=$tt
		$vJ_table.is_delete:=$is_delete
		$vC_aj_delete.push($vJ_table)
	End if 
	
Function _do_set_deletable($is_delete : Boolean)
	var $vC_aj_delete : Collection
	var $vJ_table : Object
	$vC_aj_delete:=This:C1470._get_aj_delete()
	If ($vC_aj_delete.length>0)
		$vJ_table:=$vC_aj_delete[0]
		$vJ_table.is_delete:=$is_delete
	End if 
	
	
Function _get_tableName_from_ES($c4ES_selection : 4D:C1709.EntitySelection)->$vT_table : Text
	var $c4DC_table : 4D:C1709.DataClass
	var $vJ_table : Object
	$c4DC_table:=$c4ES_selection.getDataClass()
	$vJ_table:=$c4DC_table.getInfo()
	$vT_table:=$vJ_table.name
	// *
	// *****
	
	
	// *****
	// *
Function _nothingToDelete()
	waz_io_alert(zen_get_localized(k_rsct_alert; "delete_nothing"))
	
	
Function _records_delete($vC_aj_delete : Collection; $vT_table : Text; $is_entity : Boolean; $is_cancel : Boolean)->$isOk : Boolean
	var $c4ES_toDelete; $c4ES_notDeleted : 4D:C1709.EntitySelection
	var $is_msg; $is_transaction; $is_deletable; $is_toDelete; $is_separator1; $is_separator2 : Boolean
	var $vL_delete_count; $vL_table_count; $vL_related_count; $idx : Integer
	var $vJ_j_io_red; $vJ_j_io_orange; $vJ_table; $vJ_related : Object
	var $vT_subtitle; $vT_table1; $vT_title; $vT_mustBeEmpty; $vT_related; $vT_progress_uid : Text
	
	//$is_cancel:=This.is_cancel
	//$is_entity:=This.is_entity$is_cancel
	$is_msg:=This:C1470.is_msg
	
	$is_transaction:=Not:C34(Active transaction:C1387)
	
	$vJ_j_io_red:=OB Copy:C1225(app__storage_stuff.j_io_red)
	$vJ_j_io_orange:=OB Copy:C1225(app__storage_stuff.j_io_orange)
	
	$vL_delete_count:=$vC_aj_delete.length
	$is_deletable:=False:C215
	$isOk:=True:C214  // Ok if no records
	If (($vL_delete_count>0))
		$vT_subtitle:=""
		$isOk:=False:C215
		
		$vJ_table:=$vC_aj_delete[0]
		
		$vT_table1:=This:C1470._get_tableName_from_ES($vJ_table.c4ES)
		If ($vT_table#$vT_table1)
			TRACE:C157
		End if 
		$vL_table_count:=$vJ_table.l_count
		$is_toDelete:=$vJ_table.is_delete
		If ($is_toDelete)
			If ($is_cancel)
				$vT_title:=zen_get_localized(k_rsct_alert; "delete_cancel")+" "+wox_table_name_txt($vT_table)
			Else 
				$vT_title:=zen_get_localized(k_rsct_alert; "delete_txt")+" "+This:C1470._records_txt($vL_table_count)+" "+zen_get_localized(k_rsct_alert; "delete_of")+" "+wox_table_name_txt($vT_table)
			End if 
			$vT_subtitle:=""
			$vT_mustBeEmpty:=""
			$is_deletable:=True:C214
			If ($vL_delete_count>1)
				$is_separator1:=False:C215
				$is_separator2:=False:C215
				For each ($vJ_related; $vC_aj_delete; 1)
					$vT_related:=This:C1470._get_tableName_from_ES($vJ_related.c4ES)
					$vL_related_count:=$vJ_related.l_count
					$is_toDelete:=$vJ_related.is_delete
					If ($is_separator1)
						$vT_subtitle+=", "
					Else 
						$vT_subtitle:=zen_get_localized(k_rsct_alert; "delete_related")+": "
						$is_separator1:=True:C214
					End if 
					$vT_subtitle+=wox_table_name_txt($vT_related)+" "+This:C1470._records_txt($vL_related_count)
					If (Not:C34($is_toDelete))
						If ($is_deletable)
							If ($is_cancel)
								$vT_title:=zen_get_localized(k_rsct_alert; "delete_cancel_nok")+" "+wox_table_name_txt($vT_table)
							Else 
								$vT_title:=zen_get_localized(k_rsct_alert; "delete_nok")+" "+This:C1470._records_txt($vL_table_count)+" "+zen_get_localized(k_rsct_alert; "delete_of")+" "+wox_table_name_txt($vT_table)
							End if 
							$is_deletable:=False:C215
						End if 
						If ($is_separator2)
							$vT_mustBeEmpty+=", "
						Else 
							$is_separator2:=True:C214
						End if 
						$vT_mustBeEmpty+=wox_table_name_txt($vT_related)+" "+This:C1470._records_txt($vL_related_count)
					End if 
				End for each 
			End if 
			
			If ($is_deletable)
				$isOk:=True:C214
				If ($is_msg)
					$isOk:=waz_io_confirm($vT_title+"?"; $vT_subtitle; "trash"; ""; ""; $vJ_j_io_orange)  //;"Ok";"Annuler")
					//End if
					If ($isOk)
						If (Not:C34($is_entity))  // Double check if not entity
							$isOk:=waz_io_confirm(zen_get_localized(k_rsct_alert; "delete_undone"); zen_get_localized(k_rsct_alert; "delete_sure"); "trash"; ""; ""; $vJ_j_io_red)
						End if 
					End if 
				End if 
				
				// ***** DELETE !
				// *
				If ($isOk)
					If ($is_transaction)
						zen__ds.startTransaction()  // Transaction !
					End if 
					$vT_progress_uid:=waz_progress_new(zen_get_localized(k_rsct_alert; "delete_progress"))
					$idx:=0
					For each ($vJ_related; $vC_aj_delete)
						$c4ES_toDelete:=$vJ_related.c4ES
						$vT_related:=This:C1470._get_tableName_from_ES($c4ES_toDelete)
						$vL_related_count:=$vJ_related.l_count
						waz_progress_subtitle($vT_progress_uid; $vT_related+", "+This:C1470._records_txt($vL_related_count))
						//$is_toDelete:=$vJ_table.is_delete
						//If ($is_oneEntity && ($idx=0))
						//// Remove only record, not selection...
						//Else 
						$c4ES_notDeleted:=$c4ES_toDelete.drop(dk stop dropping on first error:K85:26)
						$isOk:=($c4ES_notDeleted.length=0)
						If (Not:C34($isOk))
							break
						End if 
						//End if 
						$idx+=1
					End for each 
					waz_progress_quit($vT_progress_uid)
					If ($isOk)
						If ($is_transaction)
							zen__ds.validateTransaction()  // Transaction !
						End if 
					Else 
						waz_io_alert(zen_get_localized(k_rsct_alert; "delete_locked"); ""; "forbidden"; ""; $vJ_j_io_orange)
						If ($is_transaction)
							zen__ds.cancelTransaction()  // Transaction !
						End if 
					End if 
					// *
					// *****
					
				End if 
			Else 
				$vT_subtitle:=zen_get_localized(k_rsct_alert; "delete_notEmpty")+": "+$vT_mustBeEmpty+(Char:C90(Carriage return:K15:38)*2)+$vT_subtitle
				waz_io_alert($vT_title; $vT_subtitle; "forbidden"; ""; $vJ_j_io_red)  //;"Ok")
				$is_deletable:=True:C214  // No message below
			End if 
		Else 
			$isOk:=False:C215
		End if 
	End if 
	
	If (Not:C34($isOk)) && (Not:C34($is_deletable))
		If ($is_cancel)
			$vT_title:=zen_get_localized(k_rsct_alert; "delete_cancel_nok")+" "+wox_table_name_txt($vT_table)
			$vT_subtitle:=""
		Else 
			$vT_title:=zen_get_localized(k_rsct_alert; "delete_cancel_records_nok")+"!"
			$vT_subtitle:=This:C1470._records_txt($vL_table_count)+" "+zen_get_localized(k_rsct_alert; "delete_of")+" "+wox_table_name_txt($vT_table)
		End if 
		$vT_title+=" !"
		waz_io_alert($vT_title; $vT_subtitle; "forbidden"; ""; $vJ_j_io_red)
	End if 
	
	
Function _records_txt($vL_count : Integer)->$vT_records : Text
	$vT_records:=wox_str_pluralise($vL_count; zen_get_localized(k_rsct_alert; "delete_record"))
	// *
	// *****
	
	