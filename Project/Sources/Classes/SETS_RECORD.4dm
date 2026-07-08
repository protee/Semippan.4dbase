
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	//$is_new:=Form.is_new
	//If ($is_new)
	//$c4E:=Form.c4E
	//$vJ_dcox:=$c4E.j_dcox  // Already existing j_dcox
	//$vJ_dcox.l_main:=0xFEF5
	//$vC_at_bind:=sem_get_at_dcox()
	//For each ($vT_bind; $vC_at_bind)
	//$vJ_bind:=New object()
	//$vJ_dcox["j_"+$vT_bind]:=$vJ_bind
	//$vJ_bind.l_colors:=0xF1F4
	//$vJ_bind.l_stroke:=0
	//$vJ_bind.l_add_stroke:=0
	//$vJ_bind.l_fill:=0
	//$vJ_bind.l_add_fill:=0
	//End for each 
	//End if 
	This:C1470.redraw()
	
	
Function record_checkout()->$isOk : Boolean
	//var $c4E_entity : 4D.Entity
	//$c4E_entity:=Form.c4E
	//var $vJ_okValidate : Object
	//$vJ_okValidate:=zen_okValidate_init
	//zen_okValidate_check($vJ_okValidate; ($c4E_entity.colors=0); True; "Fill in colors!")
	//$isOk:=zen_okValidate_checkout($vJ_okValidate)
	$isOk:=True:C214
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=$c4E_record.touched()
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
Function record_save($c4E_entity : 4D:C1709.Entity)
	Super:C1706.record_save($c4E_entity)
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
			
			
		: ($vL_event_code=On Clicked:K2:4)
			//Case of 
			//: ($vT_objectName="bt_orwells_rw")
			
			//If (Right click) && (Form.is_editing)
			//This._btn_logo()
			//End if 
			
			//: ($vT_objectName="bt_partner")
			//This.partner_choose()
			
			//: ($vT_objectName="bt_print")
			//This.print()
			
			//End case 
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
Function redraw()
	//var $vC_al_colors1 : Collection
	//$vC_al_colors1:=This._get_colors1($cE_SETS)
	//$vC_al_colors:=This._get_colors($cE_SETS; $vC_al_colors1)
	var $vC_c4E_related : Collection
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_PACKS : cs:C1710.PACKSEntity
	var $vL_colors_in : Integer
	$vL_colors_in:=0
	$vC_c4E_related:=zen_linked_related_ones("SETS_BANKS.BANKS_PACKS")
	$cE_PACKS:=$vC_c4E_related[1]
	$cE_BANKS:=$vC_c4E_related[0]
	$vL_colors_in:=($cE_PACKS#Null:C1517 && $cE_BANKS#Null:C1517) ? woc_sp_colors_from_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx) : 0
	Form:C1466.l_colors_in:=$vL_colors_in
	This:C1470._template_chgt()
	
	
	// *****
	// *
Function _get_colors1($cE_SETS : cs:C1710.SETSEntity)->$vC_al_colors1 : Collection
	var $is_btn : Boolean
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $vJ_dcox : Object
	var $vL_colors_in : Integer
	$vL_colors_in:=Form:C1466.l_colors_in
	$cE_SETS:=Form:C1466.c4E
	$is_btn:=$cE_SETS.type>0
	$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
	$vJ_dcox:=$cE_TEMPLATES.j_dcox
	$vC_al_colors1:=sem_get_dcox_colors_first($vJ_dcox; $is_btn; $vL_colors_in)
	Form:C1466.al_colors1:=$vC_al_colors1
	
	
Function _get_colors($cE_SETS : cs:C1710.SETSEntity; $vC_al_colors_in : Collection)->$vC_al_colors : Collection
	var $vJ_dcox : Object
	
	$vC_al_colors_in:=$vC_al_colors_in#Null:C1517 ? $vC_al_colors_in : Form:C1466.al_colors1
	$vJ_dcox:=$cE_SETS.j_dcox
	$vC_al_colors:=sem_get_dcox_colors($vJ_dcox; $vC_al_colors_in)
	Form:C1466.al_colors:=$vC_al_colors
	
	
	
Function _template_chgt($vJ_widget : Object)
	var $vC_al_colors1; $vC_al_colors : Collection
	var $cE_SETS : cs:C1710.SETSEntity
	$cE_SETS:=Form:C1466.c4E
	$vC_al_colors1:=This:C1470._get_colors1($cE_SETS)
	
	$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
	$vJ_widget.al_in:=$vC_al_colors1
	$vJ_widget.resize()  // To affect sub object to already binded j_dcox
	$vJ_widget.redraw()
	
	This:C1470.redraw_colors1($vC_al_colors1)
	$vC_al_colors:=This:C1470._get_colors($cE_SETS; $vC_al_colors1)
	This:C1470.redraw_colors($vC_al_colors)
	
	
Function _dcox_chgt()
	var $vC_al_colors : Collection
	var $cE_SETS : cs:C1710.SETSEntity
	This:C1470.is_touched:=True:C214
	$cE_SETS:=Form:C1466.c4E
	$vC_al_colors:=This:C1470._get_colors($cE_SETS)
	This:C1470.redraw_colors($vC_al_colors)
	
	
	
Function redraw_colors1($vC_al_colors1 : Collection)
	var $vC_at_bind : Collection
	var $idx; $tt : Integer
	var $vJ_widget : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible : Boolean
	
	$vC_al_colors1:=$vC_al_colors1#Null:C1517 ? $vC_al_colors1 : Form:C1466.al_colors1
	$tt:=$vC_al_colors1.length
	$vC_at_bind:=sem_get_at_dcox()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="woc_"+$vT_bind+"1"
		$is_visible:=$idx<$tt
		OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
		If ($is_visible)
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.is_editing:=False:C215
			$vJ_widget.l_colors:=$vC_al_colors1[$idx]
			$vJ_widget.redraw()
		End if 
		$idx+=1
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function redraw_colors($vC_al_colors : Collection)
	var $vC_at_bind : Collection
	var $idx; $tt : Integer
	var $vJ_widget : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible : Boolean
	
	$vC_al_colors:=$vC_al_colors#Null:C1517 ? $vC_al_colors : Form:C1466.al_colors
	$tt:=$vC_al_colors.length
	$vC_at_bind:=sem_get_at_dcox()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="woc_"+$vT_bind
		$is_visible:=$idx<$tt
		OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
		If ($is_visible)
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.is_editing:=False:C215
			$vJ_widget.l_colors:=$vC_al_colors[$idx]
			$vJ_widget.redraw()
		End if 
		$idx+=1
	End for each 
	// *
	// *****
	
	