
property l_value : Integer
property aj_cards : Collection
property is_editing : Boolean
property r_min; r_increment : Real
property _l_mouseX; _l_mouseX_last : Integer
property _r_coef : Real
property _is_inOut : Boolean


Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_cards")
	This:C1470.l_value:=-1
	//$vR_increment:=0.05
	//This.r_increment:=$vR_increment
	//$vR_min:=0.7
	//This.r_min:=$vR_min
	
	This:C1470._l_mouseX:=0
	This:C1470._l_mouseX_last:=-1
	This:C1470._r_coef:=This:C1470.r_min
	This:C1470._is_inOut:=False:C215
	SET TIMER:C645(1)
	// *
	// *****
	
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $vR_increment; $vR_coef; $vR_min : Real
	var $is_redraw : Boolean
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
			//: ($vL_event_code=On Clicked)
			//Case of
			//: ($vT_objectName="canvas")
			//This._canvas_ui()
			
			//End case
			
		: ($vL_event_code=On Timer:K2:25)
			$vR_min:=This:C1470.r_min
			$vR_increment:=This:C1470.r_increment
			$vR_coef:=This:C1470._r_coef
			$is_redraw:=False:C215
			If (This:C1470._is_inOut)
				If ($vR_coef<1)
					This:C1470._r_coef+=$vR_increment
					$is_redraw:=True:C214
				End if 
			Else 
				If ($vR_coef>$vR_min)
					This:C1470._r_coef-=$vR_increment
					$is_redraw:=True:C214
				End if 
			End if 
			
			If (Not:C34($is_redraw))
				$is_redraw:=This:C1470._l_mouseX#This:C1470._l_mouseX_last
				If ($is_redraw)
					This:C1470._l_mouseX_last:=This:C1470._l_mouseX
				End if 
			End if 
			
			If ($is_redraw)
				This:C1470._redraw()
			End if 
	End case 
	// *
	// *****
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height : Integer
	var $vP_canvas : Pointer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	OBJECT SET COORDINATES:C1248($vP_canvas->; 0; 0; $vL_width; $vL_height)
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	//var $vL_value : Integer
	//$vL_value:=This.l_value
	var $vP_canvas : Pointer
	var $vC_aj_cards : Collection
	var $vL_value; $vL_mouseX : Integer
	var $vR_coef : Real
	$vL_value:=This:C1470._ext_read_i()
	$vC_aj_cards:=This:C1470.aj_cards
	$vL_mouseX:=This:C1470._l_mouseX
	$vR_coef:=This:C1470._r_coef
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	$vP_canvas->:=sem_svg_cards_object($vP_canvas; $vL_value; $vC_aj_cards; $vL_mouseX; $vR_coef; This:C1470)
	// *
	// *****
	
	
	// *****
	// *
Function _canvas_ui($vP_canvas : Pointer)
	var $is_editing : Boolean
	var $vL_value; $vL_form_event; $vL_width; $vL_height; $vL_svg_scale; $vL_mouseY_threshold : Integer
	var $vT_idSvg : Text
	$is_editing:=This:C1470.is_editing
	
	$vL_form_event:=Form event code:C388
	If ($vL_form_event=On Double Clicked:K2:5)
		CALL SUBFORM CONTAINER:C1086(k_OnDoubleClicked)
		
	Else 
		
		Case of 
			: ($vL_form_event=On Mouse Leave:K2:34)
				This:C1470._is_inOut:=False:C215
				
			: ($vL_form_event=On Mouse Move:K2:35)
				If (This:C1470._is_inOut)
					This:C1470._l_mouseX:=mouseX
				Else 
					OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
					$vL_svg_scale:=waz__storage_prefs.l_svg_scale
					$vL_height*=$vL_svg_scale
					$vL_mouseY_threshold:=$vL_height*0.85
					If (mouseY>$vL_mouseY_threshold)
						This:C1470._is_inOut:=True:C214
					End if 
				End if 
				
			: ($vL_form_event=On Clicked:K2:4)
				If ($is_editing)
					$vT_idSvg:=SVG Find element ID by coordinates:C1054($vP_canvas->; mouseX; mouseY)  // ID de l'élément svg survolé
					$vL_value:=-1
					If ($vT_idSvg="card_@")
						$vL_value:=Num:C11($vT_idSvg)
					End if 
					This:C1470._ext_write_i($vL_value)
					CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
					This:C1470._l_mouseX:=mouseX
					This:C1470._l_mouseX_last:=-1
				Else 
					wox_sounds_play_edit()
				End if 
				
		End case 
	End if 
	//OBJECT SET HELP TIP($vP_canvas->; $vT_tip)
	// *
	// *****
	
	