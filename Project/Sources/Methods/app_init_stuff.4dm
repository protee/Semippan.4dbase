//%attributes = {"lang":"en"}

var $vC_onOff_colors : Collection
var $vJ_stuff; $vJ_colors_square; $vJ_color_square; $vJ_colors_text; $vJ_preset : Object
$vJ_stuff:=New shared object:C1526
Use (Storage:C1525)
	Storage:C1525.j_stuff:=$vJ_stuff
End use 

Use ($vJ_stuff)
	
	// ***** Woc colors
	// *
	$vJ_colors_square:=New object:C1471
	$vJ_colors_square.space:=k_md_space
	$vJ_colors_square.is_sf:=True:C214
	$vJ_colors_square.shape:=-1  // Txt
	$vJ_stuff.j_colors_square:=OB Copy:C1225($vJ_colors_square; ck shared:K85:29)
	
	$vJ_color_square:=New object:C1471
	$vJ_color_square.space:=k_md_space
	$vJ_color_square.is_sf:=False:C215
	$vJ_color_square.shape:=-1  // square
	$vJ_stuff.j_color_square:=OB Copy:C1225($vJ_color_square; ck shared:K85:29)
	
	$vJ_colors_text:=New shared object:C1526
	$vJ_stuff.j_colors_text:=$vJ_colors_text
	$vJ_colors_text.l_space:=k_mdo_space
	$vJ_colors_text.is_sf:=True:C214
	$vJ_colors_text.l_shape:=-3  // square
	
	// ***** BANNERS
	// *
	$vC_onOff_colors:=New shared collection:C1527
	$vJ_stuff.al_onOff_colors:=$vC_onOff_colors
	$vC_onOff_colors.push(woc_sp_colors_inverse(woc_sp_colors_from_row(k_MDcolorsIdx_blueGrey; 2; 5)))
	$vC_onOff_colors.push(woc_sp_colors_from_sf(146; 146))
	
	
	// ***** Dial colors
	// *
	$vJ_preset:=zenh_io_colors_from_row(Null:C1517; k_MDcolorsIdx_red)
	$vJ_stuff.j_io_red:=OB Copy:C1225($vJ_preset; ck shared:K85:29; $vJ_stuff)
	
	$vJ_preset:=zenh_io_colors_from_row(Null:C1517; k_MDcolorsIdx_orange)
	$vJ_stuff.j_io_orange:=OB Copy:C1225($vJ_preset; ck shared:K85:29; $vJ_stuff)
	
	
	
End use 

