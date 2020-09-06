<?php
header( "Cache-Control: max-age=-1" );
header( "Content-Type: text/xml" );
$imiona=array("Ala", "Basia", "Gosia", "Kasia", "Lucyna", "Maria", "Natalia", "Tatiana", "Zosia");
$number=rand( 0, count($imiona)-1 );
echo "<imie>".$imiona[$number]."</imie>";
?>