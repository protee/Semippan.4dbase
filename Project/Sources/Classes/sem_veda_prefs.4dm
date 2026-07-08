
Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_veda_prefs")
	This:C1470._initialize()
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
			This:C1470._update_all()
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
Function _initialize()
	var $vC_at_key : Collection
	var $vL_waz : Integer
	$vC_at_key:=New collection:C1472()
	This:C1470._at_key:=$vC_at_key
	$vC_at_key.push("wheel_colors"; "links_color")
	$vL_waz:=$vC_at_key.length
	This:C1470._l_waz:=$vL_waz
	$vC_at_key.push("wheel_stroke"; "links_stroke"; "links_dash")
	$vC_at_key.push("links_opacity"; "horto_opacity"; "curve")
	
	$vC_at_key:=New collection:C1472()
	This:C1470._at_key_is:=$vC_at_key
	$vC_at_key.push("border"; "text_center")
	
	$vC_at_key:=New collection:C1472()
	This:C1470._at_key1:=$vC_at_key
	$vC_at_key.push("wheel_coef"; "icons_coef")
	
	
Function _resize()
	var $vL_width; $vL_height; $vL_xl; $vL_xr; $vL_yt; $vL_yb : Integer
	var $vL_waz; $idx : Integer
	var $vC_at_key : Collection
	var $vJ_value; $vJ_widget; $vJ_wxx_value : Object
	var $vT_key; $vT_widget; $vT_property : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	This:C1470._resize__grp($vL_width; $vL_height; ->$vL_xl; ->$vL_yt; ->$vL_xr; ->$vL_yb)
	This:C1470._set_bkg($vL_width; $vL_height)
	
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		$vC_at_key:=This:C1470._at_key
		$vL_waz:=This:C1470._l_waz
		$idx:=0
		For each ($vT_key; $vC_at_key)
			$vT_widget:=($idx<$vL_waz ? "woc_" : "waz_")+$vT_key
			$vT_property:="l_"+$vT_key
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.t_property:=$vT_property
			$vJ_widget.j_value:=$vJ_value
			//$vJ_widget.resize()
			$idx+=1
		End for each 
		
		$vC_at_key:=This:C1470._at_key_is
		$idx:=0
		For each ($vT_key; $vC_at_key)
			$vT_widget:="waz_is_"+$vT_key
			$vT_property:="is_"+$vT_key
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.t_property:=$vT_property
			$vJ_widget.j_value:=$vJ_value
			$vJ_widget.resize()
			$idx+=1
		End for each 
		
		$vT_key:="card_bkg"
		$vT_widget:="woc_"+$vT_key
		$vT_property:="j_"+$vT_key
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_wxx_value:=$vJ_value[$vT_property]
		If ($vJ_wxx_value#Null:C1517)
			$vJ_widget.j_value:=$vJ_wxx_value
		Else 
			$vJ_value[$vT_property]:=$vJ_widget.j_value
		End if 
		$vJ_widget.resize()
		
	End if 
	
	
Function _set_bkg($vL_width : Integer; $vL_height : Integer)
	var $is_bkg : Boolean
	var $vJ_widget; $vJ_pattern : Object
	var $vT_woc_bkg : Text
	$is_bkg:=True:C214
	$vT_woc_bkg:="woc_bkg"
	OBJECT SET VISIBLE:C603(*; $vT_woc_bkg; $is_bkg)
	If ($is_bkg)
		//OBJECT SET COORDINATES(*; $vT_woc_bkg; 0; 0; $vL_width; $vL_height)
		$vJ_widget:=OBJECT Get value:C1743($vT_woc_bkg)
		$vJ_widget.is_editing:=False:C215
		$vJ_pattern:=New object:C1471()  // Default idle pattern
		$vJ_widget.j_value:=$vJ_pattern
		$vJ_pattern.l_pattern:=12
		$vJ_pattern.l_colors:=0xAA096000  // [swo:150] – [swo:0]
		$vJ_pattern.l_rxy:=4
		$vJ_pattern.l_stroke:=0
		$vJ_pattern.l_opacity:=85
		$vJ_widget.redraw()
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	var $vC_at_key : Collection
	var $vL_waz; $idx : Integer
	var $vJ_value; $vJ_widget; $vJ_waz_value : Object
	var $vT_key; $vT_widget; $vT_property : Text
	
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		//OBJECT SET VISIBLE(*; "bkg"; False)
		
		$vC_at_key:=This:C1470._at_key
		$vL_waz:=This:C1470._l_waz
		$idx:=0
		For each ($vT_key; $vC_at_key)
			$vT_widget:=($idx<$vL_waz ? "woc_" : "waz_")+$vT_key
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.redraw()
			$idx+=1
		End for each 
		
		$vC_at_key:=This:C1470._at_key_is
		For each ($vT_key; $vC_at_key)
			$vT_widget:="waz_is_"+$vT_key
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.redraw()
		End for each 
		
		$vC_at_key:=This:C1470._at_key1
		$idx:=0
		For each ($vT_key; $vC_at_key)
			$vT_widget:="waz_"+$vT_key
			$vT_property:="r_"+$vT_key
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.l_value:=$vJ_value[$vT_property]*100
			$vJ_widget.redraw()
			$idx+=1
		End for each 
		
		$vT_widget:="waz_start_end"
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_waz_value:=$vJ_widget.j_value
		$vJ_waz_value.l_low:=$vJ_value.l_angle_start
		$vJ_waz_value.l_high:=$vJ_value.l_angle_end
		$vJ_widget.redraw()
		
		$vT_key:="card_bkg"
		$vT_widget:="woc_"+$vT_key
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.redraw()
		
	End if 
	
	//This._redraw_bkg()
	
	//Function _redraw_bkg()
	//var $vJ_value : Object
	//var $vL_stroke_rgb; $vL_fill_rgb : Integer
	//$vJ_value:=This.j_value
	//woc_sp_colors_to_rgb($vJ_value.l_colors; ->$vL_stroke_rgb; ->$vL_fill_rgb)
	//OBJECT SET RGB COLORS(*; "bkg"; $vL_stroke_rgb; $vL_fill_rgb)
	// *
	// *****
	
	
	// *****
	// *
Function _widget_01_chgt($vJ_widget : Object)
	var $vJ_value : Object
	var $vT_key; $vT_property : Text
	$vT_key:=Substring:C12($vJ_widget.t_widget; 5)
	$vT_property:="r_"+$vT_key
	$vJ_value:=This:C1470.j_value
	$vJ_value[$vT_property]:=$vJ_widget.l_value/100
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
Function _startEnd_chgt($vJ_widget : Object)
	var $vJ_waz_value; $vJ_value : Object
	$vJ_waz_value:=$vJ_widget.j_value
	$vJ_value:=This:C1470.j_value
	$vJ_value.l_angle_start:=$vJ_waz_value.l_low
	$vJ_value.l_angle_end:=$vJ_waz_value.l_high
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function _widgets_chgt($vJ_widget : Object; $is_redraw : Boolean)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	//This._redraw_bkg()
	
	
	// *
	// *****
	
	