
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	
	
	
Function record_checkout()->$isOk : Boolean
	//var $c4E_entity : 4D.Entity
	//var $vJ_okValidate : Object
	//$c4E_entity:=Form.c4E
	//$vJ_okValidate:=zen_okValidate_init
	//zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); False; "Fill in label!")
	//$isOk:=zen_okValidate_checkout($vJ_okValidate)
	$isOk:=True:C214
	
	
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
				: ($vT_objectName="field_logo")
					If (Right click:C712) && (Form:C1466.is_editing)
						This:C1470._btn_logo()
					End if 
					
				: ($vT_objectName="btn_from_PRO")
					This:C1470.colorsFromPRO()
			End case 
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _btn_logo()
	var $c4Fi_avatar : 4D:C1709.File
	var $vO_logo : Picture
	var $c4E_entity : 4D:C1709.Entity
	$c4Fi_avatar:=waz_avatars_choose()
	If ($c4Fi_avatar#Null:C1517)
		READ PICTURE FILE:C678($c4Fi_avatar.platformPath; $vO_logo)
		$c4E_entity:=Form:C1466.c4E
		$c4E_entity.logo:=$vO_logo
	End if 
	
	
Function colorsFromPRO()
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	$cE_SLOKAS:=Form:C1466.c4E
	$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
	If ($cE_PRODUCTS#Null:C1517)
		$cE_SLOKAS.colors:=$cE_PRODUCTS.colors
		OBJECT Get value:C1743("woc_colors").redraw()
	Else 
		cs:C1710.wox.SOUNDS.me.play_glop_no()
	End if 
	// *
	// *****
	
	