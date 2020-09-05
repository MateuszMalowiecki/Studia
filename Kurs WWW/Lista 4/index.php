<?php
$arr=array();
class Pet {
	public $name;
	public $id;
	public $category;
	public $tag;
	public function __construct($name, $id, $category, $tags) {
        $this->$name = $name;
		$this->$id = $id;
		$this->$category = $category;
		$this->$tags=$tags;
    }
}
function addnewpet($id, $name, $category, $tags) {
	$pet=new Pet($name, $id, $category, $tags);
	$arr[$id]=$pet;
}
function getpetbyid($id) {
	return $arr[$id];
}
function getallobjects($id) {
	return array_values($arr);
}
function removeobjects($id) {
	if (isset(arr[$id])) {
		$unset(arr[$id]);
	}
}
?>
