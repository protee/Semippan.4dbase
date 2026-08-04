//%attributes = {"lang":"en"}

#DECLARE($cE_SETS : cs:C1710.SETSEntity; $cE_MEDIA : cs:C1710.MEDIAEntity; $vL_colors_in : Integer; $is_vertical : Boolean)->$vO_picture : Picture
var $is_btn; $is_visible; $is_grey_scale; $is_img_offset; $is_VH; $is_set_colors : Boolean
var $vC_at_dcox; $vC_al_colors : Collection
var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
var $idx; $vL_colors_out; $vL_brightness; $tt : Integer
var $vJ_picture; $vJ_dcox : Object
var $vO_pict; $vO_img_picture : Picture
var $vT_dcox : Text

// params
$is_VH:=Count parameters:C259>=4
$is_btn:=$cE_SETS.type>0
$is_vertical:=$is_VH ? $is_vertical : $cE_SETS.type=2
$is_set_colors:=$cE_SETS.j_options.isSetColors
$vJ_picture:=$cE_SETS.j_picture

// al_colors
$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
$vJ_dcox:=$cE_TEMPLATES.j_dcox
$vC_al_colors:=woc_dcox_al_colors_init($vJ_dcox; $is_btn; $vL_colors_in)
$vJ_dcox:=$cE_SETS.j_dcox
$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors)
If (Not:C34($is_set_colors))
	$cE_TEMPLATES:=$cE_MEDIA.MEDIA_TEMPLATES
	If ($cE_TEMPLATES#Null:C1517)
		$vJ_dcox:=$cE_TEMPLATES.j_dcox
		$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors)
	End if 
	$vJ_dcox:=$cE_MEDIA.j_dcox
	$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors)
End if 
$vO_img_picture:=$cE_MEDIA.isLinkedPicture ? $cE_MEDIA.MEDIA_PICTURES.picture : $cE_MEDIA.picture



// DCOX -> separated, or H | V, for LB or output
$tt:=$vC_al_colors.length
$vC_at_dcox:=woc_dcox_at_get()
$idx:=0
For each ($vT_dcox; $vC_at_dcox)
	$is_visible:=$idx<$tt
	If ($is_visible)
		$vL_colors_out:=$vC_al_colors[$idx]
		$vL_brightness:=$vJ_picture["l_br_"+$vT_dcox]
		$is_grey_scale:=($idx=3) && $vJ_picture.is_greyDisabled
		$is_img_offset:=($idx=1) && $vJ_picture.is_offsetClick
		$vO_pict:=sem_img_calculate($cE_SETS; $cE_MEDIA; $vO_img_picture; $vL_colors_out; $vL_brightness; $is_grey_scale; $is_img_offset)
		$vO_picture:=$idx=0 ? $vO_pict : ($is_vertical ? $vO_picture/$vO_pict : $vO_picture+$vO_pict)
	Else 
		break
	End if 
	$idx+=1
End for each 

