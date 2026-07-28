
Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("")
	// *
	// *****
	
	// ***** Handlers
	// *
Function onInitialize($cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity)  // Initialize Entity <User>
	var $vJ_business; $vJ_app_widgets; $vJ_woc_widgets : Object
	$vJ_business:=$cE_ZEN_DASHBOARD.j_biz
	If ($vJ_business=Null:C1517)
		$vJ_business:=New object:C1471()
		$cE_ZEN_DASHBOARD.j_biz:=$vJ_business
		$vJ_business.l_display_shape:=-4  // Shape for display
		$vJ_business.l_shape:=-1  // Shape for all
		$vJ_business.t_4Dcorner:=""
		//$vJ_business.t_github:=""
	End if 
	$vJ_app_widgets:=app__storage_widgets()
	$vJ_woc_widgets:=woc__storage_widgets()
	This:C1470.init_business_prop("output"; $vJ_business; $vJ_app_widgets)  // Output
	This:C1470.init_business_prop("metarect"; $vJ_business; $vJ_woc_widgets)  // Metarect
	This:C1470.init_business_prop("picture"; $vJ_business; $vJ_app_widgets)  // Picture
	This:C1470.init_business_prop("text"; $vJ_business; $vJ_app_widgets)  // Text
	
	
	
Function onValidate($cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity)  // Copy Entity <User> into the right place
	var $vJ_business; $vJ_app_widgets; $vJ_woc_widgets; $vJ_widget; $vJ_prefs : Object
	var $vC_at_woc_tag : Collection
	var $vT_tag : Text
	This:C1470.onInitialize($cE_ZEN_DASHBOARD)
	$vJ_business:=$cE_ZEN_DASHBOARD.j_biz
	$vJ_app_widgets:=app__storage_widgets()
	$vJ_woc_widgets:=woc__storage_widgets()
	This:C1470.set_business_prop("output"; $vJ_business; $vJ_app_widgets)  // Output
	This:C1470.set_business_prop("metarect"; $vJ_business; $vJ_woc_widgets)  // Metarect
	This:C1470.set_business_prop("picture"; $vJ_business; $vJ_app_widgets)  // Picture
	This:C1470.set_business_prop("text"; $vJ_business; $vJ_app_widgets)  // Text
	
	$vC_at_woc_tag:=New collection:C1472()
	$vC_at_woc_tag.push("colors"; "alColors"; "one2two")
	For each ($vT_tag; $vC_at_woc_tag)
		$vJ_widget:=$vJ_woc_widgets["j_"+$vT_tag]
		Use ($vJ_widget)
			$vJ_widget.l_shape:=$vJ_business.l_shape
		End use 
	End for each 
	
	$vJ_prefs:=app__storage_prefs()
	Use ($vJ_prefs)
		$vJ_prefs.l_display_shape:=$vJ_business.l_display_shape
	End use 
	
	// *
	// *****
	
	
	// *****
	// *
Function init_business_prop($vT_tag : Text; $vJ_business : Object; $vJ_widgets : Object)
	var $vJ_value : Object
	var $vT_property : Text
	$vT_property:="j_"+$vT_tag
	$vJ_value:=$vJ_business[$vT_property]
	If ($vJ_value=Null:C1517)
		$vJ_business[$vT_property]:=OB Copy:C1225($vJ_widgets[$vT_property].j_value)
	End if 
	
Function set_business_prop($vT_tag : Text; $vJ_business : Object; $vJ_widgets : Object)
	var $vJ_widget : Object
	var $vT_property : Text
	$vT_property:="j_"+$vT_tag
	$vJ_widget:=$vJ_widgets[$vT_property]
	Use ($vJ_widget)
		$vJ_widget.j_value:=OB Copy:C1225($vJ_business[$vT_property]; ck shared:K85:29)
	End use 
	// *
	// *****
	
	
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
		: ($vL_event_code=On Unload:K2:2)
			//This.last_updates()
			//wox_prefs_windows_save()
			
			//: ($vL_event_code=On Bound Variable Change)
			//This._update()
			
			//: ($vL_event_code=On Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Drop)
	End case 
	// *
	// *****
	
	
	// MARK: - Manager
	
	//Function _update()
	//This._resize()
	//This._redraw()
	
	
	
	// *****
	// *
