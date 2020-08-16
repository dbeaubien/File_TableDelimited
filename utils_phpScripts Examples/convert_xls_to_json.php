<?php
    require_once dirname(__FILE__) . '/../vendor/autoload.php';
    require_once dirname(__FILE__) . '/../phpSpreadsheet/common_phpSpreadsheet.php';
    use PhpOffice\PhpSpreadsheet\Spreadsheet;

	$inputFileName = '{**InputFilePath**}';
	$outputFileName = '{**OutputFilePath**}';

	$spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load($inputFileName);
	$sheetData = $spreadsheet->getActiveSheet()->toArray();

	// echo "Convert xlsx to json\n";
	$data = [];

	// header
	$headers = $sheetData[0];
	unset ($sheetData[0]);

	// data
	$index = 1;
	foreach ($sheetData as $row) {
		// echo "Process row #$index\n";

		$item = [];
		foreach ($row as $key => $value) {
			$column = $headers[$key];
			$item[$column] = $value;
		}

		$data[] = $item;
		$index++;
	}

	// echo "Save to file\n";

	$json = json_encode ($data, JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
	file_put_contents ($outputFileName, $json);

	// echo "Job is done\n";
?>
