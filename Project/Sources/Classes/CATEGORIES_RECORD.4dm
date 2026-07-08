
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	//OBJECT SET ENTERABLE(*; "LB_rtc"; Form.is_editing)
	//This.lb_rtc_load()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.colors=0); True:C214; "Fill in colors!")
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
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vL_event_code:=Form event code:C388
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
					
					//: ($vT_objectName="bt_partner")
					//This.partner_choose()
					
					//: ($vT_objectName="bt_print")
					//This.print()
					
			End case 
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	
	// *****
	// *
Function _btn_logo()
	var $c4Fi_avatar : 4D:C1709.File
	var $cE_categories : cs:C1710.CATEGORIESEntity
	var $vO_logo : Picture
	$c4Fi_avatar:=waz_avatars_choose()
	If ($c4Fi_avatar#Null:C1517)
		READ PICTURE FILE:C678($c4Fi_avatar.platformPath; $vO_logo)
		$cE_categories:=Form:C1466.c4E
		$cE_categories.logo:=$vO_logo
	End if 
	// *
	// *****
	