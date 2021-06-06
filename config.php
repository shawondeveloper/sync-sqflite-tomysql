<?php
	$db = mysqli_connect("localhost","root","","syncsqftomysqldatabase");
	if (!$db) {
		echo "Database Connect Error ".mysqli_error($db);
	}
?>