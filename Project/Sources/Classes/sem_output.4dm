
Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_output")
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
			
			//: ($vL_event_code=On Clicked)
			//Case of 
			//: ($vT_objectName="btn_menu")
			//This._btn_menu()
			
			//End case 
			
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
	var $vC_at_widgets : Collection
	var $vJ_widget : Object
	var $vT_tag : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	
	$vC_at_widgets:=New collection:C1472("type"; "mime"; "shape")
	For each ($vT_tag; $vC_at_widgets)
		$vJ_widget:=OBJECT Get value:C1743("sem_"+$vT_tag)
		$vJ_widget.j_value:=This:C1470.j_value
		$vJ_widget.t_property:=$vT_tag
		$vJ_widget.redraw()
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	var $is_editing : Boolean
	var $vC_at_widgets : Collection
	var $vJ_widget : Object
	var $vT_object; $vT_tag : Text
	var $vL_colors; $vL_stroke_rgb; $vL_fill_rgb : Integer
	$is_editing:=This:C1470.is_editing
	
	$vT_object:="vt_@"
	OBJECT SET ENTERABLE:C238(*; $vT_object; $is_editing)
	$vL_colors:=wox_field_colors(False:C215; $is_editing)
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke_rgb; ->$vL_fill_rgb)
	OBJECT SET RGB COLORS:C628(*; $vT_object; $vL_stroke_rgb; $vL_fill_rgb)
	
	$vC_at_widgets:=New collection:C1472("type"; "mime"; "shape")
	For each ($vT_tag; $vC_at_widgets)
		$vJ_widget:=OBJECT Get value:C1743("sem_"+$vT_tag)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _data_chgt($vT_objectName : Text)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function _type_chgt($vJ_widget : Object)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function _mime_chgt($vJ_widget : Object)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
Function _shape_chgt($vJ_widget : Object)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	