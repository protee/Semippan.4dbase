
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470.l_timer:=1
	//If (Form.is_new) && Not(Form.is_dup)
	//$cE_MEDIA:=Form.c4E
	////$cE_MEDIA.colorsSVG:=woc_sp_colors_from_sf(k_MDcolorTransparent; k_MDcolorTransparent)
	//$vJ_value:=$cE_MEDIA.j_dcox
	//$vJ_value.l_main:=0xFEF5
	//$vC_at_bind:=sem_get_at_dcox()
	//For each ($vT_bind; $vC_at_bind)
	//$vJ_bind:=New object()
	//$vJ_value["j_"+$vT_bind]:=$vJ_bind
	//$vJ_bind.l_colors:=0xF1F4
	//$vJ_bind.l_stroke:=2
	//$vJ_bind.l_add_stroke:=0
	//$vJ_bind.l_fill:=2
	//$vJ_bind.l_add_fill:=0
	//End for each
	//End if
	This:C1470.redraw()
	
	
Function record_checkout()->$isOk : Boolean
	//$c4E_entity:=Form.c4E
	//var $vJ_okValidate : Object
	//$vJ_okValidate:=zen_okValidate_init
	//zen_okValidate_check($vJ_okValidate; ($c4E_entity.fileName=""); False; "Fill in fileName!")
	//$isOk:=zen_okValidate_checkout($vJ_okValidate)
	$isOk:=True:C214
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=Form:C1466.is_touched
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched()
	End if 
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
Function record_save($c4E_entity : 4D:C1709.Entity)
	Super:C1706.record_save($c4E_entity)
	zen_schemas_clear(Form:C1466.t_table; True:C214)
	// *
	// *****
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $vC_c4E_related : Collection
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="btn_template")
					This:C1470._from_template()
					
				: ($vT_objectName="bt_relate_ones")
					//$vC_c4E_related:=sem__linked_related_one("MEDIA_BANKS")
					//$vC_c4E_related:=sem__linked_related_one("MEDIA_BANKS.BANKS_POCKS")
					$vC_c4E_related:=zen_linked_related_ones("MEDIA_BANKS.BANKS_PACKS")
					waz_io_alert_popup($vC_c4E_related[1].label)
			End case 
			
			//: ($vL_event_code=On Double Clicked)
			//Case of
			//: ($vT_objectName="oO_svg")
			//This._copy_PP($vT_objectName)
			
			//: ($vT_objectName="oO_svg1")
			//This._copy_PP($vT_objectName)
			//End case
			
			
			//: ($vL_event_code=On Resize)
			//SET TIMER(1)
			
			//: ($vL_event_code=On Timer)
			//SET TIMER(0)
			//This.redraw()
			
			
			//: ($vL_event_code=On Double Clicked)
			
		: ($vL_event_code=On Data Change:K2:15)
			This:C1470.redraw()
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
Function redraw()
	var $vC_al_colors1; $vC_al_colors; $vC_c4E_related : Collection
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $vJ_widget : Object
	var $vL_colors_in : Integer
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_PACKS : cs:C1710.PACKSEntity
	This:C1470._picture_upd()
	This:C1470.set_internal_is_svg()
	
	$vL_colors_in:=0
	$vC_c4E_related:=zen_linked_related_ones("MEDIA_BANKS.BANKS_PACKS")
	$cE_PACKS:=$vC_c4E_related[1]
	$cE_BANKS:=$vC_c4E_related[0]
	//$vJ_alColors:=$cE_PACKS#Null ? $cE_PACKS.j_alColors : New collection()
	//$vL_colorsIdx:=$cE_BANKS#Null ? $cE_BANKS.colorsIdx : -1
	//$vL_colors_in:=woc_sp_colors_from_alColorsIdx($vJ_alColors; $vL_colorsIdx)
	$vL_colors_in:=($cE_PACKS#Null:C1517 && $cE_BANKS#Null:C1517) ? woc_sp_colors_from_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx) : 0
	Form:C1466.l_colors_in:=$vL_colors_in
	
	This:C1470._get_SETS_colors()
	$cE_MEDIA:=Form:C1466.c4E
	$vC_al_colors1:=This:C1470._get_colors1($cE_MEDIA)
	This:C1470.redraw_colors1($vC_al_colors1)
	
	$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
	$vJ_widget.al_in:=$vC_al_colors1
	$vJ_widget.resize()  // To affect sub object to already binded j_dcox
	$vJ_widget.redraw()
	
	$vC_al_colors:=This:C1470._get_colors($cE_MEDIA; $vC_al_colors1)
	This:C1470.redraw_colors($vC_al_colors)
	This:C1470.redraw_pict_dcox()
	
	
Function _pict_chgt()
	//This._picture_upd()
	//This._media_chgt()
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $vJ_widget : Object
	$cE_MEDIA:=Form:C1466.c4E
	$cE_MEDIA.isLinkedPicture:=True:C214
	$vJ_widget:=OBJECT Get value:C1743("waz_source").redraw()
	This:C1470.redraw()
	
Function _picture_upd()
	var $cE_pictures : cs:C1710.PICTURESEntity
	var $vJ_widget; $vJ_zen_pictures : Object
	$vJ_widget:=OBJECT Get value:C1743("woc_picture")
	$vJ_zen_pictures:=OBJECT Get value:C1743("zen_pictures")
	$cE_pictures:=$vJ_zen_pictures.c4E
	$vJ_widget.o_picture:=$cE_pictures.picture
	$vJ_widget.redraw()
	This:C1470.set_picture_is_svg()
	
	
Function set_internal_is_svg()
	var $vP_ : Pointer
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	$vP_:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_isSvg")
	$cE_MEDIA:=Form:C1466.c4E
	x_btn_toggleSet($vP_; Num:C11(img_tools_isCodec($cE_MEDIA.picture)))
	
	
Function set_picture_is_svg()
	var $vP_ : Pointer
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743("woc_picture")
	$vP_:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_isSvg1")
	x_btn_toggleSet($vP_; Num:C11(img_tools_isCodec($vJ_widget.o_picture)))
	
	
	
	// *****
	// *
Function _get_SETS_colors()->$vC_al_colors : Collection
	var $is_btn : Boolean
	var $cE_SETS : cs:C1710.SETSEntity
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $vJ_dcox : Object
	var $vL_colors_in : Integer
	$cE_SETS:=This:C1470._get_cE_SETS()
	
	$vL_colors_in:=Form:C1466.l_colors_in
	
	$is_btn:=$cE_SETS.type>0
	$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
	$vJ_dcox:=$cE_TEMPLATES.j_dcox
	$vC_al_colors:=woc_dcox_al_colors_init($vJ_dcox; $is_btn; $vL_colors_in)
	$vJ_dcox:=$cE_SETS.j_dcox
	$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors)
	Form:C1466.al_SETS_colors:=$vC_al_colors
	
	
