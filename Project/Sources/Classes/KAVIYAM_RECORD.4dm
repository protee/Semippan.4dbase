
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	var $vJ_veda : Object
	var $c4E_entity : 4D:C1709.Entity
	Super:C1706.record_load_upd()
	This:C1470._is_deploy:=True:C214
	This:C1470._is_run:=False:C215
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vJ_veda.r_progress:=0
	$c4E_entity:=Form:C1466.c4E
	If ($c4E_entity.isRun)
		This:C1470.do_KAVIYAM_redraw()
	Else 
		This:C1470.KAVIYAM_redraw(True:C214)
	End if 
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=Form:C1466.is_touched
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched()
	End if 
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
	//Function record_save($c4E_entity : 4D.Entity)
	//Super.record_save($c4E_entity)
	
	// *
	// *****
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code; $vL_timer; $vL_index : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent; $vJ_veda; $vJ_screens_form : Object
	var $vT_objectName : Text
	var $is_init; $is_deploy; $is_end : Boolean
	var $vR_progress; $vR_step : Real
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="bt_copy")
					This:C1470.do_copy()
					
				: ($vT_objectName="bt_animate")
					This:C1470.do_animate()
					
			End case 
			
			//: ($vL_event_code=On Double Clicked)
			//Case of 
			//: ($vT_objectName="oO_svg")
			//This._copy_PP($vT_objectName)
			
			//: ($vT_objectName="oO_svg1")
			//This._copy_PP($vT_objectName)
			//End case 
			
			
		: ($vL_event_code=On Timer:K2:25)
			$vJ_screens_form:=Form:C1466._j_form
			$vL_index:=Num:C11($vJ_screens_form.l_tab)
			If ($vL_index=0)
				If (This:C1470._is_run)
					$is_deploy:=This:C1470._is_deploy
					$is_init:=This:C1470._is_init
					This:C1470._is_init:=False:C215
					$vJ_veda:=OBJECT Get value:C1743("sem_veda")
					$vR_progress:=$vJ_veda.r_progress
					$vR_step:=0.09
					$vR_progress+=$is_deploy ? $vR_step : -$vR_step
					$is_end:=$is_deploy ? ($vR_progress>=1) : ($vR_progress<=0)
					If ($is_end)
						$vR_progress:=$is_deploy ? 1 : 0
						This:C1470._is_run:=False:C215
						$vL_timer:=0
					Else 
						$vL_timer:=1
					End if 
					$vJ_veda.r_progress:=$vR_progress
					This:C1470.KAVIYAM_redraw($is_init)
				Else 
					This:C1470.KAVIYAM_redraw()
					$vL_timer:=0
				End if 
			Else 
				$vL_timer:=0
			End if 
			SET TIMER:C645($vL_timer)
			
			
		: ($vL_event_code=On Resize:K2:27)
			SET TIMER:C645(1)
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
Function do_animate()
	var $vJ_veda : Object
	var $vR_progress : Real
	var $vC_aj_values : Collection
	$vC_aj_values:=New collection:C1472()
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vR_progress:=$vJ_veda.r_progress
	//If ($vR_progress=0)
	//This._is_deploy:=True
	//This.do_KAVIYAM_redraw()
	//Else 
	//$vJ_veda.r_progress:=0
	//This.KAVIYAM_redraw(True)
	//SET TIMER(0)
	//End if 
	This:C1470._is_deploy:=($vR_progress<=0)
	This:C1470.do_KAVIYAM_redraw()
	
	
Function do_KAVIYAM_redraw()
	This:C1470._is_init:=True:C214
	This:C1470._is_run:=True:C214
	SET TIMER:C645(1)
	
	
Function KAVIYAM_redraw($is_init : Boolean)
	//var $vL_index : Integer
	//var $vJ_screens_form : Object
	var $c4E : 4D:C1709.Entity
	var $vL_index : Integer
	var $vJ_screens_form; $vJ_SLOKAS; $vJ_veda : Object
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	$vJ_screens_form:=Form:C1466._j_form
	$vL_index:=Num:C11($vJ_screens_form.l_tab)
	If ($vL_index=0)
		$vJ_veda:=OBJECT Get value:C1743("sem_veda")
		If ($is_init)
			$c4E:=Form:C1466.c4E
			$vJ_SLOKAS:=OBJECT Get value:C1743("zen_SLOKAS")
			//$cES_SLOKAS:=$vJ_SLOKAS.lb_selected
			//$cES_SLOKAS:=($cES_SLOKAS.length>0) ? $cES_SLOKAS : $vJ_SLOKAS.lb_selection  // Takes all active
			$cES_SLOKAS:=$vJ_SLOKAS.lb_selection  //.query("isActive = true").orderBy("order")
			$vJ_veda.cE_KAVIYAM:=$c4E
			$vJ_veda.cES_SLOKAS:=$cES_SLOKAS
			$vJ_veda.j_prefs:=$c4E.j_veda_prefs
			$vJ_veda.is_contract:=Not:C34(This:C1470._is_deploy)
		End if 
		$vJ_veda.is_links:=($vJ_veda.r_progress>=1)
		$vJ_veda.resize()
		$vJ_veda.redraw()
	End if 
	
	
Function _veda_chgt($vJ_widget : Object)
	//$vL_value:=$vJ_widget.l_value
	//If ($vL_value<0)
	//This.do_animate()
	//End if 
	//If (Not(Right click))
	If (Right click:C712)
		This:C1470.do_animate()
	End if 
	
	
Function _vedaPrefs_chge($vJ_widget : Object)
	This:C1470.do_KAVIYAM_redraw()
	
	
	
	// *****
	// *
Function do_copy()
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vJ_SLOKAS : Object
	var $vT_answer : Text
	$vJ_SLOKAS:=OBJECT Get value:C1743("zen_SLOKAS")
	$cES_SLOKAS:=$vJ_SLOKAS.lb_selected  // Takes selected or selection
	$cES_SLOKAS:=($cES_SLOKAS.length>0) ? $cES_SLOKAS : $vJ_SLOKAS.lb_selection
	$vT_answer:=""
	For each ($cE_SLOKAS; $cES_SLOKAS)
		$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
		$vT_answer+="–––––––––––"+$cE_PRODUCTS.label+"–––––––––––––"+Char:C90(Carriage return:K15:38)
		$vT_answer+=$cE_PRODUCTS.title+Char:C90(Carriage return:K15:38)
		$vT_answer+=$cE_PRODUCTS.subtitle+Char:C90(Carriage return:K15:38)
		$vT_answer+="Mantra: "+$cE_PRODUCTS.mantra+Char:C90(Carriage return:K15:38)
		$vT_answer+="Tagline: "+$cE_PRODUCTS.tagline+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	End for each 
	SET TEXT TO PASTEBOARD:C523($vT_answer)
	wox_sounds_play_tick()
	// *
	// *****
	
	