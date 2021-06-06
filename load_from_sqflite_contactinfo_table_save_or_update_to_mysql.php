<?php
include 'config.php';

$user_id = $_POST['user_id'];
$contact_id = $_POST['contact_id'];
$name = $_POST['name'];
$email = $_POST['email'];
$gender = $_POST['gender'];
$created_at = $_POST['created_at'];

//contactinfoTable table


$selectExits = $db->query("SELECT * FROM contactinfotable WHERE user_id = '".$user_id."' AND contact_id = '".$contact_id."' ");

$count = mysqli_num_rows($selectExits);
if($count > 0){
	$result = $db->query("UPDATE contactinfotable SET name = '".$name."', email = '".$email."', gender = '".$gender."', created_at = '".$created_at."' WHERE contact_id = '".$contact_id."' AND user_id = '".$user_id."' ");
	if ($result) {
		echo json_encode(array("message"=>"UPDATE Success"));
	}else{
		echo json_encode(array("message"=>"UPDATE failed ".mysqli_errno($db)));
	}
}else{
	$result = $db->query(" INSERT INTO contactinfotable(contact_id,user_id,name,email,gender,created_at)VALUES('".$contact_id."','".$user_id."','".$name."','".$email."','".$gender."','".$created_at."') ");
	if ($result) {
		echo json_encode(array("message"=>"INSERT Success"));
	}else{
		echo json_encode(array("message"=>"INSERT failed ".mysqli_errno($db)));
	}
}
