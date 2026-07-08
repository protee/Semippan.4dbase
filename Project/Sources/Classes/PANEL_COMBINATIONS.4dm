
Class constructor
	This:C1470.form_init()
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
			//: ($vL_event_code=On Clicked)
			//Case of 
			//: ($vT_objectName="bt_animate")
			//This.do_animate()
			
			//End case 
			
			////: ($vL_event_code=On Double Clicked)
			
		: ($vL_event_code=On Timer:K2:25)
			SET TIMER:C645(0)
			This:C1470.combinations_redraw()
			
		: ($vL_event_code=On Resize:K2:27)
			SET TIMER:C645(1)
			
			//: ($vL_event_code=On Data Change)
			
	End case 
	// *
	// *****
	
	
Function form_init()
	wox_prefs_windows_load()
	//If (Not(Bool(Form.is_moved)))
	//$vL_winRef:=Current form window
	//$cs_ZEN__FORM_MOVE:=cs.ZEN__FORM_MOVE.new($vL_winRef)
	//Form.is_moved:=True
	//End if 
	//This._l_veda_last:=0
	//This.record_load_upd()
	
	
Function record_load_upd()
	//var $vJ_veda; $vJ_prefs : Object
	//var $c4E_entity : 4D.Entity
	//var $vV_UID : Variant
	//This._is_deploy:=True
	//This._is_run:=False
	//$vJ_veda:=OBJECT Get value("sem_veda")
	//$vJ_veda.r_progress:=0
	//$vJ_prefs:=Form.j_prefs
	//$vV_UID:=$vJ_prefs.UIDkaviyam
	//$c4E_entity:=ds.KAVIYAM.get($vV_UID)
	//Form.c4E:=$c4E_entity
	//If ($c4E_entity.isRun)
	//This.do_KAVIYAM_redraw()
	//Else 
	//This.KAVIYAM_redraw(True)
	//End if 
	
	
Function combinations_redraw()
	var $vJ_woc_alColors : Object
	$vJ_woc_alColors:=OBJECT Get value:C1743("woc_alColors")
	$vJ_woc_alColors.resize()
	$vJ_woc_alColors.redraw()
	
	