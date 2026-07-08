
Class constructor($is_transaction : Boolean)
	var $vT_table; $vT_title; $vT_tag; $vT_state : Text
	var $is_local : Boolean
	var $cs_ZEN__FORM_MOVE : cs:C1710.ZEN__FORM_MOVE
	var $vL_winRef : Integer
	
	// *****
	// *
	If (Count parameters:C259>=1)  // Keep Form value if not given
		Form:C1466.is_transaction:=$is_transaction
	End if 
	
	zen_startup_screen_get_menuBar()
	
	$is_local:=Form:C1466.is_local
	$vT_table:=Form:C1466.t_table
	
	$vT_title:=zenh_localized(k_rsct_table; $vT_table; $is_local)
	If (Form:C1466.is_new)
		$vT_tag:=Form:C1466.is_dup ? "dup" : "add"
	Else 
		$vT_tag:=Form:C1466.is_editing ? "mod" : "cons"
	End if 
	$vT_state:=zen_get_localized(k_rsct_help; "title_"+$vT_tag)
	SET WINDOW TITLE:C213($vT_title+" — "+$vT_state)
	
	If (Not:C34(Bool:C1537(Form:C1466.is_moved)))
		$vL_winRef:=Current form window:C827
		$cs_ZEN__FORM_MOVE:=cs:C1710.ZEN__FORM_MOVE.new($vL_winRef)
		Form:C1466.is_moved:=True:C214
	End if 
	// *
	// *****
	
	
	// ***** User members
	// *
Function linked_related_ones($vT_ordaPath : Text)->$vC_c4E_related : Collection
	$vC_c4E_related:=zen_linked_related_ones($vT_ordaPath)  // Wrapper
	
Function linked_related_one($vT_relateOne : Text)->$c4E_related : 4D:C1709.Entity
	$c4E_related:=zen_linked_related_one($vT_relateOne)  // Wrapper
	// *
	// *****
	
	
	// ***** Generic members
	// *
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=$c4E_record.touched()
	
	
Function record_accept()
	This:C1470.record_unload()
	ACCEPT:C269
	
	
Function record_cancel()
	This:C1470.record_unload()
	CANCEL:C270
	
	
Function record_unload()
	//var $vL_winRef : Integer
	//var $vT_table : Text
	//$vT_table:=Form.t_table
	//$vL_winRef:=Current form window
	//wox_window_push_wh($vT_table+"_record"; $vL_winRef)
	//wox_window_release($vL_winRef)
	
	
Function record_load_upd()
	This:C1470.form_modify()
	This:C1470.zen_record_upd()
	
	
Function form_modify()
	var $is_new; $is_editing : Boolean
	var $vC_at_objects_nc : Collection
	$vC_at_objects_nc:=This:C1470.at_objects_nc
	$is_new:=Form:C1466.is_new
	$is_editing:=Form:C1466.is_editing
	zen_record_enterable($is_new; $is_editing; $vC_at_objects_nc)
	
	
