
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	var $vC_at_bind : Collection
	var $vJ_value; $vJ_bind : Object
	var $vT_bind : Text
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	Super:C1706.record_load_upd()
	This:C1470.l_timer:=1
	If (Form:C1466.is_new)
		$cE_TEMPLATES:=Form:C1466.c4E
		$vJ_value:=$cE_TEMPLATES.j_dcox  // Get existing object
		$vJ_value.l_main:=0xFEF5
		$vC_at_bind:=woc_dcox_at_get()
		For each ($vT_bind; $vC_at_bind)
			$vJ_bind:=New object:C1471()
			$vJ_value["j_"+$vT_bind]:=$vJ_bind
			$vJ_bind.l_colors:=0xF1F4
			$vJ_bind.l_stroke:=0
			$vJ_bind.l_add_stroke:=0
			$vJ_bind.l_fill:=0
			$vJ_bind.l_add_fill:=0
		End for each 
	End if 
	//This._dcox_bind()
	This:C1470._dcox_redraw()
	This:C1470._bt_test_init()
	
	
Function record_checkout()->$isOk : Boolean
	$cE_TEMPLATES:=Form:C1466.c4E
	var $vJ_okValidate : Object
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($cE_TEMPLATES.label=""); True:C214; "Fill in label!")
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
			Case of 
				: ($vT_objectName="bt_test")
					wox_sounds_play_tick()
					
				: ($vT_objectName="btn_template")
					This:C1470._btn_template()
					
			End case 
			
			
			//: ($vL_event_code=On Resize)
			//SET TIMER(1)
			
			//: ($vL_event_code=On Timer)
			//SET TIMER(0)
			//This.redraw()
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _dcox_redraw()
	var $vJ_widget : Object
	var $vL_colors_in : Integer
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
	$cE_TEMPLATES:=Form:C1466.c4E
	$vL_colors_in:=$cE_TEMPLATES.colors_in
	$vJ_widget.al_in:=New collection:C1472().resize(4; $vL_colors_in)
	$vJ_widget.resize()  // To affect sub object to already binded j_dcox
	$vJ_widget.redraw()
	This:C1470.redraw_pictures()
	// *
	// *****
	
	
	
	// *****
	// *
Function redraw_pictures()
	var $vC_at_bind : Collection
	var $vL_shape; $vL_stroke; $vL_colors_in; $vL_colors_main; $vL_colors_out; $idx : Integer
	var $vL_rxy : Integer
	var $vJ_widget; $vJ_value; $vJ_bind : Object
	var $vT_bind; $vT_widget : Text
	var $vO_picture; $vO_button : Picture
	var $vR_coef : Real
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	$cE_TEMPLATES:=Form:C1466.c4E
	$vL_shape:=$cE_TEMPLATES.shape
	$vL_stroke:=$cE_TEMPLATES.stroke
	$vL_colors_in:=$cE_TEMPLATES.colors_in
	$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
	$vJ_value:=$vJ_widget.j_value
	$vL_colors_main:=$vJ_value.l_main
	$vL_rxy:=10
	$vR_coef:=0.9
	$vC_at_bind:=woc_dcox_at_get()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="sets_picture_"+$vT_bind
		$vJ_bind:=$vJ_value["j_"+$vT_bind]
		$vL_colors_out:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
		
		//$vO_pict:=This._pict($vL_colors_out; $vL_shape; $vL_stroke; $vT_bind)
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=False:C215
		$vJ_widget.l_colors:=$vL_colors_out
		$vJ_widget.l_rxy:=$vL_rxy
		$vJ_widget.r_coef:=$vR_coef
		$vJ_widget.l_shape:=$vL_shape
		$vJ_widget.l_stroke:=$vL_stroke
		$vJ_widget.redraw()
		//$vO_picture:=$vJ_widget.o_picture
		$vO_picture:=$vJ_widget.getCanvas()
		$vO_button:=$idx=0 ? $vO_picture : $vO_button/$vO_picture
		$idx+=1
	End for each 
	This:C1470._bt_test_upd($vO_button)
	
	