Function _get_colors1($cE_MEDIA : cs:C1710.MEDIAEntity)->$vC_al_colors1 : Collection
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $vJ_dcox : Object
	
	$vC_al_colors1:=Form:C1466.al_SETS_colors
	$cE_TEMPLATES:=$cE_MEDIA.MEDIA_TEMPLATES
	If ($cE_TEMPLATES#Null:C1517)
		$vJ_dcox:=$cE_TEMPLATES.j_dcox
		$vC_al_colors1:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors1)
	End if 
	Form:C1466.al_colors1:=$vC_al_colors1
	
	
Function _get_colors($cE_MEDIA : cs:C1710.MEDIAEntity; $vC_al_colors_in : Collection)->$vC_al_colors : Collection
	var $vJ_dcox : Object
	
	$vC_al_colors_in:=$vC_al_colors_in#Null:C1517 ? $vC_al_colors_in : Form:C1466.al_colors1
	$vJ_dcox:=$cE_MEDIA.j_dcox
	$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors_in)
	Form:C1466.al_colors:=$vC_al_colors
	// *
	// *****
	
	
	// *****
	// *
Function _get_cE_SETS()->$cE_SETS : cs:C1710.SETSEntity
	$cE_SETS:=Form:C1466.j_DTO.cE_SETS
	
	
	// *
	// *****
	
Function redraw_colors1($vC_al_colors1 : Collection)
	var $vC_at_bind : Collection
	var $idx; $tt : Integer
	var $vJ_widget : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible : Boolean
	
	$vC_al_colors1:=$vC_al_colors1#Null:C1517 ? $vC_al_colors1 : Form:C1466.al_colors1
	$tt:=$vC_al_colors1.length
	$vC_at_bind:=woc_dcox_at_get()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="woc_"+$vT_bind+"1"
		$is_visible:=$idx<$tt
		OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
		If ($is_visible)
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.is_editing:=False:C215
			$vJ_widget.l_colors:=$vC_al_colors1[$idx]
			$vJ_widget.redraw()
		End if 
		$idx+=1
	End for each 
	
	
	
Function _media_chgt($vJ_widget : Object)
	//This.redraw_colors()
	This:C1470.redraw_pict_dcox()
	
	
	
	//Function _dcox_init()
	//$cE_MEDIA:=Form.c4E
	//$vJ_widget:=OBJECT Get value("woc_dcox")
	//$vJ_widget.al_in:=$vC_al_colors1
	//$vJ_widget.redraw()
	
	
Function _template_chgt($vJ_zen_templates : Object)
	var $vC_al_colors1; $vC_al_colors : Collection
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $vJ_widget : Object
	This:C1470.is_touched:=True:C214
	$cE_MEDIA:=Form:C1466.c4E
	$vC_al_colors1:=This:C1470._get_colors1($cE_MEDIA)
	$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
	$vJ_widget.al_in:=$vC_al_colors1
	$vJ_widget.redraw()
	This:C1470.redraw_colors1($vC_al_colors1)
	$vC_al_colors:=This:C1470._get_colors($cE_MEDIA; $vC_al_colors1)
	This:C1470.redraw_colors($vC_al_colors)
	This:C1470.redraw_pict_dcox()
	
	
	
