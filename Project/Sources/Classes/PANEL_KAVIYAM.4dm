
property _is_run; _is_deploy; _is_init; _is_settings : Boolean
property _l_veda_last : Integer
property j_registered : Object

Class constructor
	zen_startup_screen_get_menuBar()
	This:C1470.form_init()
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code; $vL_index; $vL_timer : Integer
	var $vJ_formEvent; $vJ_screens_form; $vJ_veda : Object
	var $vT_objectName : Text
	var $is_deploy; $is_init; $is_end : Boolean
	var $vR_progress; $vR_step : Real
	
	$vL_event_code:=Form event code:C388
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="bt_settings")
					This:C1470._do_settings_enable()
				: ($vT_objectName="bt_save")
					This:C1470._do_settings_save()
					
					//: ($vT_objectName="bt_animate")
					//This.do_animate()
					
				: ($vT_objectName="bt_up")
					This:C1470._veda_previous()
					
				: ($vT_objectName="bt_down")
					This:C1470._veda_next()
					
				: ($vT_objectName="bt_left")
					This:C1470._previous()
					
				: ($vT_objectName="bt_right")
					This:C1470._next()
					
				: ($vT_objectName="bt_expand")
					This:C1470._expand()
					
				: ($vT_objectName="bt_deselect")
					This:C1470._deselect()
					
			End case 
			
			
			//: ($vL_event_code=On Double Clicked)
			
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
					//$vR_step:=0.09
					$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
					$vR_step:=$cE_KAVIYAM.j_veda_prefs.l_speed/100  // From 0.01 to 0.09
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
					This:C1470.sloka_resize()
					$vL_timer:=0
				End if 
			Else 
				$vL_timer:=0
			End if 
			SET TIMER:C645($vL_timer)
			
		: ($vL_event_code=On Resize:K2:27)
			This:C1470.sloka_resize()
			This:C1470.cards_resize()
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
	This:C1470._is_settings:=False:C215
	This:C1470._l_veda_last:=0
	This:C1470.record_load_upd()
	
	
