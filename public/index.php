<?php

if ($_GET['status'] === 404) {
	http_response_code(404);
	echo "404 Not Found";
	exit;
}

echo "Hello World!";