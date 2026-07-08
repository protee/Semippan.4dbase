
Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_options")
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
				: ($vT_objectName="vt_is@")
					This:C1470._data_chgt($vT_objectName)
					
					
			End case 
			
			//: ($vL_event_code=On Data Change)
			//Case of 
			//: ($vT_objectName="vt_width")
			//This._data_chgt()
			
			//End case 
			//This._data_chgt($vT_objectName)
			
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
	var $vT_object : Text
	$is_editing:=This:C1470.is_editing
	
	$vT_object:="vt_@"
	OBJECT SET ENABLED:C1123(*; $vT_object; $is_editing)
	//$vL_colors:=wox_field_colors(False; $is_editing)
	//woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke_rgb; ->$vL_fill_rgb)
	//OBJECT SET RGB COLORS(*; $vT_object; $vL_stroke_rgb; $vL_fill_rgb)
	// *
	// *****
	
	
	// *****
	// *
Function _data_chgt($vT_objectName : Text)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	