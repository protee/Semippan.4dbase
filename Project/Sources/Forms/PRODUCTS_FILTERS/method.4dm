
//// Class instance is made from the list manager
//Form.form_events()

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		vJ_picker_class(cs:C1710.PRODUCTS_FILTERS.new())
		
	Else 
		Form:C1466._filters_events()
End case 



