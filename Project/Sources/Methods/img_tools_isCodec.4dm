//%attributes = {}

#DECLARE($vO_picture : Picture)->$isSvg : Boolean
var $vT_codec : Text

$vT_codec:=$vT_codec#"" ? $vT_codec : ".svg"

ARRAY TEXT:C222($aT_codecs; 0)
GET PICTURE FORMATS:C1406($vO_picture; $aT_codecs)
$isSvg:=(Find in array:C230($aT_codecs; $vT_codec)>0)

