
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	//OBJECT SET ENTERABLE(*; "LB_rtc"; Form.is_editing)
	//This.lb_rtc_load()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.colors=0); True:C214; "Fill in colors!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=$c4E_record.touched()
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
	//Function record_save($c4E_entity : 4D.Entity)
	//Super.record_save($c4E_entity)
	
	// *
	// *****
	
	
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
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
			//: ($vL_event_code=On Clicked)
			//Case of 
			// 
			////: ($vT_objectName="bt_partner")
			////This.partner_choose()
			
			////: ($vT_objectName="bt_print")
			////This.print()
			
			//End case 
			
		: ($vL_event_code=On Resize:K2:27)
			SET TIMER:C645(1)
			
		: ($vL_event_code=On Timer:K2:25)
			SET TIMER:C645(0)
			This:C1470.combinations_redraw()
			This:C1470._cmb_redraw()
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	
	// *****
	// *
Function combinations_redraw()
	var $vJ_woc_alColors : Object
	$vJ_woc_alColors:=OBJECT Get value:C1743("woc_alColors")
	$vJ_woc_alColors.resize()
	$vJ_woc_alColors.redraw()
	
Function _cmb_chgt($vJ_widget : Object)
	This:C1470._cmb_redraw()
	
Function _cmb_redraw()
	var $vC_al_colors : Collection
	var $cE_combinations : cs:C1710.COMBINATIONSEntity
	var $vL_stroke; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height : Integer
	var $vJ_value : Object
	var $vO_img : Picture
	var $vT_oO_cmbs : Text
	$cE_combinations:=Form:C1466.c4E
	$vJ_value:=$cE_combinations.j_cmb
	$vL_stroke:=$vJ_value.l_stroke
	$vC_al_colors:=$vJ_value.al_colors
	$vT_oO_cmbs:="oO_cmbs"
	OBJECT GET COORDINATES:C663(*; $vT_oO_cmbs; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
	$vO_img:=woc_svg_al_colors($vC_al_colors; $vL_width; $vL_height; $vL_stroke)
	OBJECT SET VALUE:C1742($vT_oO_cmbs; $vO_img)
	// *
	// *****
	