
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vJ_meta_cell : Object
	var $vT_column : Text
	
	$vJ_meta:=New object:C1471
	
	//$vL_colors:=$c4E_entity.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	$vL_colors:=$c4E_entity.PICTURES_CATEGORIES.colors
	
	// For cells
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("PICTURES_CATEGORIES.label")
	This:C1470.meta_cell_colors($vJ_meta_cell; $vT_column; $vL_colors)
	
	
	//Function lb_active_img($cE_orwells : cs.ORWELLSEntity)->$vO_img : Picture  // Form.fc.lb_active_img(This)
	//$vO_img:=This.get_icon_img($cE_orwells.isActive)
	
	
	//Function lb_colors_img($cE_orwells : cs.ORWELLSEntity)->$vO_img : Picture
	//var $vL_colors; $vL_size; $vL_shape : Integer
	//$vL_colors:=$cE_orwells.colors
	//$vL_shape:=-3
	//$vL_size:=20
	//$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
Function lb_label($cE_PICTURES : cs:C1710.PICTURESEntity)->$vT_answer : Text
	var $vL_width; $vL_height : Integer
	var $txt; $vT_reso; $vT_separator2; $vT_line2; $vT_separator1 : Text
	PICTURE PROPERTIES:C457($cE_PICTURES.picture; $vL_width; $vL_height)
	$vT_answer:=" "+$cE_PICTURES.label+" "
	ST SET ATTRIBUTES:C1093($vT_answer; 1; 0; Attribute text size:K65:6; 12; Attribute bold style:K65:1; 1)
	$txt:=$cE_PICTURES.familly+", "+$cE_PICTURES.resolution
	ST SET ATTRIBUTES:C1093($txt; 1; 0; Attribute italic style:K65:2; 1)
	$vT_reso:=" w:"+String:C10($vL_width)+" h:"+String:C10($vL_height)+" "
	$vT_separator2:=" | "
	$vT_line2:=$vT_reso+$vT_separator2+$txt
	ST SET ATTRIBUTES:C1093($vT_line2; 1; 0; Attribute text size:K65:6; 8)
	ST SET ATTRIBUTES:C1093($vT_line2; 1; 0; Attribute text color:K65:7; color RGB coral)
	$vT_separator1:=Char:C90(Carriage return:K15:38)
	$vT_answer+=$vT_separator1+$vT_line2
	
	
Function lb_picture($cE_PICTURES : cs:C1710.PICTURESEntity)->$vO_answer : Picture
	$vO_answer:=img_with_bkg(65; 36; $cE_PICTURES.picture; $cE_PICTURES.imgColor)
	
	
Function lb_codec($cE_PICTURES : cs:C1710.PICTURESEntity)->$vO_answer : Picture
	var $c4Fi_pngSvg : 4D:C1709.File
	var $isSvg : Boolean
	$isSvg:=img_tools_isCodec($cE_PICTURES.picture)
	$c4Fi_pngSvg:=Folder:C1567(fk resources folder:K87:11).file("metier/icn_isSvg"+String:C10(Num:C11($isSvg))+k_png_ext)
	READ PICTURE FILE:C678($c4Fi_pngSvg.platformPath; $vO_answer)
	
	
	
Function lb_drag($cE_PICTURES : cs:C1710.PICTURESEntity)
	//var $vT_txt_img : Text
	//var $vX_buffer : Blob
	//$vT_txt_img:="img:"+String($cE_PICTURES.UID)+"/"+$cE_PICTURES.label
	//TEXT TO BLOB($vT_txt_img; $vX_buffer)
	
	//APPEND DATA TO PASTEBOARD(<>vT_urlTextNative; $vX_buffer)
	//SET TEXT TO PASTEBOARD(<>vT_urlOviyam_vT_img+":"+$vT_txt_img)
	//PICTURE TO BLOB($cE_PICTURES.picture; $vX_buffer; k_png_ext)
	//APPEND DATA TO PASTEBOARD("com.4d.private.picture.png"; $vX_buffer)
	
	//var $vO_imagette : Picture
	//$vO_imagette:=f_baq_calculImgWithBkg(50; 50; [PICTURES]picture; [PICTURES]imgColor)
	//SET DRAG ICON($vO_imagette)
	
	
	
