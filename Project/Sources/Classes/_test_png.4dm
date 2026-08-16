
Class constructor
	This:C1470.initialize()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
	
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
			CANCEL:C270
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="btn_convert1")
					This:C1470._do_convert1()
					
				: ($vT_objectName="btn_convert2")
					This:C1470._do_convert2()
					
				: ($vT_objectName="btn_convert3")
					This:C1470._do_convert3()
					
				: ($vT_objectName="btn_convert4")
					This:C1470._do_convert4()
					
				: ($vT_objectName="btn_convert")
					This:C1470._do_convert()
					
					
				: ($vT_objectName="btn_woc_colorize")
					This:C1470._do_woc_convert()
					
			End case 
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function initialize()
	//var $vC_al_source : Collection
	//$vC_al_source:=New collection()
	//Form.al_source:=$vC_al_source
	//$vC_al_source.push(-1; 0x00FFFFFF; 0x0000; 0x00757575; -1)
	
	This:C1470._pict_chgt()
	
	// *
	// *****
	
	
	
	// *****
	// *
Function _pict_chgt()
	var $cE_pictures : cs:C1710.PICTURESEntity
	var $vJ_widget : Object
	var $vO_picture1 : Picture
	var $vL_imgColor; $vL_source_rgb : Integer
	$vJ_widget:=OBJECT Get value:C1743("zen_pictures")
	$cE_pictures:=$vJ_widget.c4E
	If ($cE_pictures#Null:C1517)
		$vO_picture1:=$cE_pictures.picture
		$vL_imgColor:=$cE_pictures.imgColor
	End if 
	Form:C1466.o_picture1:=$vO_picture1
	Form:C1466.l_imgColor:=$vL_imgColor
	$vL_source_rgb:=This:C1470._color_source_rgb($vL_imgColor)
	This:C1470.redraw_picture1($vO_picture1)
	OBJECT SET VALUE:C1742("o_picture"; $vO_picture1)
	
	
Function _color_chgt($vJ_widget : Object)
	
	
Function _color_source_rgb($vL_imgColor : Integer)
	var $vC_al_source : Collection
	var $vL_source_rgb : Integer
	$vC_al_source:=sem__storage_menuBtns().m_imgColor.al_source_rgb
	$vL_source_rgb:=$vC_al_source[$vL_imgColor]
	If ($vL_source_rgb#-1)
		This:C1470.woc_sources_upd($vL_source_rgb)  // Update widgets source
	End if 
	
	
Function _get_color_source_rgb($vL_imgColor : Integer)->$vL_source_rgb : Integer
	var $vJ_widget : Object
	//$vC_al_source:=app__storage_menuBtns().m_imgColor.al_source_rgb
	//$vL_color_source_rgb:=$vC_al_source[$vL_imgColor]
	//If ($vL_color_source_rgb=-1)
	$vJ_widget:=OBJECT Get value:C1743("woc_colour")
	$vL_source_rgb:=$vJ_widget.l_color
	//End if
	
Function _do_convert1()
	var $vL_width; $vL_height : Integer
	var $vL_source_rgb; $vL_imgColor; $vL_color_temp_rgb : Integer
	var $vO_picture1; $vO_picture2; $vO_bkg : Picture
	var $vT_dom; $vT_temp_html : Text
	
	$vO_picture1:=Form:C1466.o_picture1
	$vL_imgColor:=Form:C1466.l_imgColor
	$vL_source_rgb:=This:C1470._get_color_source_rgb($vL_imgColor)
	Form:C1466.l_color_source_rgb:=$vL_source_rgb
	If ($vL_source_rgb#-1)
		$vL_color_temp_rgb:=$vL_source_rgb>0 ? $vL_source_rgb-1 : 1  // Color temp -> closest as possible to source
		$vT_temp_html:=woc_rgb_to_html($vL_color_temp_rgb; True:C214)
		PICTURE PROPERTIES:C457($vO_picture1; $vL_width; $vL_height)
		$vT_dom:=SVG_New($vL_width; $vL_height)
		SVG_SET_VIEWPORT_FILL($vT_dom; $vT_temp_html)
		SVG EXPORT TO PICTURE:C1017($vT_dom; $vO_bkg; Own XML data source:K45:18)
		COMBINE PICTURES:C987($vO_picture2; $vO_bkg; Superimposition:K61:10; $vO_picture1)
		Form:C1466.o_picture2:=$vO_picture2
		This:C1470.redraw_picture2($vO_picture2)
	End if 
	Form:C1466.l_color_temp_rgb:=$vL_color_temp_rgb
	
	
Function _do_convert2()
	var $vO_picture2; $vO_picture3 : Picture
	var $vL_source_rgb : Integer
	$vL_source_rgb:=Form:C1466.l_color_source_rgb
	If ($vL_source_rgb>=0)
		$vO_picture2:=Form:C1466.o_picture2
		$vO_picture3:=$vO_picture2
		TRANSFORM PICTURE:C988($vO_picture3; Transparency:K61:11; $vL_source_rgb)  // Colot to transparent
		CONVERT PICTURE:C1002($vO_picture3; ".png")
		Form:C1466.o_picture3:=$vO_picture3
		This:C1470.redraw_picture3($vO_picture3)
	End if 
	
	
Function _do_convert3()
	var $vO_picture3; $vO_bkg; $vO_picture4 : Picture
	var $vL_width; $vL_height; $vL_color_target : Integer
	var $vT_dom; $vT_target_html : Text
	$vO_picture3:=Form:C1466.o_picture3
	PICTURE PROPERTIES:C457($vO_picture3; $vL_width; $vL_height)
	$vL_color_target:=Form:C1466.l_color_target
	$vT_target_html:=woc_sp_color_to_svg($vL_color_target)
	$vT_dom:=SVG_New($vL_width; $vL_height)
	SVG_SET_VIEWPORT_FILL($vT_dom; $vT_target_html)
	SVG EXPORT TO PICTURE:C1017($vT_dom; $vO_bkg; Own XML data source:K45:18)
	COMBINE PICTURES:C987($vO_picture4; $vO_bkg; Superimposition:K61:10; $vO_picture3)
	Form:C1466.o_picture4:=$vO_picture4
	This:C1470.redraw_picture4($vO_picture4)
	
	
Function _do_convert4()
	var $vO_picture4; $vO_picture5 : Picture
	var $vL_color_temp_rgb : Integer
	$vL_color_temp_rgb:=Form:C1466.l_color_temp_rgb
	$vO_picture4:=Form:C1466.o_picture4
	$vO_picture5:=$vO_picture4
	TRANSFORM PICTURE:C988($vO_picture5; Transparency:K61:11; $vL_color_temp_rgb)
	CONVERT PICTURE:C1002($vO_picture5; ".png")
	Form:C1466.o_picture5:=$vO_picture5
	This:C1470.redraw_picture5($vO_picture5)
	// *
	// *****
	
	
	
	// *****
	// *
Function redraw_picture1($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_picture1"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	
	
Function redraw_picture2($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_picture2"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	
	
Function redraw_picture3($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_picture3"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	
	
Function redraw_picture4($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_picture4"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	
	
Function redraw_picture5($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_picture5"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _do_convert()
	var $vL_color_target : Integer
	var $vL_imgColor; $vL_target_rgb : Integer
	var $vO_picture : Picture
	$vO_picture:=Form:C1466.o_picture1
	$vL_imgColor:=Form:C1466.l_imgColor
	$vL_color_target:=Form:C1466.l_color_target
	$vL_target_rgb:=woc_sp_color_to_rgb($vL_color_target; True:C214)  // Color target
	This:C1470._do_color_change($vO_picture; $vL_imgColor; $vL_target_rgb)
	
	
Function _do_color_change($vO_picture : Picture; $vL_imgColor : Integer; $vL_target_rgb : Integer)
	var $vL_source_rgb : Integer
	
	$vL_source_rgb:=This:C1470._get_color_source_rgb($vL_imgColor)
	If ($vL_source_rgb#-1)
		This:C1470._color_change($vO_picture; $vL_source_rgb; $vL_target_rgb)
	End if 
	//This.redraw_picture($vO_picture)
	
	
Function _color_change($vO_picture : Picture; $vL_source_rgb : Integer; $vL_target_rgb : Integer)
	var $vL_temp_rgb; $vL_width; $vL_height : Integer
	var $vO_bkg : Picture
	var $vT_temp_html; $vT_target_html; $vT_dom : Text
	If ($vL_target_rgb=Background color none:K23:10)
		TRANSFORM PICTURE:C988($vO_picture; Transparency:K61:11; $vL_source_rgb)
		CONVERT PICTURE:C1002($vO_picture; ".png")
	Else 
		$vL_temp_rgb:=$vL_source_rgb>0 ? $vL_source_rgb-1 : 1  // Color temp -> closest as possible to source
		$vT_temp_html:=woc_rgb_to_html($vL_temp_rgb; True:C214)  // "#rrggbb"
		$vT_target_html:=woc_rgb_to_html($vL_target_rgb; True:C214)  // "#rrggbb"
		// 1) fill trsp with temp
		$vO_picture:=Form:C1466.o_picture1
		PICTURE PROPERTIES:C457($vO_picture; $vL_width; $vL_height)
		$vT_dom:=SVG_New($vL_width; $vL_height)
		SVG_SET_VIEWPORT_FILL($vT_dom; $vT_temp_html)
		SVG EXPORT TO PICTURE:C1017($vT_dom; $vO_bkg; Own XML data source:K45:18)
		COMBINE PICTURES:C987($vO_picture; $vO_bkg; Superimposition:K61:10; $vO_picture)
		// 2) source -> trsp
		//$vT_color_source:=woc_rgb_to_html($vL_color_source_rgb; True)
		TRANSFORM PICTURE:C988($vO_picture; Transparency:K61:11; $vL_source_rgb)  // Colot to transparent
		CONVERT PICTURE:C1002($vO_picture; ".png")
		// 3) combine with color3
		$vT_dom:=SVG_New($vL_width; $vL_height)
		SVG_SET_VIEWPORT_FILL($vT_dom; $vT_target_html)
		SVG EXPORT TO PICTURE:C1017($vT_dom; $vO_bkg; Own XML data source:K45:18)
		COMBINE PICTURES:C987($vO_picture; $vO_bkg; Superimposition:K61:10; $vO_picture)
		// 4) temp -> trsp
		TRANSFORM PICTURE:C988($vO_picture; Transparency:K61:11; $vL_temp_rgb)
		CONVERT PICTURE:C1002($vO_picture; ".png")
	End if 
	This:C1470.redraw_picture($vO_picture)
	
Function redraw_picture($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_picture"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _do_woc_convert()
	var $vL_imgColor; $vL_color_target; $vL_target_rgb; $vL_source_rgb : Integer
	var $vO_picture : Picture
	$vO_picture:=Form:C1466.o_picture1
	$vL_imgColor:=Form:C1466.l_imgColor
	$vL_color_target:=Form:C1466.l_color_target
	$vL_target_rgb:=woc_sp_color_to_rgb($vL_color_target; True:C214)  // Color target
	$vL_source_rgb:=This:C1470._get_color_source_rgb($vL_imgColor)
	If ($vL_source_rgb#-1)
		$vO_picture:=woc_picture_colorize($vO_picture; $vL_source_rgb; $vL_target_rgb)
		This:C1470.redraw_woc_picture($vO_picture)
	End if 
	
	
Function redraw_woc_picture($vO_picture : Picture)
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="woc_wocpicture"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.o_picture:=$vO_picture
	$vJ_widget.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _cs_bitmap()->$vJ_cs_bitmap : Object
	var $vO_picture : Picture
	$vJ_cs_bitmap:=This:C1470.cs_bitmap
	If ($vJ_cs_bitmap=Null:C1517)
		$vO_picture:=OBJECT Get value:C1743("o_picture")
		$vJ_cs_bitmap:=woc_cs_bmpBitmap_new($vO_picture)
	End if 
	
	
Function _canvas_click($vP_canvas : Pointer)
	var $x; $y; $vL_offset; $vL_rgb : Integer
	var $vJ_cs_picture; $vJ_rgb; $vJ_widget : Object
	$x:=MouseX
	$y:=MouseY
	$vJ_cs_picture:=This:C1470._cs_bitmap()
	$vJ_cs_picture.get_bitmap()
	$vL_offset:=$vJ_cs_picture.get_mapPixelOffset($x; $y)
	$vJ_rgb:=$vJ_cs_picture.get_mapPixel($x; $y)
	If ($vJ_rgb#Null:C1517)
		$vL_rgb:=$vJ_cs_picture.get_pixelRgb($x; $y)
	Else 
		$vL_rgb:=Background color none:K23:10
	End if 
	$vJ_widget:=OBJECT Get value:C1743("woc_colour")
	$vJ_widget.l_color:=$vL_rgb
	$vJ_widget.t_colour:=""
	$vJ_widget.redraw()
	$vJ_widget:=OBJECT Get value:C1743("woc_rrggbb")
	$vJ_widget.l_value:=$vL_rgb
	$vJ_widget.redraw()
	
	
Function woc_sources_upd($vL_value : Integer)
	This:C1470._woc_colour_chgt($vL_value)
	This:C1470._woc_rrggbb_chgt($vL_value)
	
	
Function _woc_colour_chgt($vL_value : Integer)
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743("woc_rrggbb")
	$vJ_widget.l_value:=$vL_value
	$vJ_widget.redraw()
	
	
Function _woc_rrggbb_chgt($vL_value : Integer)
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743("woc_colour")
	$vJ_widget.l_color:=$vL_value
	$vJ_widget.t_colour:=""
	$vJ_widget.redraw()
	// *
	// *****
	
	
	//Function get_rgb()
	//C_PICTURE($vO_form)
	//FORM SCREENSHOT($vO_form)  // Captures the active form
	
	//C_LONGINT($x; $y; $pixelColor)
	//$x:=MouseX  // Pixel X coordinate (relative to the captured form)
	//$y:=MouseY  // Pixel Y coordinate
	
	
	//ALERT("RGB: "+String($red)+", "+String($green)+", "+String($blue))