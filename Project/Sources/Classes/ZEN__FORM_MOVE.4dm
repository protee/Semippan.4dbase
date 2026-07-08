
Class constructor($vL_winRef : Integer; $vL_width_add : Integer)
	var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	var $vL_width_start; $vL_height_start; $vL_width; $vL_height; $vL_height_add; $vL_duration : Integer
	var $vJ_animate; $vJ_this; $vJ_form_prefs; $vJ_settings : Object
	var $vT_worker : Text
	var $is_width_add : Boolean
	
	
	$vJ_form_prefs:=Form:C1466.j_prefs
	If ($vJ_form_prefs=Null:C1517)  // Only resize !
		$vL_height_add:=0
		If ($vL_width_add#0)
			RESIZE FORM WINDOW:C890($vL_width_add; $vL_height_add)
		End if 
		
	Else 
		$is_width_add:=Count parameters:C259>=2
		GET WINDOW RECT:C443($vL_left; $vL_top; $vL_right; $vL_bottom; $vL_winRef)
		$vL_width_start:=$vL_right-$vL_left
		$vL_height_start:=$vL_bottom-$vL_top
		
		$vL_width:=$vJ_form_prefs.l_width
		$vL_height:=$vJ_form_prefs.l_height
		If ($is_width_add)
			$vJ_form_prefs.l_width:=$vL_width_start+$vL_width_add  // 
		Else 
			$vL_width_add:=$vL_width-$vL_width_start
		End if 
		$vL_height_add:=$vL_height-$vL_height_start
		If ($vL_width_add#0) || ($vL_height_add#0)
			RESIZE FORM WINDOW:C890($vL_width_add; $vL_height_add)
		End if 
		
		$vJ_form_prefs.l_left_from:=$vL_left
		$vJ_form_prefs.l_top_from:=$vL_top
		//$vJ_form_prefs.l_width_start:=$vL_width_start
		//$vJ_form_prefs.l_height_start:=$vL_height_start
		
		$vJ_this:=This:C1470
		$vJ_animate:=New object:C1471()
		This:C1470.j_animate:=$vJ_animate
		$vJ_settings:=zen__storage_prefs().j_settings
		$vL_duration:=$vJ_settings.l_tempo
		$vJ_animate.l_duration:=$vL_duration
		$vJ_animate.l_curve:=$vJ_settings.l_curve
		$vT_worker:="zen_move_worker_"+String:C10($vL_winRef)
		$vJ_animate.t_worker:=$vT_worker
		$vJ_animate.j_this:=This:C1470
		CALL WORKER:C1389($vT_worker; Formula:C1597($vJ_this.form_move_worker($1; $2)); $vJ_animate; $vL_winRef)
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function form_move_worker($vJ_animate : Object; $vL_winRef : Integer)
	var $vL_duration : Integer
	var $i; $vL_count; $vL_ticks_last : Integer
	var $vR_coef; $vR_step : Real
	var $vT_worker : Text
	var $vJ_this : Object
	
	$vJ_this:=$vJ_animate.j_this
	$vL_duration:=$vJ_animate.l_duration
	//$vL_duration:=$vL_duration<10 ? $vL_duration : 400  // In ms
	//$vL_count:=($vL_duration*60)/1000  // in ms => ticks => Count
	$vL_count:=$vL_duration<10 ? 0 : ($vL_duration*60)/1000  // in ms => ticks => Count
	If ($vL_count>0)
		$vR_step:=1/($vL_count-1)
		$vL_ticks_last:=0
		For ($i; 0; $vL_count)
			DELAY PROCESS:C323(Current process:C322; 1)
			CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_animate($1)); $vR_coef)
			$vR_coef+=$vR_step
		End for 
	End if 
	$vR_coef:=1
	CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_animate($1)); $vR_coef)
	$vT_worker:=$vJ_animate.t_worker
	KILL WORKER:C1390($vT_worker)
	
	
