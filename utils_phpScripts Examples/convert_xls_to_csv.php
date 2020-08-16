<?php
    require_once dirname(__FILE__) . '/../vendor/autoload.php';
    require_once dirname(__FILE__) . '/../phpSpreadsheet/common_phpSpreadsheet.php';
    use PhpOffice\PhpSpreadsheet\Spreadsheet;

    $inputFileName = '{**InputFilePath**}';
	$outputFileName = '{**OutputFilePath**}';

	function array2csvFile ($outputFileName, $data, $delimiter = ',', $enclosure = '"', $escape_char = "\\") {
		$f = fopen ($outputFileName, 'w');
		foreach ($data as $item) {
			fputcsv ($f, $item, $delimiter, $enclosure, $escape_char);
		}
		fclose ($f);
	}

	function array2csvString ($data, $delimiter = ',', $enclosure = '"', $escape_char = "\\") {
		$f = fopen ('php://memory', 'r+');
		foreach ($data as $item) {
			fputcsv ($f, $item, $delimiter, $enclosure, $escape_char);
		}
		rewind ($f);
		return stream_get_contents ($f);
	}

	$spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load($inputFileName);
	$sheetData = $spreadsheet->getActiveSheet()->toArray();

	//file_put_contents ($outputFileName, array2csvString($sheetData));
	array2csvFile ($outputFileName, $sheetData)
?>
