
Class extends ZENH_TABLES_FILTERS

Class constructor($vT_table : Text; $vL_table : Integer; $is_local : Boolean)
	Super:C1705($vT_table; $vL_table; $is_local)
	
	//This.j_edit:=OB Copy($vJ_params)
	
	var $vJ_params : Object
	$vJ_params:=New object:C1471
	var $vC_aj_filters : Collection
	$vC_aj_filters:=This:C1470.init_search()
	$vJ_params.aj_search:=$vC_aj_filters
	This:C1470.j_params:=$vJ_params
	This:C1470.set_widgets()
	
	
Function _filters_events()
	
	
	// *****
	// *
Function init_search()->$vC_aj_filters : Collection  // Filter's description
	$vC_aj_filters:=New collection:C1472
	$vC_aj_filters.push(This:C1470._get_search_c4ES("zen_categories"; "CATEGORIES"))
	$vC_aj_filters.push(This:C1470._get_search_menuBtn("waz_imgColor"))
	$vC_aj_filters.push(This:C1470._get_search_menuBtn("waz_imgStroke"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isSvg"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isActive"; True:C214))
	//This.clear_search($vC_aj_filters)
	
	
Function _filters()
	//cs.wox.TUNES.me.play_beep()
	This:C1470.get_widgets()
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function DO_filters($c4ES_selection_in : 4D:C1709.EntitySelection)->$c4ES_selection : 4D:C1709.EntitySelection
	var $vC_aj_filters : Collection
	var $vC_aj_filters_in : Collection
	$vC_aj_filters:=$vC_aj_filters_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_filters_in
	
	var $c4ES_selection_temp; $c4ES; $c4ES_pictures : 4D:C1709.EntitySelection
	$c4ES_selection_temp:=$c4ES_selection_in
	//$vC_query:=New collection()
	
	var $vT_AND : Text
	$vT_AND:=" AND "
	
	var $vJ_filter : Object
	var $is_filter; $is_filtered; $is_svg : Boolean
	var $vT_name : Text
	var $vL_value : Integer
	$is_filtered:=False:C215
	For each ($vJ_filter; $vC_aj_filters)
		$vT_name:=$vJ_filter.t_name
		Case of 
			: ($vT_name="zen_categories")
				$c4ES:=$vJ_filter.c4ES
				$is_filter:=($c4ES#Null:C1517) && ($c4ES.length#0)
				If ($is_filter)
					$c4ES_pictures:=$c4ES.CATEGORIES_PICTURES
					$c4ES_selection_temp:=$c4ES_selection_temp.and($c4ES_pictures)
				End if 
				
			: ($vT_name="waz_imgColor")
				$vL_value:=$vJ_filter.l_value
				$is_filter:=($vL_value>=0)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("imgColor = :1"; $vL_value)
				End if 
				
			: ($vT_name="waz_imgStroke")
				$vL_value:=$vJ_filter.l_value
				$is_filter:=($vL_value>=0)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("imgStroke = :1"; $vL_value)
				End if 
				
				
			: ($vT_name="waz_isSvg")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					//$c4ES_selection_temp:=$c4ES_selection_temp.query("isSvg=:1"; ($vL_value=1))
					$is_svg:=($vL_value=1)
					$c4ES_selection_temp:=$c4ES_selection_temp.query(Formula:C1597(img_tools_isCodec(This:C1470.picture)=$is_svg))
				End if 
				
			: ($vT_name="waz_isActive")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("isActive=:1"; ($vL_value=1))
				End if 
				
				
		End case 
		$is_filtered:=$is_filtered || $is_filter
	End for each 
	
	$c4ES_selection:=$is_filtered ? $c4ES_selection_temp : $c4ES_selection_in
	
	