Function form_animate($vR_coef : Real)
	var $is_trigo; $is_first : Boolean
	var $vL_left_from; $vL_top_from; $vL_form_x; $vL_form_y; $vL_left; $vL_top : Integer
	var $vL_width; $vL_height : Integer
	var $vJ_animate; $vJ_form_prefs : Object
	
	$vJ_animate:=This:C1470.j_animate
	$is_trigo:=$vJ_animate.is_trigo
	
	$vJ_form_prefs:=Form:C1466.j_prefs
	$vL_left_from:=$vJ_form_prefs.l_left_from
	$vL_top_from:=$vJ_form_prefs.l_top_from
	$vL_left:=$vJ_form_prefs.l_left
	$vL_top:=$vJ_form_prefs.l_top
	
	$is_first:=($vR_coef=0)
	If ($is_first)
		$vL_form_x:=$vL_left_from
		$vL_form_y:=$vL_top_from
	Else 
		//$vR_coef:=This.math_curves($vR_coef; 4)
		$vR_coef:=wox_math_curves($vR_coef; $vJ_animate.l_curve)
		$vL_form_x:=$vL_left_from+(($vL_left-$vL_left_from)*$vR_coef)
		$vL_form_y:=$vL_top_from+(($vL_top-$vL_top_from)*$vR_coef)
	End if 
	
	// Move
	//GET WINDOW RECT($vL_left; $vL_top; $vL_right; $vL_bottom)
	//$vL_width:=$vL_right-$vL_left
	//$vL_height:=$vL_bottom-$vL_top
	$vL_width:=$vJ_form_prefs.l_width
	$vL_height:=$vJ_form_prefs.l_height
	SET WINDOW RECT:C444($vL_form_x; $vL_form_y; $vL_form_x+$vL_width; $vL_form_y+$vL_height)
	// *
	// *****
	
	// *****
	// *
	//Function math_curves($vR_input : Real; $vL_mode : Integer)->$vR_output : Real
	//Case of 
	//: ($vL_mode=0)  // Bypass
	//$vR_output:=$vR_input
	
	//: ($vL_mode=1)  // Trigo
	//$vR_output:=0.5-(Cos($vR_input*Pi)/2)
	
	//: ($vL_mode=2)  // easeInOutQuad
	//// f(t) = t<0.5 ? 2t² : 1 - 2*(1-t)²
	//$vR_output:=$vR_input<0.5 ? 2*($vR_input^2) : 1-(2*((1-$vR_input)^2))
	
	//: ($vL_mode=3)  // easeInOutCubic
	//// f(t) = t<0.5 ? 4t³ : 1 - 4*(1-t)³
	//$vR_output:=$vR_input<0.5 ? 4*($vR_input^3) : 1-(4*((1-$vR_input)^3))
	
	//: ($vL_mode=4)  // easeInOutBack
	//var $vR_s : Real
	////$vR_s:=1.70158
	//$vR_s:=1.1
	//$vR_input*=2
	//If ($vR_input<1)
	//return ($vR_input*$vR_input*(($vR_s+1)*$vR_input-$vR_s))/2
	//Else 
	//$vR_input-=2
	//return ($vR_input*$vR_input*(($vR_s+1)*$vR_input+$vR_s)+2)/2
	//End if 
	
	//: ($vL_mode=5)  // easeMacOS
	//// Exemple : cubic-bezier emulation of (0.25, 0.46, 0.45, 0.94) (style macOS)
	//$vR_output:=This.cubicBezier($vR_input; 0.25; 0.46; 0.45; 0.94)
	
	//Else 
	//$vR_output:=$vR_input
	//End case 
	
	
	//Function cubicBezier($vR_input : Real; $vR_x1 : Real; $vR_y1 : Real; $vR_x2 : Real; $vR_y2 : Real)->$vR_output : Real
	//// Formule Bézier cubique (simplifiée pour l'easing, on ignore x(t))
	//$vR_output:=3*(1-$vR_input)^2*$vR_input*$vR_y1+3*(1-$vR_input)*$vR_input^2*$vR_y2+$vR_input^3
	
	