Function lb_drop()
	////If ((Pasteboard data size("com.4d.private.picture.jfif")>0) | (Pasteboard data size("com.4d.private.picture.gif")>0))
	//var $vP_; $vP_srcObjet : Pointer
	//var $vL_srcElément; $vL_srcProcess : Integer
	//$vP_:=OBJECT Get pointer(Object named; "LB")
	//_O_DRAG AND DROP PROPERTIES($vP_srcObjet; $vL_srcElément; $vL_srcProcess)
	//If ($vP_srcObjet#$vP_)
	//var $vO_img : Picture
	//var $vT_pasteboard_img_seed; $vT_pasteboard_img_txt : Text
	//var $isOk : Boolean
	
	//// URL
	//$vT_pasteboard_img_seed:="public.url"
	//$isOk:=(Pasteboard data size($vT_pasteboard_img_seed)>0)
	//If ($isOk)
	//GET PASTEBOARD DATA($vT_pasteboard_img_seed; $vX_buffer)
	//$txt:=BLOB to text($vX_buffer; Mac C string)
	//var $vT_url : Text
	//$vT_url:="https://www.flaticon.com/free-icon/"
	//$isOk:=(Position($vT_url; $txt)=1)
	//If ($isOk) & False
	//$vL_id:=Num(Substring($txt; Length($vT_url)))
	//var $vT_api : Text
	//$vT_api:="/item/icon/"+String($vL_id)
	//var $vJ_flaticon : Object
	//$vJ_flaticon:=jog_flaticon_api2($vT_api)
	
	////
	
	//var $vJ_vJ : Object
	//$vJ_vJ:=$vJ_flaticon.data
	//var $vL_id : Integer
	//$vL_id:=$vJ_vJ.id
	//var $vT_img_url : Text
	////$img_url:=OB Get($ob.images.png;"512";Is text)
	//$vT_img_url:=OB Get($vJ_vJ.images; "svg"; Is text)
	
	//var $vJ_img : Object
	//$vJ_img:=New object
	//$vJ_img.size:=<>aL_fliSize{<>aL_fliSize+1}
	////$ob.format:="svg"
	//If (<>vL_fliColor#k_MDcolorTransparent)
	//$vJ_img.color:=woc_sp_color_to_html(<>vL_fliColor)
	//End if 
	//var $vO_img : Picture
	//$vO_img:=jog_flaticon_api_getImage_id($vL_id; $vJ_img)
	
	
	//// x_notif_isSvg($img;"LB_DRAG")
	////$ob:=New object
	////$ob.category:=$ob_line.category
	////$ob.family_name:=$ob_line.family_name
	////$ob.tags:=$ob_line.tags
	//var $vL_imgColor; $vL_imgStroke : Integer
	//jog_flaticon_colorStroke($vJ_vJ; <>vL_fliColor; ->$vL_imgColor; ->$vL_imgStroke)
	//$vJ_vJ.imgColor:=$vL_imgColor
	//$vJ_vJ.imgStroke:=$vL_imgStroke
	//$vJ_vJ.images:=$vT_img_url
	
	//End if 
	
	//// private picture from flaticon
	//Else 
	//$vT_pasteboard_img_seed:="com.4d.private.picture"
	//$vT_pasteboard_img_txt:=$vT_pasteboard_img_seed+".svg"
	//$isOk:=(Pasteboard data size($vT_pasteboard_img_txt)>0)
	//If (Not($isOk))
	//$vT_pasteboard_img_txt:=$vT_pasteboard_img_seed+<>png_ext
	//$isOk:=(Pasteboard data size($vT_pasteboard_img_txt)>0)
	//End if 
	//If ($isOk)
	////GET PICTURE FROM PASTEBOARD($img)
	//GET PASTEBOARD DATA($vT_pasteboard_img_txt; $vX_buffer)
	//BLOB TO PICTURE($vX_buffer; $vO_img)
	
	//var $txt; $vT_txt1 : Text
	//var $vL_imgStroke; $vL_imgColor : Integer
	//GET PASTEBOARD DATA(<>vT_urlOviyam_vJ_img; $vX_buffer)
	//var $vJ_vJ : Object
	//BLOB TO VARIABLE($vX_buffer; $vJ_vJ)
	////$txt:=BLOB to text($Blb_buffer; Mac C string)
	////If ($txt#"")
	//If (OK=1)
	////$vJ:=JSON Parse($txt)
	//$txt:=$vJ_vJ.tags
	//$vL_imgStroke:=$vJ_vJ.imgStroke
	//$vL_imgColor:=$vJ_vJ.imgColor
	//Else 
	//$vL_imgStroke:=0
	//$vL_imgColor:=0
	//End if 
	//End if 
	//End if 
	//If ($isOk)
	//$vT_txt1:=<>aT_imgColor_lbl{$vL_imgColor+1}+" / "+<>aT_imgStroke_lbl{$vL_imgStroke+1}
	//$txt:=wog_io_requestTxt($txt; "Tags"; $vT_txt1; "html/super_flake")
	//If ($txt#"")
	//y_record_new($vP_table)
	//[PICTURES]label:=$txt
	//[PICTURES]category:=$vJ_vJ.category
	//[PICTURES]family:=$vJ_vJ.family_name
	//[PICTURES]imgStroke:=$vL_imgStroke
	//[PICTURES]imgColor:=$vL_imgColor
	//[PICTURES]infos:=""
	//[PICTURES]resolution:=""
	//[PICTURES]path:=$vJ_vJ.images
	//var $vL_width; $vL_height : Integer
	//PICTURE PROPERTIES($vO_img; $vL_width; $vL_height)
	//[PICTURES]width:=$vL_width
	//[PICTURES]height:=$vL_height
	//[PICTURES]picture:=$vO_img
	//y_record_save($vP_table)
	//W_Navigation
	//W_sort
	//End if 
	//End if 
	//End if 