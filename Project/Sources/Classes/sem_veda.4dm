
Class extends ZEN__WIDGETS
property l_value : Integer
property is_contract; is_editing : Boolean
property j_links : Object
property cES_SLOKAS : 4D:C1709.EntitySelection


Class constructor
	// ***** Parameters
	// *
	var $vJ_links : Object
	Super:C1705("j_veda")
	This:C1470.l_value:=0
	This:C1470.is_contract:=False:C215
	$vJ_links:=This:C1470._do_links()
	This:C1470.j_links:=$vJ_links
	// *
	// *****
	
Function _do_links()->$vJ_links : Object  // Links hardly defined ♻️
	var $vC_links : Collection
	$vJ_links:=New object:C1471()
	$vC_links:=New collection:C1472()  // wok
	$vJ_links.wok:=$vC_links
	$vC_links:=New collection:C1472("wok")  // wox
	$vJ_links.wox:=$vC_links
	$vC_links:=New collection:C1472("wox")  // wod
	$vJ_links.wod:=$vC_links
	$vC_links:=New collection:C1472("wox")  // wom
	$vJ_links.wom:=$vC_links
	$vC_links:=New collection:C1472("wox")  // woc
	$vJ_links.woc:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc")  // waz
	$vJ_links.waz:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc"; "waz")  // wor
	$vJ_links.wor:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc")  // wog
	$vJ_links.wog:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc")  // wot
	$vJ_links.wot:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc")  // wob
	$vJ_links.wob:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc")  // wos
	$vJ_links.wos:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc"; "waz")  // wqr
	$vJ_links.wqr:=$vC_links
	$vC_links:=New collection:C1472("wox"; "woc"; "waz"; "wor"; "wob"; "wqr")  // zen
	$vJ_links.zen:=$vC_links
	//$vC_links:=New collection("wox"; "woc"; "waz"; "wor"; "wob"; "wqr"; "zen")  // sem
	$vC_links:=New collection:C1472("zen")  // orw
	$vJ_links.sem:=$vC_links
	//$vC_links:=New collection("wox"; "woc"; "waz"; "wor"; "wob"; "wqr"; "zen")  // orw
	$vC_links:=New collection:C1472("zen")  // orw
	$vJ_links.orw:=$vC_links
	
	
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
			
			//: ($vL_event_code=On Clicked)
			//Case of
			//: ($vT_objectName="canvas")
			//This._canvas_ui()
			
			//End case
			
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
	var $vL_value : Integer
	var $vP_canvas : Pointer
	$vL_value:=This:C1470._ext_read_i()
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	$vP_canvas->:=sem_svg_veda_object($vP_canvas; This:C1470)
	// *
	// *****
	
	
	// *****
	// *
