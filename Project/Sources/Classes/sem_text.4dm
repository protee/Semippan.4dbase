
Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_text")
	
	This:C1470._on_load()
	// *
	// *****
	
	
Function _on_load()
	ARRAY TEXT:C222($aT_FontName; 0)
	FONT LIST:C460($aT_FontName)
	
	//Use a hierarchical list with font family applied to each item.
	//OBJECT SET FONT SIZE($vP_FontNamePU->;14)
	var $i; $tt; $vL_ListRef : Integer
	var $vT_fontName : Text
	var $vP_dropdown_face : Pointer
	$vL_ListRef:=New list:C375
	$tt:=Size of array:C274($aT_FontName)
	For ($i; 1; $tt)
		$vT_fontName:=$aT_FontName{$i}
		APPEND TO LIST:C376($vL_ListRef; $vT_fontName; $i)
		SET LIST ITEM FONT:C953($vL_ListRef; 0; $vT_fontName)
	End for 
	$vP_dropdown_face:=OBJECT Get pointer:C1124(Object named:K67:5; "pop_face")
	OBJECT SET LIST BY REFERENCE:C1266($vP_dropdown_face->; Choice list:K42:19; $vL_ListRef)
	
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $vP_dropdown_face : Pointer
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update()
			
		: ($vL_event_code=On Unload:K2:2)
			$vP_dropdown_face:=OBJECT Get pointer:C1124(Object named:K67:5; "pop_face")
			Case of 
					//: (Is Windows)
				: ($vP_dropdown_face=Null:C1517)
				: (Not:C34(Is a list:C621($vP_dropdown_face->)))
				Else 
					CLEAR LIST:C377($vP_dropdown_face->)
			End case 
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="is@")
					This:C1470._isBIUS_chgt($vT_objectName)
					
					
			End case 
			
		: ($vL_event_code=On Data Change:K2:15)
			Case of 
				: ($vT_objectName="pop_face")
					This:C1470._dropdown_face($vT_objectName)
					
				Else 
					This:C1470._data_chgt($vT_objectName)
			End case 
			
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
	var $vL_colors; $vL_stroke_rgb; $vL_fill_rgb; $vL_ItemRef : Integer
	var $vJ_woc_text; $vJ_value : Object
	var $vT_object; $vT_face : Text
	var $vP_dropdown_face : Pointer
	$is_editing:=This:C1470.is_editing
	
	$vT_object:="vt_@"
	OBJECT SET ENTERABLE:C238(*; $vT_object; $is_editing)
	$vL_colors:=wox_field_colors(False:C215; $is_editing)
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke_rgb; ->$vL_fill_rgb)
	OBJECT SET RGB COLORS:C628(*; $vT_object; $vL_stroke_rgb; $vL_fill_rgb)
	OBJECT SET ENABLED:C1123(*; "is@"; $is_editing)
	
	This:C1470._redraw_BIUS()
	
	$vJ_value:=This:C1470.j_value
	$vJ_woc_text:=OBJECT Get value:C1743("woc_text")
	$vJ_woc_text.is_editing:=$is_editing
	$vJ_woc_text.j_value:=$vJ_value
	$vJ_woc_text.t_property:="l_color"
	$vJ_woc_text.redraw()
	
	$vP_dropdown_face:=OBJECT Get pointer:C1124(Object named:K67:5; "pop_face")
	$vT_face:=$vJ_value.t_face
	$vL_ItemRef:=Find in list:C952($vP_dropdown_face->; $vT_face; 0; *)
	If ($vL_ItemRef#0)
		SELECT LIST ITEMS BY REFERENCE:C630($vP_dropdown_face->; $vL_ItemRef)
	Else 
		SELECT LIST ITEMS BY POSITION:C381($vP_dropdown_face->; 100000)
	End if 
	OBJECT SET FONT:C164($vP_dropdown_face->; $vT_face)
	OBJECT SET ENABLED:C1123($vP_dropdown_face->; $is_editing)
	// *
	// *****
	
	
	// *****
	// *
Function _data_chgt($vT_objectName : Text)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
Function _color_chgt($vJ_widget : Object)
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function _btn_clear()
	//var $vj_value : Object
	//$vj_value:=This.j_value
	//$vj_value.tl:=0
	//$vj_value.tr:=0
	//$vj_value.bl:=0
	//$vj_value.br:=0
	//CALL SUBFORM CONTAINER(k_OnDataChange)
	
Function _dropdown_face($vT_objectName : Text)
	var $vL_ItemRef : Integer
	var $vJ_value : Object
	var $vP_dropdown_face : Pointer
	var $vT_face : Text
	$vP_dropdown_face:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)  //"pop_face")
	
	//If (Is macOS)
	GET LIST ITEM:C378($vP_dropdown_face->; *; $vL_ItemRef; $vT_face)
	If ($vL_ItemRef#0)
		//Update the currently selected font at the top of the list (above the line).
		//If (List item position($vP_dropdown_face->; -100)<1)
		//INSERT IN LIST($vP_dropdown_face->; -10; $vT_face; -100)
		//Else 
		//SET LIST ITEM($vP_dropdown_face->; -100; $vT_face; -100)
		//End if 
		SET LIST ITEM FONT:C953($vP_dropdown_face->; -100; $vT_face)
		SELECT LIST ITEMS BY REFERENCE:C630($vP_dropdown_face->; $vL_ItemRef)
		OBJECT SET FONT:C164($vP_dropdown_face->; $vT_face)
		$vJ_value:=This:C1470.j_value
		$vJ_value.t_face:=$vT_face
		CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	End if 
	//End if 
	
	
Function _get_at_BIUS()->$vC_at_bius : Collection
	$vC_at_bius:=New collection:C1472("Bold"; "Italic"; "Underline"; "Strike")
	
	
Function _isBIUS_chgt($vT_objectName : Text)
	var $vC_at_bius : Collection
	var $idx; $vL_style : Integer
	var $vJ_value : Object
	var $vT_tag : Text
	$vT_tag:=Substring:C12($vT_objectName; 3)
	$vC_at_bius:=This:C1470._get_at_BIUS()
	$idx:=$vC_at_bius.indexOf($vT_tag)
	If ($idx>=0)
		$vJ_value:=This:C1470.j_value
		$vL_style:=$vJ_value.l_style
		$vL_style:=wox_bit_not($vL_style; $idx)
		$vJ_value.l_style:=$vL_style
		This:C1470._redraw_BIUS()
		CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	End if 
	
	
Function _redraw_BIUS()
	var $vC_at_bius : Collection
	var $vL_style; $idx : Integer
	var $vJ_value : Object
	var $vT_tag : Text
	$vJ_value:=This:C1470.j_value
	$vL_style:=$vJ_value.l_style
	$vC_at_bius:=This:C1470._get_at_BIUS()
	$idx:=0
	For each ($vT_tag; $vC_at_bius)
		OBJECT SET VALUE:C1742("is"+$vT_tag; $vL_style ?? $idx)
		$idx+=1
	End for each 
	
	