Function _resize()
	//OBJECT GET SUBFORM CONTAINER SIZE($vL_width; $vL_height)
	var $vC_at_tags; $vC_at_tag : Collection
	var $idx : Integer
	var $vJ_widget; $vJ_biz; $vJ_woc_widget; $vJ_sem_widget : Object
	var $vT_tag : Text
	var $cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity
	
	$cE_ZEN_DASHBOARD:=Form:C1466.c4E
	This:C1470.onInitialize($cE_ZEN_DASHBOARD)
	$vC_at_tags:=New collection:C1472()
	$vC_at_tags.push("output"; "metarect"; "picture"; "text")
	$idx:=0
	For each ($vT_tag; $vC_at_tags)
		$vJ_widget:=OBJECT Get value:C1743("sem_"+$vT_tag)
		If ($idx=1)
			$vJ_widget.j_value:=This:C1470.biz_woc_bind_to($vT_tag)
		Else 
			$vJ_widget.j_value:=This:C1470.biz_app_bind_to($vT_tag)
		End if 
		$vJ_widget.resize()
		$idx+=1
	End for each 
	
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vC_at_tag:=New collection:C1472()
	$vC_at_tag.push("shape"; "display_shape")
	For each ($vT_tag; $vC_at_tag)
		$vJ_woc_widget:=OBJECT Get value:C1743("woc_"+$vT_tag)
		$vJ_woc_widget.bind_to("l_"+$vT_tag; $vJ_biz)
		$vJ_woc_widget.l_mode:=3  // Glyphs&Shapes
		$vJ_woc_widget.l_colors:=0xAA021032  // [swo:33] – [swo:50]
		$vJ_woc_widget.resize()
	End for each 
	
	
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vC_at_tag:=New collection:C1472()
	$vC_at_tag.push("4Dcorner")
	For each ($vT_tag; $vC_at_tag)
		$vJ_sem_widget:=OBJECT Get value:C1743("sem_"+$vT_tag)
		$vJ_sem_widget.bind_to("t_"+$vT_tag; $vJ_biz)
		$vJ_sem_widget.resize()
	End for each 
	// *
	// *****
	
	
Function _redraw()
	var $vC_at_tags; $vC_at_tag : Collection
	var $vJ_widget; $vJ_woc_shape; $vJ_sem_widget : Object
	var $vT_tag : Text
	$vC_at_tags:=New collection:C1472()
	$vC_at_tags.push("output"; "metarect"; "picture"; "text")
	For each ($vT_tag; $vC_at_tags)
		$vJ_widget:=OBJECT Get value:C1743("sem_"+$vT_tag)
		$vJ_widget.redraw()
	End for each 
	
	$vC_at_tag:=New collection:C1472()
	$vC_at_tag.push("shape"; "display_shape")
	For each ($vT_tag; $vC_at_tag)
		$vJ_woc_shape:=OBJECT Get value:C1743("woc_"+$vT_tag)
		$vJ_woc_shape.redraw()
	End for each 
	
	$vJ_sem_widget:=OBJECT Get value:C1743("sem_4Dcorner")
	$vJ_sem_widget.redraw()
	
	
	// *****
	// *
Function biz_app_bind_to($vT_tag : Text)->$vJ_value : Object
	var $vJ_biz : Object
	var $vT_property : Text
	var $cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity
	$cE_ZEN_DASHBOARD:=Form:C1466.c4E
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vT_property:="j_"+$vT_tag
	$vJ_value:=$vJ_biz[$vT_property]
	If ($vJ_value=Null:C1517)
		$vJ_value:=OB Copy:C1225(app__storage_widgets()[$vT_property].j_value)
		$vJ_biz[$vT_property]:=$vJ_value
	End if 
	
	
Function biz_woc_bind_to($vT_tag : Text)->$vJ_value : Object
	var $vJ_biz : Object
	var $vT_property : Text
	var $cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity
	$cE_ZEN_DASHBOARD:=Form:C1466.c4E
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vT_property:="j_"+$vT_tag
	$vJ_value:=$vJ_biz[$vT_property]
	If ($vJ_value=Null:C1517)
		$vJ_value:=OB Copy:C1225(woc__storage_widgets()[$vT_property].j_value)
		$vJ_biz[$vT_property]:=$vJ_value
	End if 
	// *
	// *****
	