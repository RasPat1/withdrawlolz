<?php

echo "Enter Summoner Name:";
$handle = fopen ("php://stdin", "r");
$line = fgets($handle);

// html encode summer names
$sName = htmlentities(trim($line));
$reqURL = "https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/";

include_once "authVars.php";
$apiKey = getenv('API_KEY');

// map query param names to values
$data = array("api_key" => $apiKey);

$urlParams = http_build_query($data);

$url = $reqURL . $sName . "?" . $urlParams;

$data = curl($url, $sName);


function curl($url, $fileName = "") {
	if (empty($fileName)) {
		$fileName = date('m-d-y_H:m:s');
	}
	// Remember when getting serious to try to use multi curl
	// http://www.phpied.com/simultaneuos-http-requests-in-php-with-curl/
	$ch = curl_init($url);

	// For now savbe thsi data into a file
	// Once caching later is implemented save this to Cache
	$fp = fopen($fileName . ".data", "w");
	
	curl_setopt($ch, CURLOPT_HEADER, 0);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

	$output = curl_exec($ch);
	curl_close($ch);

	fwrite($fp, $output);
	fclose($fp);

	return $output;
}