Function _dcox_chgt($vJ_widget : Object)
	var $vC_al_colors : Collection
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	This:C1470.is_touched:=True:C214
	$cE_MEDIA:=Form:C1466.c4E
	$vC_al_colors:=This:C1470._get_colors($cE_MEDIA)
	This:C1470.redraw_colors($vC_al_colors)
	This:C1470.redraw_pict_dcox()
	
	
	
	
	// *****
	// *
Function redraw_colors($vC_al_colors : Collection)
	var $vC_at_bind : Collection
	var $idx; $tt : Integer
	var $vJ_widget : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible : Boolean
	
	$vC_al_colors:=$vC_al_colors#Null:C1517 ? $vC_al_colors : Form:C1466.al_colors
	$tt:=$vC_al_colors.length
	$vC_at_bind:=woc_dcox_at_get()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="woc_"+$vT_bind
		$is_visible:=$idx<$tt
		OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
		If ($is_visible)
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.is_editing:=False:C215
			$vJ_widget.l_colors:=$vC_al_colors[$idx]
			$vJ_widget.redraw()
		End if 
		$idx+=1
	End for each 
	
	
Function redraw_pict_dcox()
	var $vC_at_bind; $vC_al_colors : Collection
	var $vL_colors_out; $idx; $tt : Integer
	var $vL_brightness : Integer
	var $vJ_widget : Object
	var $vJ_picture : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible; $is_grey_scale; $is_img_offset; $is_vertical : Boolean
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $vO_picture; $vO_preview; $vO_img_picture : Picture
	var $cE_SETS : cs:C1710.SETSEntity
	
	$cE_SETS:=This:C1470._get_cE_SETS()
	If ($cE_SETS#Null:C1517)
		$cE_MEDIA:=Form:C1466.c4E
		$vJ_picture:=$cE_SETS.j_picture
		$is_vertical:=$cE_SETS.type=2
		$vC_al_colors:=Form:C1466.al_colors
		
		$vO_img_picture:=$cE_MEDIA.isLinkedPicture ? $cE_MEDIA.MEDIA_PICTURES.picture : $cE_MEDIA.picture
		
		// DCOX -> separated, or H | V, for LB or output
		$tt:=$vC_al_colors.length
		$vC_at_bind:=woc_dcox_at_get()
		$idx:=0
		For each ($vT_bind; $vC_at_bind)
			$vT_widget:="woc_picture_"+$vT_bind
			$is_visible:=$idx<$tt
			OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
			If ($is_visible)
				$vL_colors_out:=$vC_al_colors[$idx]
				$vL_brightness:=$vJ_picture["l_br_"+$vT_bind]
				$is_grey_scale:=($idx=3) && $vJ_picture.is_greyDisabled
				$is_img_offset:=($idx=1) && $vJ_picture.is_offsetClick
				$vO_picture:=sem_img_calculate($cE_SETS; $cE_MEDIA; $vO_img_picture; $vL_colors_out; $vL_brightness; $is_grey_scale; $is_img_offset)
				
				// OUTPUT
				$vJ_widget:=OBJECT Get value:C1743($vT_widget)
				$vJ_widget.o_picture:=$vO_picture
				$vJ_widget.redraw()
				$vO_preview:=$idx=0 ? $vO_picture : ($is_vertical ? $vO_preview/$vO_picture : $vO_preview+$vO_picture)
			End if 
			$idx+=1
		End for each 
		
		$vJ_widget:=OBJECT Get value:C1743("woc_preview")
		$vJ_widget.o_picture:=$vO_preview
		$vJ_widget.redraw()
		
	End if 
	
	
Function _from_template()
	var $isOk : Boolean
	var $cE_templates : cs:C1710.TEMPLATESEntity
	var $vT_table : Text
	var $vC_al_colors1; $vC_al_colors : Collection
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $vJ_widget : Object
	var $vV_UID : Variant
	$vT_table:="TEMPLATES"
	$vV_UID:=zen_table_picker_one($vT_table)
	$isOk:=zen_UID_isOk($vV_UID)
	If ($isOk)
		$cE_templates:=ds:C1482.TEMPLATES.get($vV_UID)
		$cE_MEDIA:=Form:C1466.c4E
		wox_vJ_overloads($cE_templates.j_dcox; $cE_MEDIA.j_dcox)
		$vC_al_colors1:=Form:C1466.al_colors1
		$vJ_widget:=OBJECT Get value:C1743("woc_dcox")
		$vJ_widget.al_in:=$vC_al_colors1
		$vJ_widget.redraw()
		This:C1470.redraw_colors1($vC_al_colors1)
		$vC_al_colors:=This:C1470._get_colors($cE_MEDIA; $vC_al_colors1)
		This:C1470.redraw_colors($vC_al_colors)
		This:C1470.redraw_pict_dcox()
	End if 
	
	