//%attributes = {}

#DECLARE($vO_picture : Picture)->$vT_answer : Text
var $vC_codecs : Collection

ARRAY TEXT:C222($aT_codecs; 0)
GET PICTURE FORMATS:C1406($vO_picture; $aT_codecs)

ARRAY TO COLLECTION:C1563($vC_codecs; $aT_codecs)
$vT_answer:=$vC_codecs.join(", ")