Function zen_record_upd()
	var $vP_zen_record : Pointer
	var $vT_zen_record : Text
	$vT_zen_record:="zen_record"
	$vP_zen_record:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_zen_record)
	If ($vP_zen_record#Null:C1517)
		OBJECT SET BORDER STYLE:C1262(*; $vT_zen_record; Border None:K42:27)
		$vP_zen_record->:=$vP_zen_record->
	End if 
	
	
Function record_save($c4E_entity : 4D:C1709.Entity)
	var $vJ_statut : Object
	$c4E_entity:=($c4E_entity#Null:C1517) ? $c4E_entity : Form:C1466.c4E
	$vJ_statut:=zen_entity_save($c4E_entity)
	If (Form:C1466.is_transaction)
		zen__ds.validateTransaction()  // Transaction !
	End if 
	//$is_new:=$c4E_entity.isNew()
	//$is_new:=Form.is_new
	//If ($is_new)
	//$c4ES_selection:=Form.c4ES
	//If ($c4ES_selection#Null)
	////Use ($c4ES_selection)
	////$c4ES_selection:=$c4ES_selection.add($c4E_entity)
	////End use
	
	//If (OB Is shared($c4ES_selection))
	////$c4ES_selection:=$c4ES_selection.copy().add($c4E_entity)
	////$c4ES_selection:=$c4ES_selection.copy(ck shared)
	////$c4ES_selection:=$c4ES_selection.copy().add($c4E_entity).copy(ck shared)
	//Form.c4ES:=Form.c4ES.copy().add($c4E_entity).copy(ck shared)
	//Else 
	//Form.c4ES:=Form.c4ES.add($c4E_entity)
	//End if 
	
	//End if 
	//End if 
	
	
Function zen_record_events($vT_action : Text)
	var $c4E_record : 4D:C1709.Entity
	var $is_new; $isOk : Boolean
	var $vJ_form : Object
	$vJ_form:=Form:C1466
	
	Case of 
			// *****
			// *
		: ($vT_action="cancel")
			$isOk:=This:C1470._do_cancelTransaction()
			If ($isOk)
				This:C1470.record_cancel()
			End if 
			
		: ($vT_action="accept")
			If (Form:C1466.fc.record_checkout())
				$c4E_record:=Form:C1466.c4E
				Form:C1466.fc.record_save($c4E_record)
				This:C1470.record_accept()
			End if 
			
			
		: ($vT_action="closeBox")
			If (This:C1470.record_okForChange($vJ_form; 0))
				This:C1470.record_cancel()
			End if 
			
		: ($vT_action="popup")
			If (This:C1470.record_okForChange($vJ_form; 0))
				Form:C1466.t_action:=$vT_action
				This:C1470.record_cancel()
			End if 
			
		: ($vT_action="editing")
			$is_new:=$vJ_form.is_new
			If (Not:C34($is_new))
				If (This:C1470.record_okForChange($vJ_form; 1))
					Form:C1466.t_action:=$vT_action
					This:C1470.record_cancel()
				End if 
			End if 
			
		Else 
			If ($vT_action#"")
				If (This:C1470.record_okForChange($vJ_form; 2))
					Form:C1466.t_action:=$vT_action
					This:C1470.record_cancel()
				End if 
			End if 
	End case 
	
	
Function record_okForChange($vJ_form : Object; $vL_autosave : Integer)->$isCancel : Boolean
	// $vL_autosave : 0 closeBox ; 1 modify ; 2 navigation
	var $c4E_record : 4D:C1709.Entity
	var $is_touched; $is_editing; $is_toSave : Boolean
	var $vL_answer : Integer
	var $vJ_zen_record : Object
	$c4E_record:=$vJ_form.c4E
	$is_touched:=False:C215
	$is_editing:=Form:C1466.is_editing
	If ($is_editing)
		$is_touched:=Form:C1466.fc.record_touched($c4E_record)
	End if 
	$isCancel:=Not:C34($is_touched)
	If ($is_touched)
		// Checkout
		$isCancel:=Form:C1466.fc.record_checkout()
		If ($isCancel)  // OK Checkout
			$is_toSave:=This:C1470.get_autoSave($vL_autosave)
			If (Not:C34($is_toSave))
				$vJ_zen_record:=OBJECT Get value:C1743("zen_record")
				$vL_answer:=zen_record_dontCancelSave($vJ_form)  // 2 Don't save ; 0 Cancel ; 1 Save
				$isCancel:=($vL_answer#0)
				$is_toSave:=($vL_answer=1)  // TO SAVE ?
			End if 
			If ($is_toSave)
				$vJ_form.fc.record_save($c4E_record)
			End if 
		End if 
	End if 
	If ($isCancel)
		$isCancel:=This:C1470._do_cancelTransaction()
	End if 
	
	
Function _do_cancelTransaction()->$isOk : Boolean
	var $cs_ZENH_DELETE : cs:C1710.ZENH_DELETE
	var $c4E_entity : 4D:C1709.Entity
	var $is_new; $is_editing : Boolean
	var $vT_table : Text
	$is_new:=Form:C1466.is_new
	$is_editing:=Form:C1466.is_editing
	$isOk:=True:C214
	If ($is_editing)
		If (Form:C1466.is_transaction)
			zen__ds.cancelTransaction()  // Transaction !
		Else 
			If ($is_new)
				$cs_ZENH_DELETE:=cs:C1710.ZENH_DELETE.new()
				$vT_table:=Form:C1466.t_table
				$c4E_entity:=Form:C1466.c4E
				$isOk:=$cs_ZENH_DELETE.record_delete($vT_table; $c4E_entity; True:C214)  // Mode cancel
			End if 
		End if 
	End if 
	
	
Function get_autoSave($vL_autosave : Integer)->$is_autoSave : Boolean
	var $vJ_userPrefs : Object
	$vJ_userPrefs:=zen__storage_prefs.j_userPrefs
	Case of 
		: ($vL_autosave=0)
			$is_autoSave:=$vJ_userPrefs.is_as_closeBox
		: ($vL_autosave=1)
			$is_autoSave:=$vJ_userPrefs.is_as_editing
		: ($vL_autosave=2)
			$is_autoSave:=$vJ_userPrefs.is_as_navigate
			
	End case 
	// *
	// *****
	
	