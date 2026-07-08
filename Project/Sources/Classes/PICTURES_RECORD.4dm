
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470.set_is_svg()
	This:C1470.bkgs_display()
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
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
	var $vL_event_code; $vL_width; $vL_height : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $c4E_entity : 4D:C1709.Entity
	var $vO_pict : Picture
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
			//: ($vL_event_code=On Clicked)
			//Case of 
			
			////: ($vT_objectName="bt_partner")
			////This.partner_choose()
			
			////: ($vT_objectName="bt_print")
			////This.print()
			
			//End case 
			
		: ($vT_objectName="field_pict@")
			Case of 
				: ($vL_event_code=On Drop:K2:12)
					GET PICTURE FROM PASTEBOARD:C522($vO_pict)
					$c4E_entity:=Form:C1466.c4E
					$c4E_entity.picture:=$vO_pict
					This:C1470.set_is_svg()
					
				: ($vL_event_code=On Data Change:K2:15)
					$c4E_entity:=Form:C1466.c4E
					PICTURE PROPERTIES:C457($c4E_entity.picture; $vL_width; $vL_height)
					$c4E_entity.width:=$vL_width
					$c4E_entity.height:=$vL_height
					This:C1470.set_is_svg()
					
					//: ($vL_event_code=On Double Clicked)
					
			End case 
	End case 
	//: ($vL_event_code=On Double Clicked)
	// *
	// *****
	
Function set_is_svg()
	var $vP_ : Pointer
	$vP_:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_isSvg")
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	x_btn_toggleSet($vP_; Num:C11(img_tools_isCodec($c4E_entity.picture)))
	
	
Function bkgs_display()
	var $c4E_entity : 4D:C1709.Entity
	var $vL_imgColor : Integer
	var $vT_object : Text
	$c4E_entity:=Form:C1466.c4E
	$vL_imgColor:=$c4E_entity.imgColor
	$vT_object:="oO_bkg1"
	OBJECT SET VALUE:C1742($vT_object; This:C1470.bkg_display($vT_object; $vL_imgColor))
	$vT_object:="oO_bkg2"
	OBJECT SET VALUE:C1742($vT_object; This:C1470.bkg_display($vT_object; $vL_imgColor))
	
	
Function bkg_display($vT_object : Text; $vL_type : Integer)->$vO_answer : Picture
	var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	var $vL_width; $vL_height; $vL_svg_scale; $vL_centerX; $vL_centerY; $vL_pattern; $vL_colors; $vL_color : Integer
	var $vT_svg_id; $vT_pattern_stroke; $vT_pattern_fill; $vT_pattern_name : Text
	OBJECT GET COORDINATES:C663(*; $vT_object; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
	
	$vL_svg_scale:=2
	$vL_width:=$vL_width*$vL_svg_scale
	$vL_height:=$vL_height*$vL_svg_scale
	
	$vT_svg_id:=SVG_New($vL_width; $vL_height)
	$vL_centerX:=$vL_width/2
	$vL_centerY:=$vL_height/2
	
	// Type -> Bkg : 0 Transparent ; 1 White ; 2 black
	// NEW added 3 grey ; 4 monocolor
	
	If ($vL_type=4)
		$vL_pattern:=1
		$vL_colors:=0x331EB1CF
		woc_sp_colors_to_svg($vL_colors; ->$vT_pattern_stroke; ->$vT_pattern_fill)
		$vT_pattern_name:="pattern"
		woc_svg_patterns($vT_svg_id; $vT_pattern_name; $vL_pattern; $vT_pattern_stroke; $vT_pattern_fill)
		$vT_object:=SVG_New_rect($vT_svg_id; 0; 0; $vL_width; $vL_height; 0; 0; "none"; "url(#"+$vT_pattern_name+")"; 0)
	Else 
		$vL_color:=$vL_type=0 ? 0x00F3 : 0x00F4
		$vT_pattern_fill:=woc_sp_color_to_svg($vL_color)
		$vT_object:=SVG_New_rect($vT_svg_id; 0; 0; $vL_width; $vL_height; 0; 0; "none"; $vT_pattern_fill; 0)
	End if 
	SVG EXPORT TO PICTURE:C1017($vT_svg_id; $vO_answer; Get XML data source:K45:16)
	SVG_CLEAR($vT_svg_id)
	
	