Function _canvas_ui($vP_canvas : Pointer)
	var $is_editing; $is_clicked : Boolean
	var $vL_value; $vL_type; $vL_tt_signs; $vL_idx; $vL_value_last : Integer
	var $vC_at_properties : Collection
	var $vT_tip : Text
	$is_editing:=This:C1470.is_editing
	
	$is_clicked:=(Form event code:C388=On Clicked:K2:4)
	If ($is_clicked && Right click:C712)
		If (waz_io_confirm_popup("Copy picture?"))
			SET PICTURE TO PASTEBOARD:C521($vP_canvas->)
		End if 
	Else 
		If (Form event code:C388=On Double Clicked:K2:5)
			CALL SUBFORM CONTAINER:C1086(k_OnDoubleClicked)
			
		Else 
			$vL_type:=This:C1470._svg_item(mouseX; mouseY; $vP_canvas; ->$vL_idx)
			$vC_at_properties:=New collection:C1472()
			Case of 
				: (Form event code:C388=On Mouse Move:K2:35) || $is_clicked
					//: ($is_clicked)
					Case of 
						: ($vL_type=0)
							//$is_clicked:=False
							
						: ($vL_type=1)
							$vL_tt_signs:=This:C1470.cES_SLOKAS.length
							If ($vL_idx<$vL_tt_signs)
								$vT_tip:=This:C1470._get_tip($vL_type; $vL_idx)
							End if 
							
						: ($vL_type=2)
							$vT_tip:=This:C1470._get_tip($vL_type; $vL_idx)
							$is_clicked:=False:C215
							//Else 
							//$is_clicked:=False
					End case 
			End case 
		End if 
		OBJECT SET HELP TIP:C1181($vP_canvas->; $vT_tip)
		
		If ($is_clicked)
			If ($is_editing)
				$vL_value:=This:C1470._ext_read_i()
				$vL_value_last:=$vL_value
				If $vL_idx<0
					$vL_value:=0
				Else 
					$vL_value:=This:C1470._get_value_clicked($vL_value; $vL_idx)
				End if 
				If ($vL_value#$vL_value_last)  // Filter no changes
					This:C1470._ext_write_i($vL_value)
					CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
					This:C1470._redraw()
				End if 
			Else 
				cs:C1710.wox.SOUNDS.me.play_edit()
			End if 
		End if 
	End if 
	
	
Function _get_value_clicked($vL_value : Integer; $vL_idx : Integer)->$vL_answer : Integer
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $is_shift; $is_command : Boolean
	If $vL_idx<0
		$vL_answer:=0
	Else 
		$cES_SLOKAS:=This:C1470.cES_SLOKAS
		$cE_SLOKAS:=$cES_SLOKAS[$vL_idx]
		$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
		$is_shift:=Shift down:C543
		$is_command:=Macintosh command down:C546 || Macintosh control down:C544
		If ($cE_PRODUCTS#Null:C1517)
			$vL_value:=This:C1470._ext_read_i()
			Case of 
				: $is_command
					$vL_answer:=wox_bit_not($vL_value; $vL_idx)
					
				: $is_shift
					$vL_answer:=wox_bit_set($vL_value; $vL_idx; True:C214)
					
				Else 
					$vL_answer:=wox_bit_set(0; $vL_idx; True:C214)
					
			End case 
		Else 
			$vL_answer:=0
			If (Not:C34($vL_value ?? $vL_idx))
				$vL_answer:=wox_bit_not($vL_answer; $vL_idx)
				$vL_idx+=1
				For each ($cE_SLOKAS; $cES_SLOKAS; $vL_idx)
					$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
					If ($cE_PRODUCTS=Null:C1517)
						break
					Else 
						$vL_answer:=wox_bit_not($vL_answer; $vL_idx)
					End if 
					$vL_idx+=1
				End for each 
			End if 
		End if 
	End if 
	
	
Function _get_tip($vL_type : Integer; $vL_idx : Integer)->$vT_tip : Text
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $cES_SLOKAS : cs:C1710.SLOKASSelection
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	Case of 
		: ($vL_type=1)
			$cES_SLOKAS:=This:C1470.cES_SLOKAS
			$cE_SLOKAS:=$cES_SLOKAS[$vL_idx]
			$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
			If ($cE_PRODUCTS#Null:C1517)
				$vT_tip:=""
				//$vT_tip+=$cE_PRODUCTS.label+Char(Carriage return)
				$vT_tip+=$cE_PRODUCTS.title+Char:C90(Carriage return:K15:38)
				$vT_tip+=$cE_PRODUCTS.subtitle+Char:C90(Carriage return:K15:38)
				$vT_tip+="Mantra: "+$cE_PRODUCTS.mantra+Char:C90(Carriage return:K15:38)
				$vT_tip+="Tagline: "+$cE_PRODUCTS.tagline
			Else 
				$vT_tip+=$cE_SLOKAS.label
			End if 
			
		: ($vL_type=2)
			$vT_tip:="Link: "+String:C10($vL_idx; "0000")
			
	End case 
	
	
Function _svg_item($x : Integer; $y : Integer; $vP_canvas : Pointer; $vP_vL_idx : Pointer)->$vL_type : Integer
	var $vL_idx : Integer
	var $vT_idSvg : Text
	$vT_idSvg:=SVG Find element ID by coordinates:C1054($vP_canvas->; $x; $y)  // ID de l'élément svg survolé
	Case of 
		: ($vT_idSvg="root")
			$vL_type:=0
			$vL_idx:=-1
			
		: ($vT_idSvg="idx_@")
			$vL_type:=1
			$vL_idx:=Num:C11($vT_idSvg)
			
		: ($vT_idSvg="link_@")
			$vL_type:=2
			$vL_idx:=Num:C11($vT_idSvg)
			
		Else 
			$vL_type:=0
			$vL_idx:=-1
			
	End case 
	$vP_vL_idx->:=$vL_idx
	// *
	// *****
	
	