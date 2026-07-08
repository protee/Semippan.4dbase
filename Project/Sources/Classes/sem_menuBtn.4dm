
Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_menuBtn")
	// *
	// *****
	
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update()
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					//: ($vT_objectName="vt_is@")
					//This._data_chgt($vT_objectName)
					
				: ($vT_objectName="btn_create")
					This:C1470._btn_click($vT_objectName)
					
				: ($vT_objectName="btn_code")
					This:C1470._btn_click($vT_objectName)
					
			End case 
			
		: ($vL_event_code=On Data Change:K2:15)
			//Case of 
			//: ($vT_objectName="vt_width")
			//This._data_chgt()
			
			//End case 
			This:C1470._data_chgt($vT_objectName)
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height : Integer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	var $is_editing : Boolean
	var $vL_colors; $vL_stroke_rgb; $vL_fill_rgb : Integer
	var $vT_object : Text
	var $vJ_value; $vJ_waz_isColors; $vJ_wox_rsct : Object
	var $vV_rsct : Variant
	$is_editing:=This:C1470.is_editing
	
	$vT_object:="vt_@"
	OBJECT SET ENTERABLE:C238(*; $vT_object; $is_editing)
	$vL_colors:=wox_field_colors(False:C215; $is_editing)
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke_rgb; ->$vL_fill_rgb)
	OBJECT SET RGB COLORS:C628(*; $vT_object; $vL_stroke_rgb; $vL_fill_rgb)
	
	$vJ_value:=This:C1470.j_value
	$vJ_waz_isColors:=OBJECT Get value:C1743("waz_isColors")
	$vJ_waz_isColors.is_editing:=$is_editing
	$vJ_waz_isColors.j_value:=$vJ_value
	$vJ_waz_isColors.t_property:="isColors"
	$vJ_waz_isColors.redraw()
	
	$vV_rsct:=$vJ_value.l_rsct
	$vJ_value.l_rsct:=$vV_rsct#Null:C1517 ? $vV_rsct : -1
	$vJ_wox_rsct:=OBJECT Get value:C1743("wox_rsct")
	$vJ_wox_rsct.is_editing:=$is_editing
	$vJ_wox_rsct.is_idle:=True:C214
	$vJ_wox_rsct.j_value:=$vJ_value
	$vJ_wox_rsct.t_property:="l_rsct"
	$vJ_wox_rsct.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _data_chgt($vT_objectName : Text)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
Function _isColors_chgt($vJ_widget : Object)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
Function _labelType_chgt($vJ_widget : Object)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function _btn_click($vT_objectName : Text)
	This:C1470.t_value:=Substring:C12($vT_objectName; 5)
	CALL SUBFORM CONTAINER:C1086(k_OnDoubleClicked)
	
	//F_BANK_SET_groutine("BT_FAV")
	
	
	//var $cs_BANK_TOOLS : cs.BANK_TOOLS
	//$cs_BANK_TOOLS:=cs.BANK_TOOLS
	//$cs_BANK_TOOLS:=$cs_BANK_TOOLS.new()
	//$cs_BANK_TOOLS.do_selection()
	//$cs_BANK_TOOLS._export_menuBtn()
	
	