Function _pict($vL_colors : Integer; $vL_shape : Integer; $vL_stroke : Integer; $vT_bind : Text)->$vO_picture : Picture
	var $vP_canvas : Pointer
	var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height : Integer
	var $vL_color_fill; $vL_rxy : Integer
	var $is_whiteFor : Boolean
	var $vR_coef : Real
	var $c4Fi_icon : 4D:C1709.File
	var $vT_wb : Text
	var $vO_icon : Picture
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "oo_"+$vT_bind)
	//$vP_canvas->:=woc_sp_shape_get_object($vP_canvas; $vL_colors; $vL_shape)
	OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
	//$vP_canvas->:=woc_sp_shape_img($vL_width; $vL_height; $vL_colors; $vL_shape; 1; $vL_stroke; 100)
	
	//$vR_angle:=0
	//$vR_coef:=1  //0.9
	//$vT_icon_path:="icon/gesture"
	//$vT_icon_path:=Substring($vT_icon_path; 6)
	//$vR_img_coef:=1
	//waz_io_get_picture_object($vP_canvas; $vL_stroke; $vL_shape; $vR_coef; $vL_colors; $vT_icon_path;$vR_img_coef;$vR_angle)
	
	$vL_rxy:=10
	$vR_coef:=1  //0.9
	$vL_color_fill:=woc_sp_colors_to_f($vL_colors)
	$is_whiteFor:=woc_sp_color_isWhiteFor($vL_color_fill)
	$vT_wb:=$is_whiteFor ? "w" : "b"
	$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("icons/icn_gesture_"+$vT_wb+".png")
	READ PICTURE FILE:C678($c4Fi_icon.platformPath; $vO_icon)
	$vO_picture:=woc_picture_icon_img($vL_width; $vL_height; $vR_coef; $vL_rxy; $vL_rxy; $vL_rxy; $vL_rxy; $vL_stroke; $vL_shape; $vL_colors; $vO_icon)
	$vP_canvas->:=$vO_picture
	// *
	// *****
	
	
	// *****
	// *
Function _bt_test_init()
	var $vL_dummy : Integer
	var $vP_picture; $vP_canvas : Pointer
	var $vT_btn; $vT_varName; $vT_format : Text
	$vT_btn:="bt_test"
	$vP_picture:=OBJECT Get pointer:C1124(Object named:K67:5; "o_bt_test")
	RESOLVE POINTER:C394($vP_picture; $vT_varName; $vL_dummy; $vL_dummy)
	$vT_format:="1;4;var:"+$vT_varName+";240"
	OBJECT SET FORMAT:C236(*; $vT_btn; $vT_format)
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "oo_bkg_bt")
	This:C1470._bkg_pict($vP_canvas)
	
	
Function _bt_test_upd($vO_picture : Picture)
	var $vP_picture : Pointer
	$vP_picture:=OBJECT Get pointer:C1124(Object named:K67:5; "o_bt_test")
	$vP_picture->:=$vO_picture
	
Function _bt_is_enabled($vJ_widget : Object)
	var $is_enabled : Boolean
	$is_enabled:=$vJ_widget.v_value
	OBJECT SET ENABLED:C1123(*; "bt_test"; $is_enabled)
	// *
	// *****
	
	
	// *****
	// *
Function _bkg_pict($vP_canvas : Pointer)
	var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height; $vL_svg_scale; $vL_pattern; $vL_colors : Integer
	var $vT_svg_id; $vT_pattern_stroke; $vT_pattern_fill; $vT_pattern_name; $vT_object : Text
	OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
	$vL_svg_scale:=2
	$vL_width:=$vL_width*$vL_svg_scale
	$vL_height:=$vL_height*$vL_svg_scale
	$vT_svg_id:=SVG_New($vL_width; $vL_height)
	$vL_pattern:=1
	$vL_colors:=0x331EB1CF
	woc_sp_colors_to_svg($vL_colors; ->$vT_pattern_stroke; ->$vT_pattern_fill)
	$vT_pattern_name:="pattern"
	woc_svg_patterns($vT_svg_id; $vT_pattern_name; $vL_pattern; $vT_pattern_stroke; $vT_pattern_fill)
	$vT_object:=SVG_New_rect($vT_svg_id; 0; 0; $vL_width; $vL_height; 0; 0; "none"; "url(#"+$vT_pattern_name+")"; 0)
	SVG EXPORT TO PICTURE:C1017($vT_svg_id; $vP_canvas->; Get XML data source:K45:16)
	SVG_CLEAR($vT_svg_id)
	// *
	// *****
	
	
Function _btn_template()
	var $isOk : Boolean
	var $cE_templates_from; $cE_templates : cs:C1710.TEMPLATESEntity
	var $vJ_widget : Object
	var $vT_table : Text
	var $vV_UID : Variant
	$vT_table:="TEMPLATES"
	$vV_UID:=zen_table_picker_one($vT_table)
	$isOk:=zen_UID_isOk($vV_UID)
	If ($isOk)
		$cE_templates_from:=ds:C1482.TEMPLATES.get($vV_UID)
		$cE_templates:=Form:C1466.c4E
		//$cE_SETS.j_dcox:=$cE_templates.j_dcox // NOP ! As ref chgt not allowed
		This:C1470.is_touched:=True:C214
		wox_vJ_overloads($cE_templates_from.j_dcox; $cE_templates.j_dcox)
		$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
		$vJ_widget.resize()  // To affect sub object to already binded j_dcox
		$vJ_widget.redraw()
		This:C1470.redraw_pictures()
		This:C1470._bt_test_init()
	End if 
	
	