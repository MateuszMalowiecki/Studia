<?php
header( "Cache-Control: max-age=-1" );
echo $_GET["left"]+$_GET["right"];
?>