<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

function fourDigit($value = 0){
	return sprintf("%04s", $value);
}
function tenDigit($value = 0){
	return sprintf("%010s", $value);
}

function formatDate_helper($date){
	list($dd,$mm,$yyyy) = explode("-", $date);
	return $formatedDate = $yyyy."-".$mm."-".$dd;
}

function Terbilang($a) {
	$ambil = array(" ", "Satu", "Dua", "Tiga", "Empat", "Lima", "Enam", "Tujuh", "Delapan",
				   "Sembilan", "Sepuluh", "Sebelas");
	if ($a < 12)
		return " " . $ambil[$a];
	elseif ($a < 20)
		return Terbilang($a - 10) . " Belas";
	elseif ($a < 100)
		return Terbilang($a / 10) . " Puluh" . Terbilang($a % 10);
	elseif ($a < 200)
		return " seratus" . Terbilang($a - 100);
	elseif ($a < 1000)
		return Terbilang($a / 100) . " Ratus" . Terbilang($a % 100);
	elseif ($a < 2000)
		return " seribu" . Terbilang($a - 1000);
	elseif ($a < 1000000)
		return Terbilang($a / 1000) . " Ribu" . Terbilang($a % 1000);
	elseif ($a < 1000000000)
		return Terbilang($a / 1000000) . " Juta" . Terbilang($a % 1000000);
}

function splitIntoTwo_helper($param,$delimiter,$choice){
	list($a,$b) = explode($delimiter, $param);
	if($choice == 1){
		return $a;
	}else{
		return $b;
	}
}

function splitIntoThree_helper($param,$delimiter,$choice){

	list($a,$b,$c) = explode($delimiter, $param);
	if($choice == 1){
		return $a;
	}elseif($choice == 2){
		return $b;
	}else{
		return $c;
	}
}

function reverseFormatDate_helper($date){
	list($yyyy,$mm,$dd) = explode("-", $date);
	$bln_array 	= array( '00'=>'???','01' => "Jan", '02' => "Feb", '03' => "Mar", '04' => "Apr", '05' => "May", '06' => "Jun",
						 '07' => "Jul", '08' => "Aug", '09' => "Sep", '10' => "Oct", '11' => "Nov", '12' => "Dec" );
	$mm 		= $bln_array[$mm];
	return $formatedDate = $dd."-".$mm."-".$yyyy;
}

function reverseFormatDateIndo_helper($date){
	list($yyyy,$mm,$dd) = explode("-", $date);
	$bln_array 	= array( '00'=>'???','01' => "Januari", '02' => "Februari", '03' => "Maret", '04' => "April", '05' => "Mei", '06' => "Juni",
						 '07' => "Juli", '08' => "Augutus", '09' => "September", '10' => "Oktober", '11' => "November", '12' => "Desember" );
	$mm 		= $bln_array[$mm];
	return $formatedDate = $dd."-".$mm."-".$yyyy;
}

function hari_helpers($days){
	$bln_array 	= array( 'Monday'=>'Senin','Tuesday' => "Selasa", 'Wednesday' => "Rabu", 'Thursday' => "Kamis", 'Friday' => "Jumat", 'Saturday' => "Sabtu", 'Sunday' => "Minggu");
	$hari 		= $bln_array[$days];
	return $hari;
}

function completeFormatMonth_helper($month){
	$bln_array 	= array( '00'=>'???','01' => "January", '02' => "February", '03' => "March", '04' => "April", '05' => "May", '06' => "Juny",
						 '07' => "July", '08' => "August", '09' => "September", '10' => "October", '11' => "November", '12' => "December" );
	return $month 		= $bln_array[$month];
}

function completeFormatMonthIndo_helper($month){
	$bln_array 	= array( '00'=>'???','01' => "Januari", '02' => "Februari", '03' => "Maret", '04' => "April", '05' => "Mei", '06' => "Juni",
						 '07' => "Juli", '08' => "Agustus", '09' => "September", '10' => "Oktober", '11' => "November", '12' => "Desember" );
	return $month 		= $bln_array[$month];
}

function hariIndo_helper($day){
    $day_array  = array( 'Mon'=>'Senin','Tue' => "Selasa", 'Wed' => "Rabu", 'Thu' => "Kamis", 'Fri' => "Jum'at", 'Sat' => "Sabtu", 'Sun' => "Minggu");
    return $day       = $day_array[$day];
}

function reverseNormalFormatDate_helper($date){
	list($yyyy,$mm,$dd) = explode("-", $date);
	return $formatedDate = $dd."-".$mm."-".$yyyy;
}


function completeFormatDateIndo_helper($date,$delimeter){
	list($yyyy,$mm,$dd) = explode("-", $date);
	$mm 		= completeFormatMonthIndo_helper($mm);
	return $formatedDate = $dd.$delimeter.$mm.$delimeter.$yyyy;
}

function deleteComma($param){
	return $value = str_replace(",","", $param);
}

function echoLinkBack_helper(){
	return "<a class='btn btn-success' href='javascript:void(0)' onclick='back();'>back</a>";
}



?>