Function record_load_upd()
	var $vJ_veda; $vJ_prefs : Object
	var $vV_UID : Variant
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	This:C1470._is_deploy:=True:C214
	This:C1470._is_run:=False:C215
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vJ_veda.r_progress:=0
	$vJ_prefs:=Form:C1466.j_prefs
	$vV_UID:=$vJ_prefs.UIDkaviyam
	$cE_KAVIYAM:=ds:C1482.KAVIYAM.get($vV_UID)
	//If ($cE_KAVIYAM=Null)
	//$cE_KAVIYAM:=ds.KAVIYAM.query("isActive = True").orderBy("label").first()
	//End if 
	
	If ($cE_KAVIYAM#Null:C1517)
		Form:C1466.cE_KAVIYAM:=$cE_KAVIYAM
		This:C1470.cards_init($cE_KAVIYAM)
		
		This:C1470.KAVIYAM_init($cE_KAVIYAM)
		If ($cE_KAVIYAM.isRun) && False:C215
			This:C1470.do_KAVIYAM_redraw()
		Else 
			This:C1470.KAVIYAM_redraw(True:C214)
		End if 
		This:C1470.sloka_display(-1)
		This:C1470._do_settings_enable(False:C215)
		This:C1470.sloka_resize(True:C214)
	Else 
		This:C1470._do_settings_enable(False:C215)
	End if 
	
	
Function cards_init($cE_KAVIYAM : cs:C1710.KAVIYAMEntity)
	var $vC_aj_cards : Collection
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $vJ_card; $vJ_sem_cards : Object
	var $is_product; $is_pro_app : Boolean
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vL_colors : Integer
	var $vO_product : Picture
	var $vT_product : Text
	$cES_SLOKAS:=$cE_KAVIYAM.KAVIYAM_SLOKAS.orderBy("order")
	$vC_aj_cards:=New collection:C1472()
	For each ($cE_SLOKAS; $cES_SLOKAS)
		$vJ_card:=New object:C1471()
		$vC_aj_cards.push($vJ_card)
		$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
		$vL_colors:=$cE_SLOKAS.colors
		$is_product:=$cE_PRODUCTS#Null:C1517
		If ($is_product)
			$vT_product:=$is_pro_app ? $cE_PRODUCTS.app : $cE_PRODUCTS.label
			$vL_colors:=$vL_colors#0 ? $vL_colors : $cE_PRODUCTS.colors
			$vO_product:=$cE_PRODUCTS.logo
		Else 
			$vT_product:=$cE_SLOKAS.label
			$vO_product:=$cE_SLOKAS.logo
		End if 
		$vJ_card.l_colors:=$vL_colors
		$vJ_card.o_icon:=$vO_product
	End for each 
	$vJ_sem_cards:=OBJECT Get value:C1743("sem_cards")
	$vJ_sem_cards.aj_cards:=$vC_aj_cards
	$vJ_sem_cards.l_value:=-1
	$vJ_sem_cards.redraw()
	
	
Function do_animate()
	var $vJ_veda : Object
	var $vR_progress : Real
	var $vC_aj_values : Collection
	$vC_aj_values:=New collection:C1472()
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vR_progress:=$vJ_veda.r_progress
	This:C1470._is_deploy:=($vR_progress<=0)
	This:C1470.do_KAVIYAM_redraw()
	
	
Function do_KAVIYAM_redraw()
	This:C1470._is_init:=True:C214
	This:C1470._is_run:=True:C214
	SET TIMER:C645(1)
	
	
Function KAVIYAM_init($cE_KAVIYAM : cs:C1710.KAVIYAMEntity)
	var $vJ_veda_prefs; $vJ_sem_veda; $vJ_sem_veda_prefs : Object
	//$cE_KAVIYAM:=Form.cE_KAVIYAM
	If ($cE_KAVIYAM#Null:C1517)
		$vJ_veda_prefs:=$cE_KAVIYAM.j_veda_prefs
		$vJ_sem_veda:=OBJECT Get value:C1743("sem_veda")
		$vJ_sem_veda.j_prefs:=$vJ_veda_prefs
		$vJ_sem_veda_prefs:=OBJECT Get value:C1743("sem_veda_prefs")
		$vJ_sem_veda_prefs.j_value:=$vJ_veda_prefs
		$vJ_sem_veda_prefs.resize()
		If (This:C1470._is_settings)
			$vJ_sem_veda_prefs.redraw()
		End if 
	End if 
	
	
Function KAVIYAM_redraw($is_init : Boolean)
	//var $vL_index : Integer
	//var $vJ_screens_form : Object
	var $vL_index : Integer
	var $vJ_screens_form; $vJ_sem_veda : Object
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	$vJ_screens_form:=Form:C1466._j_form
	$vL_index:=Num:C11($vJ_screens_form.l_tab)
	If ($vL_index=0)
		$vJ_sem_veda:=OBJECT Get value:C1743("sem_veda")
		If ($is_init)
			$vJ_sem_veda.l_value:=0  // Deselect
			$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
			If ($cE_KAVIYAM#Null:C1517)
				//$vJ_veda_prefs:=$cE_KAVIYAM.j_veda_prefs
				//$vJ_SLOKAS:=OBJECT Get value("zen_SLOKAS")
				//$cES_SLOKAS:=$vJ_SLOKAS.lb_selection  //.query("isActive = true").orderBy("order")
				$cES_SLOKAS:=$cE_KAVIYAM.KAVIYAM_SLOKAS.orderBy("order")
				$vJ_sem_veda.cE_KAVIYAM:=$cE_KAVIYAM
				$vJ_sem_veda.cES_SLOKAS:=$cES_SLOKAS
				$vJ_sem_veda.is_contract:=Not:C34(This:C1470._is_deploy)
				
				//$vJ_sem_veda.j_prefs:=$vJ_veda_prefs
				//$vJ_sem_veda_prefs:=OBJECT Get value("sem_veda_prefs")
				//$vJ_sem_veda_prefs.j_value:=$vJ_veda_prefs
				//$vJ_sem_veda_prefs.resize()
				//If (This._is_settings)
				//$vJ_sem_veda_prefs.redraw()
				//End if 
			End if 
		End if 
		$vJ_sem_veda.is_links:=($vJ_sem_veda.r_progress>=1)
		$vJ_sem_veda.resize()
		$vJ_sem_veda.redraw()
	End if 
	
	
Function _do_settings_enable($is_enable : Boolean)
	var $vJ_sem_veda_prefs : Object
	var $vP_btn : Pointer
	var $vT_sem_veda_prefs : Text
	If (Count parameters:C259<1)
		$is_enable:=Not:C34(This:C1470._is_settings)
	End if 
	$vP_btn:=OBJECT Get pointer:C1124(Object named:K67:5; "bt_settings")
	x_btn_toggleSet($vP_btn; Num:C11($is_enable))
	This:C1470._is_settings:=$is_enable
	OBJECT SET VISIBLE:C603(*; "bt_save"; $is_enable)
	$vT_sem_veda_prefs:="sem_veda_prefs"
	OBJECT SET VISIBLE:C603(*; $vT_sem_veda_prefs; $is_enable)
	If ($is_enable) || True:C214
		//This.sem_weda_settings_upd()
		$vJ_sem_veda_prefs:=OBJECT Get value:C1743($vT_sem_veda_prefs)
		$vJ_sem_veda_prefs.resize()
		$vJ_sem_veda_prefs.redraw()
	End if 
	
	
Function _vedaPrefs_chge($vJ_widget : Object)
	This:C1470.KAVIYAM_redraw()
	This:C1470.sloka_redraw()
	
	
Function _do_settings_save()
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
	If ($cE_KAVIYAM#Null:C1517)
		zen_entity_save($cE_KAVIYAM)
	End if 
	// *
	// *****
	
	
Function _veda_previous()
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	var $cES_KAVIYAM; $cES_KAVIYAM1 : cs:C1710.KAVIYAMSelection
	var $idx : Integer
	var $vJ_zen_kaviyam; $vJ_prefs; $vJ_ranges; $vJ_range : Object
	var $vC_ranges : Collection
	$vJ_zen_kaviyam:=OBJECT Get value:C1743("zen_kaviyam")
	$cES_KAVIYAM:=$vJ_zen_kaviyam.cES_KAVIYAM
	$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
	$cES_KAVIYAM1:=ds:C1482.KAVIYAM.newSelection().add($cE_KAVIYAM)
	$vJ_ranges:=$cES_KAVIYAM.selected($cES_KAVIYAM1)
	$vC_ranges:=$vJ_ranges.ranges
	$vJ_range:=$vC_ranges[0]
	$idx:=$vJ_range.start
	If ($idx>0)
		$vJ_prefs:=Form:C1466.j_prefs
		$vJ_prefs.UIDkaviyam:=$cES_KAVIYAM[$idx-1].UID
		$vJ_zen_kaviyam.redraw()
		This:C1470.record_load_upd()
	Else 
		wox_sounds_play_edit()
	End if 
	
	
Function _veda_next()
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	var $cES_KAVIYAM; $cES_KAVIYAM1 : cs:C1710.KAVIYAMSelection
	var $idx; $tt : Integer
	var $vJ_zen_kaviyam; $vJ_prefs; $vJ_ranges; $vJ_range : Object
	var $vC_ranges : Collection
	$vJ_zen_kaviyam:=OBJECT Get value:C1743("zen_kaviyam")
	$cES_KAVIYAM:=$vJ_zen_kaviyam.cES_KAVIYAM
	$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
	$cES_KAVIYAM1:=ds:C1482.KAVIYAM.newSelection().add($cE_KAVIYAM)
	$vJ_ranges:=$cES_KAVIYAM.selected($cES_KAVIYAM1)
	$vC_ranges:=$vJ_ranges.ranges
	$vJ_range:=$vC_ranges[0]
	$idx:=$vJ_range.start
	$tt:=$cES_KAVIYAM.length
	$idx+=1
	If ($idx>0) && ($idx<$tt)
		$vJ_prefs:=Form:C1466.j_prefs
		$vJ_prefs.UIDkaviyam:=$cES_KAVIYAM[$idx].UID
		$vJ_zen_kaviyam.redraw()
		This:C1470.record_load_upd()
	Else 
		wox_sounds_play_edit()
	End if 
	
	
Function _previous()
	var $vL_value; $vL_position; $tt : Integer
	var $vJ_veda : Object
	var $isOk : Boolean
	var $vR_progress : Real
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vR_progress:=$vJ_veda.r_progress
	If ($vR_progress=1)
		$vJ_veda:=OBJECT Get value:C1743("sem_veda")
		$vL_value:=$vJ_veda.l_value
		If ($vL_value=0)
			$tt:=$vJ_veda.cES_SLOKAS.length
			$vL_position:=$tt-1  // Form last
			$isOk:=True:C214
		Else 
			$vL_position:=This:C1470._bit_to_position($vL_value)
			$isOk:=($vL_position>0)
			$vL_position-=1
		End if 
		If ($isOk)
			$vL_value:=0x0000 ?+ $vL_position
			$vJ_veda.l_value:=$vL_value
			$vJ_veda.redraw()
			This:C1470._l_veda_last:=$vL_value
			This:C1470.sloka_display($vL_position)
		Else 
			//wox_sounds_play_edit()
			This:C1470._expand()
		End if 
	Else 
		This:C1470._expand()
	End if 
	
Function _next()
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $vL_value; $vL_position; $tt : Integer
	var $vJ_veda : Object
	var $isOk : Boolean
	var $vR_progress : Real
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vR_progress:=$vJ_veda.r_progress
	If ($vR_progress=1)
		$vJ_veda:=OBJECT Get value:C1743("sem_veda")
		$vL_value:=$vJ_veda.l_value
		If ($vL_value=0)
			$vL_position:=0  // Form start
			$isOk:=True:C214
		Else 
			$vL_position:=This:C1470._bit_to_position($vL_value)
			$cES_SLOKAS:=$vJ_veda.cES_SLOKAS
			$tt:=$cES_SLOKAS.length
			$isOk:=($vL_position<($tt-1))
			$vL_position+=1
		End if 
		If ($isOk)
			$vL_value:=0x0000 ?+ $vL_position
			$vJ_veda.l_value:=$vL_value
			$vJ_veda.redraw()
			This:C1470._l_veda_last:=$vL_value
			This:C1470.sloka_display($vL_position)
		Else 
			//wox_sounds_play_edit()
			This:C1470._expand()
		End if 
	Else 
		This:C1470._expand()
	End if 
	
	
Function _deselect()
	var $vL_value : Integer
	var $vJ_veda : Object
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$vL_value:=$vJ_veda.l_value
	If ($vL_value#0)
		$vL_value:=0
		$vJ_veda.l_value:=$vL_value
		$vJ_veda.redraw()
		This:C1470._l_veda_last:=$vL_value
		This:C1470.sloka_display(-1)
	End if 
	
	
Function _expand()
	This:C1470._deselect()
	This:C1470.do_animate()
	
	
Function _veda_chgt($vJ_widget : Object)
	var $vL_value; $vL_value_last; $vL_position : Integer
	$vL_value:=$vJ_widget.l_value
	$vL_value_last:=This:C1470._l_veda_last
	$vL_value:=$vL_value & (-($vL_value_last+1))
	$vL_position:=This:C1470._bit_to_position($vL_value)
	This:C1470._veda_set($vL_position)
	This:C1470._cards_set($vL_position)
	
	
Function _veda_set($vL_position : Integer)
	var $vL_value : Integer
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743("sem_veda")
	$vL_value:=0x0000 ?+ $vL_position
	$vJ_widget.l_value:=$vL_value
	$vJ_widget.redraw()
	This:C1470._l_veda_last:=$vL_value
	This:C1470.sloka_display($vL_position)
	
	
Function _cards_chgt($vJ_widget : Object)
	var $vL_value : Integer
	$vL_value:=$vJ_widget.l_value
	This:C1470._veda_set($vL_value)
	
	
Function _cards_set($vL_value : Integer)
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743("sem_cards")
	$vJ_widget.l_value:=$vL_value
	$vJ_widget.redraw()
	
Function cards_resize()
	var $vJ_sem_cards : Object
	$vJ_sem_cards:=OBJECT Get value:C1743("sem_cards")
	$vJ_sem_cards.redraw()
	$vJ_sem_cards.resize()
	
	
Function _bit_to_position($vL_value : Integer)->$vL_position : Integer
	var $is_one : Boolean
	$vL_position:=-1
	If ($vL_value>0)
		Repeat 
			$vL_position+=1
			$is_one:=$vL_value ?? $vL_position
		Until ($is_one)
	End if 
	
	
Function sloka_display($vL_position : Integer)
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $vJ_veda; $vJ_sem_sloka : Object
	var $is_selected : Boolean
	$vJ_veda:=OBJECT Get value:C1743("sem_veda")
	$cES_SLOKAS:=$vJ_veda.cES_SLOKAS
	$is_selected:=($vL_position>=0)
	If ($is_selected)
		$cE_SLOKAS:=$cES_SLOKAS[$vL_position]
	End if 
	$vJ_sem_sloka:=OBJECT Get value:C1743("sem_sloka")
	$vJ_sem_sloka.cE_SLOKAS:=$cE_SLOKAS
	$vJ_sem_sloka.redraw()
	
	
Function sloka_resize($is_init : Boolean)
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	var $vJ_sem_sloka; $vJ_veda_prefs : Object
	$vJ_sem_sloka:=OBJECT Get value:C1743("sem_sloka")
	If ($is_init)
		$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
		If ($cE_KAVIYAM#Null:C1517)
			$vJ_veda_prefs:=$cE_KAVIYAM.j_veda_prefs
			$vJ_sem_sloka.j_pattern:=$vJ_veda_prefs.j_card_bkg
		End if 
	End if 
	$vJ_sem_sloka.resize()
	$vJ_sem_sloka.redraw()
	
	
Function sloka_redraw()
	var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
	var $vJ_woc_card_bkg; $vJ_veda_prefs; $vJ_sem_sloka : Object
	$vJ_sem_sloka:=OBJECT Get value:C1743("sem_sloka")
	//$vJ_woc_card_bkg.redraw()
	$cE_KAVIYAM:=Form:C1466.cE_KAVIYAM
	If ($cE_KAVIYAM#Null:C1517)
		$vJ_veda_prefs:=$cE_KAVIYAM.j_veda_prefs
		$vJ_sem_sloka.j_pattern:=$vJ_veda_prefs.j_card_bkg
	End if 
	$vJ_sem_sloka.redraw()
	
	// CARD 59x91 mm
	