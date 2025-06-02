<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Home extends CI_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('M_Eticket');
		$this->load->model('rekapBulan/M_Juli');
		$this->load->model('rekapBulan/M_Aug');
		$this->load->model('rekapBulan/M_Sept');
		$this->load->model('rekapBulan/M_Oct');
		$this->load->model('rekapBulan/M_Nov');
		$this->load->model('rekapBulan/M_Des');
		$this->load->model('rekapBulan/M_Jan');
		$this->load->model('rekapBulan/M_Feb');
		$this->load->model('rekapBulan/M_Mar');
		$this->load->model('rekapBulan/M_Apr');
		$this->load->model('rekapBulan/M_Mei');
		$this->load->model('rekapBulan/M_Jun');
		$this->load->model('rekapHari/H_Jan');
		$this->load->library("pagination");
	}

	public function index()
	{
		// $this->load->helper('url');
		$this->load->view('auth/v_login_web');
	}

	public function masukAdmin()
	{
		$this->load->view('home');
	}

	public function halaman_transaksi()
	{
		$config = array();
		$config['base_url'] = site_url('home/halaman_transaksi');
		$config['total_rows'] = $this->db->count_all('transaksi');
		$config['per_page'] = 100;
		$config['uri_segment'] = 3;
		$choice = $config["total_rows"] / $config['per_page'];
		$config["num_links"] = floor($choice);
		$config['first_link'] = 'First';
		$config['last_link'] = 'Last';
		$config['next_link'] = 'Next';
		$config['prev_link'] = 'Prev';
		$config['full_tag_open'] = '<div class="pagging text-center"><nav><ul class="pagination justify-content-center">';
		$config['full_tag_close'] = '</ul></nav></div>';
		$config['num_tag_open'] = '<li class="page-item"><span class="page-link">';
		$config['num_tag_close'] = '</span></li>';
		$config['cur_tag_open'] = '<li class="page-item active"><span class="page-link">';
		$config['cur_tag_close'] = '</span></li>';
		$config['next_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['next_tagl_close'] = '<span aria-hidden= "true">&raquo</span></span></li>';
		$config['prev_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['prev_tagl_close'] = '</span>Next</li>';
		$config['first_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['first_tagl_close'] = '</span></li>';
		$config['last_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['last_tagl_close'] = '</span></li>';



		$this->pagination->initialize($config);
		$data['page'] = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;

		// $queryAllData = $this->M_Eticket->getDataTransaksi($config["per_page"], $DATA['page']);

		$data['pagination'] = $this->pagination->create_links();

		// $DATA = array('queryAllDts' => $queryAllData);
		// $data['sum_total'] = $this->M_Eticket->get_sum();
		// $DATA['tgl'] = $this->M_Eticket->getTgl();
		$data['data'] = $this->M_Eticket->getDataTransaksi($config["per_page"], $data['page']);
		$this->load->view('transaksi', $data);
	}


	public function halaman_rekap()
	{
		$data['sum_totalAllJul'] = $this->M_Eticket->get_sumJul();
		$data['sum_totalAllAug'] = $this->M_Eticket->get_sumAug();
		$data['sum_totalAllSept'] = $this->M_Eticket->get_sumSept();
		$data['sum_totalAllOct'] = $this->M_Eticket->get_sumOct();
		$data['sum_totalAllNov'] = $this->M_Eticket->get_sumNov();
		$data['sum_totalAllDes'] = $this->M_Eticket->get_sumDes();
		$data['sum_totalAllJan'] = $this->M_Eticket->get_sumJan();
		$data['sum_totalAllFeb'] = $this->M_Eticket->get_sumFeb();
		$data['sum_totalAllMar'] = $this->M_Eticket->get_sumMar();
		$data['sum_totalAllApr'] = $this->M_Eticket->get_sumApr();
		$data['sum_totalAllMei'] = $this->M_Eticket->get_sumMei();
		$data['sum_totalAllJun'] = $this->M_Eticket->get_sumJun();
		$this->load->view('rekapnya', $data);
	}

	public function detail_rekapJul()
	{
		$data['data'] = $this->M_Eticket->getJul();

		$data['sum_totalJul1'] = $this->M_Juli->get_sumJul1();
		$data['sum_totalJul2'] = $this->M_Juli->get_sumJul2();
		$data['sum_totalJul3'] = $this->M_Juli->get_sumJul3();
		$data['sum_totalJul4'] = $this->M_Juli->get_sumJul4();
		$data['sum_totalJul5'] = $this->M_Juli->get_sumJul5();
		$data['sum_totalJul6'] = $this->M_Juli->get_sumJul6();
		$data['sum_totalJul7'] = $this->M_Juli->get_sumJul7();
		$data['sum_totalJul8'] = $this->M_Juli->get_sumJul8();
		$data['sum_totalJul9'] = $this->M_Juli->get_sumJul9();
		$data['sum_totalJul10'] = $this->M_Juli->get_sumJul10();
		$data['sum_totalJul11'] = $this->M_Juli->get_sumJul11();
		$data['sum_totalJul12'] = $this->M_Juli->get_sumJul12();
		$data['sum_totalJul13'] = $this->M_Juli->get_sumJul13();
		$data['sum_totalJul14'] = $this->M_Juli->get_sumJul14();
		$data['sum_totalJul15'] = $this->M_Juli->get_sumJul15();
		$data['sum_totalJul16'] = $this->M_Juli->get_sumJul16();
		$data['sum_totalJul17'] = $this->M_Juli->get_sumJul17();
		$data['sum_totalJul18'] = $this->M_Juli->get_sumJul18();
		$data['sum_totalJul19'] = $this->M_Juli->get_sumJul19();
		$data['sum_totalJul20'] = $this->M_Juli->get_sumJul20();
		$data['sum_totalJul21'] = $this->M_Juli->get_sumJul21();
		$data['sum_totalJul22'] = $this->M_Juli->get_sumJul22();
		$data['sum_totalJul23'] = $this->M_Juli->get_sumJul23();
		$data['sum_totalJul24'] = $this->M_Juli->get_sumJul24();
		$data['sum_totalJul25'] = $this->M_Juli->get_sumJul25();
		$data['sum_totalJul26'] = $this->M_Juli->get_sumJul26();
		$data['sum_totalJul27'] = $this->M_Juli->get_sumJul27();
		$data['sum_totalJul28'] = $this->M_Juli->get_sumJul28();
		$data['sum_totalJul29'] = $this->M_Juli->get_sumJul29();
		$data['sum_totalJul30'] = $this->M_Juli->get_sumJul30();
		$data['sum_totalJul31'] = $this->M_Juli->get_sumJul31();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTJul1'] = $this->M_Juli->get_sum_mejaJul1();
		$data['sum_mejaTJul2'] = $this->M_Juli->get_sum_mejaJul2();
		$data['sum_mejaTJul3'] = $this->M_Juli->get_sum_mejaJul3();
		$data['sum_mejaTJul4'] = $this->M_Juli->get_sum_mejaJul4();
		$data['sum_mejaTJul5'] = $this->M_Juli->get_sum_mejaJul5();
		$data['sum_mejaTJul6'] = $this->M_Juli->get_sum_mejaJul6();
		$data['sum_mejaTJul7'] = $this->M_Juli->get_sum_mejaJul7();
		$data['sum_mejaTJul8'] = $this->M_Juli->get_sum_mejaJul8();
		$data['sum_mejaTJul9'] = $this->M_Juli->get_sum_mejaJul9();
		$data['sum_mejaTJul10'] = $this->M_Juli->get_sum_mejaJul10();
		$data['sum_mejaTJul11'] = $this->M_Juli->get_sum_mejaJul11();
		$data['sum_mejaTJul12'] = $this->M_Juli->get_sum_mejaJul12();
		$data['sum_mejaTJul13'] = $this->M_Juli->get_sum_mejaJul13();
		$data['sum_mejaTJul14'] = $this->M_Juli->get_sum_mejaJul14();
		$data['sum_mejaTJul15'] = $this->M_Juli->get_sum_mejaJul15();
		$data['sum_mejaTJul16'] = $this->M_Juli->get_sum_mejaJul16();
		$data['sum_mejaTJul17'] = $this->M_Juli->get_sum_mejaJul17();
		$data['sum_mejaTJul18'] = $this->M_Juli->get_sum_mejaJul18();
		$data['sum_mejaTJul19'] = $this->M_Juli->get_sum_mejaJul19();
		$data['sum_mejaTJul20'] = $this->M_Juli->get_sum_mejaJul20();
		$data['sum_mejaTJul21'] = $this->M_Juli->get_sum_mejaJul21();
		$data['sum_mejaTJul22'] = $this->M_Juli->get_sum_mejaJul22();
		$data['sum_mejaTJul23'] = $this->M_Juli->get_sum_mejaJul23();
		$data['sum_mejaTJul24'] = $this->M_Juli->get_sum_mejaJul24();
		$data['sum_mejaTJul25'] = $this->M_Juli->get_sum_mejaJul25();
		$data['sum_mejaTJul26'] = $this->M_Juli->get_sum_mejaJul26();
		$data['sum_mejaTJul27'] = $this->M_Juli->get_sum_mejaJul27();
		$data['sum_mejaTJul28'] = $this->M_Juli->get_sum_mejaJul28();
		$data['sum_mejaTJul29'] = $this->M_Juli->get_sum_mejaJul29();
		$data['sum_mejaTJul30'] = $this->M_Juli->get_sum_mejaJul30();
		$data['sum_mejaTJul31'] = $this->M_Juli->get_sum_mejaJul31();

		$data['sum_totalAllJul'] = $this->M_Eticket->get_sumJul();
		$data['sum_totalAllMejaJul'] = $this->M_Eticket->get_summejaJul();

		$this->load->view('detail_bulan/detail_jul', $data);
	}

	public function detail_rekapAug()
	{
		$data['data'] = $this->M_Eticket->getAug();

		$data['sum_totalAug1'] = $this->M_Aug->get_sumAug1();
		$data['sum_totalAug2'] = $this->M_Aug->get_sumAug2();
		$data['sum_totalAug3'] = $this->M_Aug->get_sumAug3();
		$data['sum_totalAug4'] = $this->M_Aug->get_sumAug4();
		$data['sum_totalAug5'] = $this->M_Aug->get_sumAug5();
		$data['sum_totalAug6'] = $this->M_Aug->get_sumAug6();
		$data['sum_totalAug7'] = $this->M_Aug->get_sumAug7();
		$data['sum_totalAug8'] = $this->M_Aug->get_sumAug8();
		$data['sum_totalAug9'] = $this->M_Aug->get_sumAug9();
		$data['sum_totalAug10'] = $this->M_Aug->get_sumAug10();
		$data['sum_totalAug11'] = $this->M_Aug->get_sumAug11();
		$data['sum_totalAug12'] = $this->M_Aug->get_sumAug12();
		$data['sum_totalAug13'] = $this->M_Aug->get_sumAug13();
		$data['sum_totalAug14'] = $this->M_Aug->get_sumAug14();
		$data['sum_totalAug15'] = $this->M_Aug->get_sumAug15();
		$data['sum_totalAug16'] = $this->M_Aug->get_sumAug16();
		$data['sum_totalAug17'] = $this->M_Aug->get_sumAug17();
		$data['sum_totalAug18'] = $this->M_Aug->get_sumAug18();
		$data['sum_totalAug19'] = $this->M_Aug->get_sumAug19();
		$data['sum_totalAug20'] = $this->M_Aug->get_sumAug20();
		$data['sum_totalAug21'] = $this->M_Aug->get_sumAug21();
		$data['sum_totalAug22'] = $this->M_Aug->get_sumAug22();
		$data['sum_totalAug23'] = $this->M_Aug->get_sumAug23();
		$data['sum_totalAug24'] = $this->M_Aug->get_sumAug24();
		$data['sum_totalAug25'] = $this->M_Aug->get_sumAug25();
		$data['sum_totalAug26'] = $this->M_Aug->get_sumAug26();
		$data['sum_totalAug27'] = $this->M_Aug->get_sumAug27();
		$data['sum_totalAug28'] = $this->M_Aug->get_sumAug28();
		$data['sum_totalAug29'] = $this->M_Aug->get_sumAug29();
		$data['sum_totalAug30'] = $this->M_Aug->get_sumAug30();
		$data['sum_totalAug31'] = $this->M_Aug->get_sumAug31();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTAug1'] = $this->M_Aug->get_sum_mejaAug1();
		$data['sum_mejaTAug2'] = $this->M_Aug->get_sum_mejaAug2();
		$data['sum_mejaTAug3'] = $this->M_Aug->get_sum_mejaAug3();
		$data['sum_mejaTAug4'] = $this->M_Aug->get_sum_mejaAug4();
		$data['sum_mejaTAug5'] = $this->M_Aug->get_sum_mejaAug5();
		$data['sum_mejaTAug6'] = $this->M_Aug->get_sum_mejaAug6();
		$data['sum_mejaTAug7'] = $this->M_Aug->get_sum_mejaAug7();
		$data['sum_mejaTAug8'] = $this->M_Aug->get_sum_mejaAug8();
		$data['sum_mejaTAug9'] = $this->M_Aug->get_sum_mejaAug9();
		$data['sum_mejaTAug10'] = $this->M_Aug->get_sum_mejaAug10();
		$data['sum_mejaTAug11'] = $this->M_Aug->get_sum_mejaAug11();
		$data['sum_mejaTAug12'] = $this->M_Aug->get_sum_mejaAug12();
		$data['sum_mejaTAug13'] = $this->M_Aug->get_sum_mejaAug13();
		$data['sum_mejaTAug14'] = $this->M_Aug->get_sum_mejaAug14();
		$data['sum_mejaTAug15'] = $this->M_Aug->get_sum_mejaAug15();
		$data['sum_mejaTAug16'] = $this->M_Aug->get_sum_mejaAug16();
		$data['sum_mejaTAug17'] = $this->M_Aug->get_sum_mejaAug17();
		$data['sum_mejaTAug18'] = $this->M_Aug->get_sum_mejaAug18();
		$data['sum_mejaTAug19'] = $this->M_Aug->get_sum_mejaAug19();
		$data['sum_mejaTAug20'] = $this->M_Aug->get_sum_mejaAug20();
		$data['sum_mejaTAug21'] = $this->M_Aug->get_sum_mejaAug21();
		$data['sum_mejaTAug22'] = $this->M_Aug->get_sum_mejaAug22();
		$data['sum_mejaTAug23'] = $this->M_Aug->get_sum_mejaAug23();
		$data['sum_mejaTAug24'] = $this->M_Aug->get_sum_mejaAug24();
		$data['sum_mejaTAug25'] = $this->M_Aug->get_sum_mejaAug25();
		$data['sum_mejaTAug26'] = $this->M_Aug->get_sum_mejaAug26();
		$data['sum_mejaTAug27'] = $this->M_Aug->get_sum_mejaAug27();
		$data['sum_mejaTAug28'] = $this->M_Aug->get_sum_mejaAug28();
		$data['sum_mejaTAug29'] = $this->M_Aug->get_sum_mejaAug29();
		$data['sum_mejaTAug30'] = $this->M_Aug->get_sum_mejaAug30();
		$data['sum_mejaTAug31'] = $this->M_Aug->get_sum_mejaAug31();

		$data['sum_totalAllAug'] = $this->M_Eticket->get_sumAug();
		$data['sum_totalAllMejaAug'] = $this->M_Eticket->get_summejaAug();

		$this->load->view('detail_bulan/detail_aug', $data);
	}

	public function detail_rekapSept()
	{
		$data['data'] = $this->M_Eticket->getSept();

		$data['sum_totalSept1'] = $this->M_Sept->get_sumSept1();
		$data['sum_totalSept2'] = $this->M_Sept->get_sumSept2();
		$data['sum_totalSept3'] = $this->M_Sept->get_sumSept3();
		$data['sum_totalSept4'] = $this->M_Sept->get_sumSept4();
		$data['sum_totalSept5'] = $this->M_Sept->get_sumSept5();
		$data['sum_totalSept6'] = $this->M_Sept->get_sumSept6();
		$data['sum_totalSept7'] = $this->M_Sept->get_sumSept7();
		$data['sum_totalSept8'] = $this->M_Sept->get_sumSept8();
		$data['sum_totalSept9'] = $this->M_Sept->get_sumSept9();
		$data['sum_totalSept10'] = $this->M_Sept->get_sumSept10();
		$data['sum_totalSept11'] = $this->M_Sept->get_sumSept11();
		$data['sum_totalSept12'] = $this->M_Sept->get_sumSept12();
		$data['sum_totalSept13'] = $this->M_Sept->get_sumSept13();
		$data['sum_totalSept14'] = $this->M_Sept->get_sumSept14();
		$data['sum_totalSept15'] = $this->M_Sept->get_sumSept15();
		$data['sum_totalSept16'] = $this->M_Sept->get_sumSept16();
		$data['sum_totalSept17'] = $this->M_Sept->get_sumSept17();
		$data['sum_totalSept18'] = $this->M_Sept->get_sumSept18();
		$data['sum_totalSept19'] = $this->M_Sept->get_sumSept19();
		$data['sum_totalSept20'] = $this->M_Sept->get_sumSept20();
		$data['sum_totalSept21'] = $this->M_Sept->get_sumSept21();
		$data['sum_totalSept22'] = $this->M_Sept->get_sumSept22();
		$data['sum_totalSept23'] = $this->M_Sept->get_sumSept23();
		$data['sum_totalSept24'] = $this->M_Sept->get_sumSept24();
		$data['sum_totalSept25'] = $this->M_Sept->get_sumSept25();
		$data['sum_totalSept26'] = $this->M_Sept->get_sumSept26();
		$data['sum_totalSept27'] = $this->M_Sept->get_sumSept27();
		$data['sum_totalSept28'] = $this->M_Sept->get_sumSept28();
		$data['sum_totalSept29'] = $this->M_Sept->get_sumSept29();
		$data['sum_totalSept30'] = $this->M_Sept->get_sumSept30();


		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTSept1'] = $this->M_Sept->get_sum_mejaSept1();
		$data['sum_mejaTSept2'] = $this->M_Sept->get_sum_mejaSept2();
		$data['sum_mejaTSept3'] = $this->M_Sept->get_sum_mejaSept3();
		$data['sum_mejaTSept4'] = $this->M_Sept->get_sum_mejaSept4();
		$data['sum_mejaTSept5'] = $this->M_Sept->get_sum_mejaSept5();
		$data['sum_mejaTSept6'] = $this->M_Sept->get_sum_mejaSept6();
		$data['sum_mejaTSept7'] = $this->M_Sept->get_sum_mejaSept7();
		$data['sum_mejaTSept8'] = $this->M_Sept->get_sum_mejaSept8();
		$data['sum_mejaTSept9'] = $this->M_Sept->get_sum_mejaSept9();
		$data['sum_mejaTSept10'] = $this->M_Sept->get_sum_mejaSept10();
		$data['sum_mejaTSept11'] = $this->M_Sept->get_sum_mejaSept11();
		$data['sum_mejaTSept12'] = $this->M_Sept->get_sum_mejaSept12();
		$data['sum_mejaTSept13'] = $this->M_Sept->get_sum_mejaSept13();
		$data['sum_mejaTSept14'] = $this->M_Sept->get_sum_mejaSept14();
		$data['sum_mejaTSept15'] = $this->M_Sept->get_sum_mejaSept15();
		$data['sum_mejaTSept16'] = $this->M_Sept->get_sum_mejaSept16();
		$data['sum_mejaTSept17'] = $this->M_Sept->get_sum_mejaSept17();
		$data['sum_mejaTSept18'] = $this->M_Sept->get_sum_mejaSept18();
		$data['sum_mejaTSept19'] = $this->M_Sept->get_sum_mejaSept19();
		$data['sum_mejaTSept20'] = $this->M_Sept->get_sum_mejaSept20();
		$data['sum_mejaTSept21'] = $this->M_Sept->get_sum_mejaSept21();
		$data['sum_mejaTSept22'] = $this->M_Sept->get_sum_mejaSept22();
		$data['sum_mejaTSept23'] = $this->M_Sept->get_sum_mejaSept23();
		$data['sum_mejaTSept24'] = $this->M_Sept->get_sum_mejaSept24();
		$data['sum_mejaTSept25'] = $this->M_Sept->get_sum_mejaSept25();
		$data['sum_mejaTSept26'] = $this->M_Sept->get_sum_mejaSept26();
		$data['sum_mejaTSept27'] = $this->M_Sept->get_sum_mejaSept27();
		$data['sum_mejaTSept28'] = $this->M_Sept->get_sum_mejaSept28();
		$data['sum_mejaTSept29'] = $this->M_Sept->get_sum_mejaSept29();
		$data['sum_mejaTSept30'] = $this->M_Sept->get_sum_mejaSept30();

		$data['sum_totalAllSept'] = $this->M_Eticket->get_sumSept();
		$data['sum_totalAllMejaSept'] = $this->M_Eticket->get_summejaSept();

		$this->load->view('detail_bulan/detail_sept', $data);
	}

	public function detail_rekapOct()
	{
		$data['data'] = $this->M_Eticket->getOct();

		$data['sum_totalOct1'] = $this->M_Oct->get_sumOct1();
		$data['sum_totalOct2'] = $this->M_Oct->get_sumOct2();
		$data['sum_totalOct3'] = $this->M_Oct->get_sumOct3();
		$data['sum_totalOct4'] = $this->M_Oct->get_sumOct4();
		$data['sum_totalOct5'] = $this->M_Oct->get_sumOct5();
		$data['sum_totalOct6'] = $this->M_Oct->get_sumOct6();
		$data['sum_totalOct7'] = $this->M_Oct->get_sumOct7();
		$data['sum_totalOct8'] = $this->M_Oct->get_sumOct8();
		$data['sum_totalOct9'] = $this->M_Oct->get_sumOct9();
		$data['sum_totalOct10'] = $this->M_Oct->get_sumOct10();
		$data['sum_totalOct11'] = $this->M_Oct->get_sumOct11();
		$data['sum_totalOct12'] = $this->M_Oct->get_sumOct12();
		$data['sum_totalOct13'] = $this->M_Oct->get_sumOct13();
		$data['sum_totalOct14'] = $this->M_Oct->get_sumOct14();
		$data['sum_totalOct15'] = $this->M_Oct->get_sumOct15();
		$data['sum_totalOct16'] = $this->M_Oct->get_sumOct16();
		$data['sum_totalOct17'] = $this->M_Oct->get_sumOct17();
		$data['sum_totalOct18'] = $this->M_Oct->get_sumOct18();
		$data['sum_totalOct19'] = $this->M_Oct->get_sumOct19();
		$data['sum_totalOct20'] = $this->M_Oct->get_sumOct20();
		$data['sum_totalOct21'] = $this->M_Oct->get_sumOct21();
		$data['sum_totalOct22'] = $this->M_Oct->get_sumOct22();
		$data['sum_totalOct23'] = $this->M_Oct->get_sumOct23();
		$data['sum_totalOct24'] = $this->M_Oct->get_sumOct24();
		$data['sum_totalOct25'] = $this->M_Oct->get_sumOct25();
		$data['sum_totalOct26'] = $this->M_Oct->get_sumOct26();
		$data['sum_totalOct27'] = $this->M_Oct->get_sumOct27();
		$data['sum_totalOct28'] = $this->M_Oct->get_sumOct28();
		$data['sum_totalOct29'] = $this->M_Oct->get_sumOct29();
		$data['sum_totalOct30'] = $this->M_Oct->get_sumOct30();
		$data['sum_totalOct31'] = $this->M_Oct->get_sumOct31();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTOct1'] = $this->M_Oct->get_sum_mejaOct1();
		$data['sum_mejaTOct2'] = $this->M_Oct->get_sum_mejaOct2();
		$data['sum_mejaTOct3'] = $this->M_Oct->get_sum_mejaOct3();
		$data['sum_mejaTOct4'] = $this->M_Oct->get_sum_mejaOct4();
		$data['sum_mejaTOct5'] = $this->M_Oct->get_sum_mejaOct5();
		$data['sum_mejaTOct6'] = $this->M_Oct->get_sum_mejaOct6();
		$data['sum_mejaTOct7'] = $this->M_Oct->get_sum_mejaOct7();
		$data['sum_mejaTOct8'] = $this->M_Oct->get_sum_mejaOct8();
		$data['sum_mejaTOct9'] = $this->M_Oct->get_sum_mejaOct9();
		$data['sum_mejaTOct10'] = $this->M_Oct->get_sum_mejaOct10();
		$data['sum_mejaTOct11'] = $this->M_Oct->get_sum_mejaOct11();
		$data['sum_mejaTOct12'] = $this->M_Oct->get_sum_mejaOct12();
		$data['sum_mejaTOct13'] = $this->M_Oct->get_sum_mejaOct13();
		$data['sum_mejaTOct14'] = $this->M_Oct->get_sum_mejaOct14();
		$data['sum_mejaTOct15'] = $this->M_Oct->get_sum_mejaOct15();
		$data['sum_mejaTOct16'] = $this->M_Oct->get_sum_mejaOct16();
		$data['sum_mejaTOct17'] = $this->M_Oct->get_sum_mejaOct17();
		$data['sum_mejaTOct18'] = $this->M_Oct->get_sum_mejaOct18();
		$data['sum_mejaTOct19'] = $this->M_Oct->get_sum_mejaOct19();
		$data['sum_mejaTOct20'] = $this->M_Oct->get_sum_mejaOct20();
		$data['sum_mejaTOct21'] = $this->M_Oct->get_sum_mejaOct21();
		$data['sum_mejaTOct22'] = $this->M_Oct->get_sum_mejaOct22();
		$data['sum_mejaTOct23'] = $this->M_Oct->get_sum_mejaOct23();
		$data['sum_mejaTOct24'] = $this->M_Oct->get_sum_mejaOct24();
		$data['sum_mejaTOct25'] = $this->M_Oct->get_sum_mejaOct25();
		$data['sum_mejaTOct26'] = $this->M_Oct->get_sum_mejaOct26();
		$data['sum_mejaTOct27'] = $this->M_Oct->get_sum_mejaOct27();
		$data['sum_mejaTOct28'] = $this->M_Oct->get_sum_mejaOct28();
		$data['sum_mejaTOct29'] = $this->M_Oct->get_sum_mejaOct29();
		$data['sum_mejaTOct30'] = $this->M_Oct->get_sum_mejaOct30();
		$data['sum_mejaTOct31'] = $this->M_Oct->get_sum_mejaOct31();

		$data['sum_totalAllOct'] = $this->M_Eticket->get_sumOct();
		$data['sum_totalAllMejaOct'] = $this->M_Eticket->get_summejaOct();

		$this->load->view('detail_bulan/detail_oct', $data);
	}

	public function detail_rekapNov()
	{
		$data['data'] = $this->M_Eticket->getNov();

		$data['sum_totalNov1'] = $this->M_Nov->get_sumNov1();
		$data['sum_totalNov2'] = $this->M_Nov->get_sumNov2();
		$data['sum_totalNov3'] = $this->M_Nov->get_sumNov3();
		$data['sum_totalNov4'] = $this->M_Nov->get_sumNov4();
		$data['sum_totalNov5'] = $this->M_Nov->get_sumNov5();
		$data['sum_totalNov6'] = $this->M_Nov->get_sumNov6();
		$data['sum_totalNov7'] = $this->M_Nov->get_sumNov7();
		$data['sum_totalNov8'] = $this->M_Nov->get_sumNov8();
		$data['sum_totalNov9'] = $this->M_Nov->get_sumNov9();
		$data['sum_totalNov10'] = $this->M_Nov->get_sumNov10();
		$data['sum_totalNov11'] = $this->M_Nov->get_sumNov11();
		$data['sum_totalNov12'] = $this->M_Nov->get_sumNov12();
		$data['sum_totalNov13'] = $this->M_Nov->get_sumNov13();
		$data['sum_totalNov14'] = $this->M_Nov->get_sumNov14();
		$data['sum_totalNov15'] = $this->M_Nov->get_sumNov15();
		$data['sum_totalNov16'] = $this->M_Nov->get_sumNov16();
		$data['sum_totalNov17'] = $this->M_Nov->get_sumNov17();
		$data['sum_totalNov18'] = $this->M_Nov->get_sumNov18();
		$data['sum_totalNov19'] = $this->M_Nov->get_sumNov19();
		$data['sum_totalNov20'] = $this->M_Nov->get_sumNov20();
		$data['sum_totalNov21'] = $this->M_Nov->get_sumNov21();
		$data['sum_totalNov22'] = $this->M_Nov->get_sumNov22();
		$data['sum_totalNov23'] = $this->M_Nov->get_sumNov23();
		$data['sum_totalNov24'] = $this->M_Nov->get_sumNov24();
		$data['sum_totalNov25'] = $this->M_Nov->get_sumNov25();
		$data['sum_totalNov26'] = $this->M_Nov->get_sumNov26();
		$data['sum_totalNov27'] = $this->M_Nov->get_sumNov27();
		$data['sum_totalNov28'] = $this->M_Nov->get_sumNov28();
		$data['sum_totalNov29'] = $this->M_Nov->get_sumNov29();
		$data['sum_totalNov30'] = $this->M_Nov->get_sumNov30();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTNov1'] = $this->M_Nov->get_sum_mejaNov1();
		$data['sum_mejaTNov2'] = $this->M_Nov->get_sum_mejaNov2();
		$data['sum_mejaTNov3'] = $this->M_Nov->get_sum_mejaNov3();
		$data['sum_mejaTNov4'] = $this->M_Nov->get_sum_mejaNov4();
		$data['sum_mejaTNov5'] = $this->M_Nov->get_sum_mejaNov5();
		$data['sum_mejaTNov6'] = $this->M_Nov->get_sum_mejaNov6();
		$data['sum_mejaTNov7'] = $this->M_Nov->get_sum_mejaNov7();
		$data['sum_mejaTNov8'] = $this->M_Nov->get_sum_mejaNov8();
		$data['sum_mejaTNov9'] = $this->M_Nov->get_sum_mejaNov9();
		$data['sum_mejaTNov10'] = $this->M_Nov->get_sum_mejaNov10();
		$data['sum_mejaTNov11'] = $this->M_Nov->get_sum_mejaNov11();
		$data['sum_mejaTNov12'] = $this->M_Nov->get_sum_mejaNov12();
		$data['sum_mejaTNov13'] = $this->M_Nov->get_sum_mejaNov13();
		$data['sum_mejaTNov14'] = $this->M_Nov->get_sum_mejaNov14();
		$data['sum_mejaTNov15'] = $this->M_Nov->get_sum_mejaNov15();
		$data['sum_mejaTNov16'] = $this->M_Nov->get_sum_mejaNov16();
		$data['sum_mejaTNov17'] = $this->M_Nov->get_sum_mejaNov17();
		$data['sum_mejaTNov18'] = $this->M_Nov->get_sum_mejaNov18();
		$data['sum_mejaTNov19'] = $this->M_Nov->get_sum_mejaNov19();
		$data['sum_mejaTNov20'] = $this->M_Nov->get_sum_mejaNov20();
		$data['sum_mejaTNov21'] = $this->M_Nov->get_sum_mejaNov21();
		$data['sum_mejaTNov22'] = $this->M_Nov->get_sum_mejaNov22();
		$data['sum_mejaTNov23'] = $this->M_Nov->get_sum_mejaNov23();
		$data['sum_mejaTNov24'] = $this->M_Nov->get_sum_mejaNov24();
		$data['sum_mejaTNov25'] = $this->M_Nov->get_sum_mejaNov25();
		$data['sum_mejaTNov26'] = $this->M_Nov->get_sum_mejaNov26();
		$data['sum_mejaTNov27'] = $this->M_Nov->get_sum_mejaNov27();
		$data['sum_mejaTNov28'] = $this->M_Nov->get_sum_mejaNov28();
		$data['sum_mejaTNov29'] = $this->M_Nov->get_sum_mejaNov29();
		$data['sum_mejaTNov30'] = $this->M_Nov->get_sum_mejaNov30();

		$data['sum_totalAllNov'] = $this->M_Eticket->get_sumNov();
		$data['sum_totalAllMejaNov'] = $this->M_Eticket->get_summejaNov();

		$this->load->view('detail_bulan/detail_nov', $data);
	}
	public function detail_rekapDes()
	{
		$data['data'] = $this->M_Eticket->getDes();

		$data['sum_totalDes1'] = $this->M_Des->get_sumDes1();
		$data['sum_totalDes2'] = $this->M_Des->get_sumDes2();
		$data['sum_totalDes3'] = $this->M_Des->get_sumDes3();
		$data['sum_totalDes4'] = $this->M_Des->get_sumDes4();
		$data['sum_totalDes5'] = $this->M_Des->get_sumDes5();
		$data['sum_totalDes6'] = $this->M_Des->get_sumDes6();
		$data['sum_totalDes7'] = $this->M_Des->get_sumDes7();
		$data['sum_totalDes8'] = $this->M_Des->get_sumDes8();
		$data['sum_totalDes9'] = $this->M_Des->get_sumDes9();
		$data['sum_totalDes10'] = $this->M_Des->get_sumDes10();
		$data['sum_totalDes11'] = $this->M_Des->get_sumDes11();
		$data['sum_totalDes12'] = $this->M_Des->get_sumDes12();
		$data['sum_totalDes13'] = $this->M_Des->get_sumDes13();
		$data['sum_totalDes14'] = $this->M_Des->get_sumDes14();
		$data['sum_totalDes15'] = $this->M_Des->get_sumDes15();
		$data['sum_totalDes16'] = $this->M_Des->get_sumDes16();
		$data['sum_totalDes17'] = $this->M_Des->get_sumDes17();
		$data['sum_totalDes18'] = $this->M_Des->get_sumDes18();
		$data['sum_totalDes19'] = $this->M_Des->get_sumDes19();
		$data['sum_totalDes20'] = $this->M_Des->get_sumDes20();
		$data['sum_totalDes21'] = $this->M_Des->get_sumDes21();
		$data['sum_totalDes22'] = $this->M_Des->get_sumDes22();
		$data['sum_totalDes23'] = $this->M_Des->get_sumDes23();
		$data['sum_totalDes24'] = $this->M_Des->get_sumDes24();
		$data['sum_totalDes25'] = $this->M_Des->get_sumDes25();
		$data['sum_totalDes26'] = $this->M_Des->get_sumDes26();
		$data['sum_totalDes27'] = $this->M_Des->get_sumDes27();
		$data['sum_totalDes28'] = $this->M_Des->get_sumDes28();
		$data['sum_totalDes29'] = $this->M_Des->get_sumDes29();
		$data['sum_totalDes30'] = $this->M_Des->get_sumDes30();
		$data['sum_totalDes31'] = $this->M_Des->get_sumDes31();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTDes1'] = $this->M_Des->get_sum_mejaDes1();
		$data['sum_mejaTDes2'] = $this->M_Des->get_sum_mejaDes2();
		$data['sum_mejaTDes3'] = $this->M_Des->get_sum_mejaDes3();
		$data['sum_mejaTDes4'] = $this->M_Des->get_sum_mejaDes4();
		$data['sum_mejaTDes5'] = $this->M_Des->get_sum_mejaDes5();
		$data['sum_mejaTDes6'] = $this->M_Des->get_sum_mejaDes6();
		$data['sum_mejaTDes7'] = $this->M_Des->get_sum_mejaDes7();
		$data['sum_mejaTDes8'] = $this->M_Des->get_sum_mejaDes8();
		$data['sum_mejaTDes9'] = $this->M_Des->get_sum_mejaDes9();
		$data['sum_mejaTDes10'] = $this->M_Des->get_sum_mejaDes10();
		$data['sum_mejaTDes11'] = $this->M_Des->get_sum_mejaDes11();
		$data['sum_mejaTDes12'] = $this->M_Des->get_sum_mejaDes12();
		$data['sum_mejaTDes13'] = $this->M_Des->get_sum_mejaDes13();
		$data['sum_mejaTDes14'] = $this->M_Des->get_sum_mejaDes14();
		$data['sum_mejaTDes15'] = $this->M_Des->get_sum_mejaDes15();
		$data['sum_mejaTDes16'] = $this->M_Des->get_sum_mejaDes16();
		$data['sum_mejaTDes17'] = $this->M_Des->get_sum_mejaDes17();
		$data['sum_mejaTDes18'] = $this->M_Des->get_sum_mejaDes18();
		$data['sum_mejaTDes19'] = $this->M_Des->get_sum_mejaDes19();
		$data['sum_mejaTDes20'] = $this->M_Des->get_sum_mejaDes20();
		$data['sum_mejaTDes21'] = $this->M_Des->get_sum_mejaDes21();
		$data['sum_mejaTDes22'] = $this->M_Des->get_sum_mejaDes22();
		$data['sum_mejaTDes23'] = $this->M_Des->get_sum_mejaDes23();
		$data['sum_mejaTDes24'] = $this->M_Des->get_sum_mejaDes24();
		$data['sum_mejaTDes25'] = $this->M_Des->get_sum_mejaDes25();
		$data['sum_mejaTDes26'] = $this->M_Des->get_sum_mejaDes26();
		$data['sum_mejaTDes27'] = $this->M_Des->get_sum_mejaDes27();
		$data['sum_mejaTDes28'] = $this->M_Des->get_sum_mejaDes28();
		$data['sum_mejaTDes29'] = $this->M_Des->get_sum_mejaDes29();
		$data['sum_mejaTDes30'] = $this->M_Des->get_sum_mejaDes30();
		$data['sum_mejaTDes31'] = $this->M_Des->get_sum_mejaDes31();

		$data['sum_totalAllDes'] = $this->M_Eticket->get_sumDes();
		$data['sum_totalAllMejaDes'] = $this->M_Eticket->get_summejaDes();

		$this->load->view('detail_bulan/detail_des', $data);
	}

	public function detail_rekapJan()
	{
		$data['data'] = $this->M_Eticket->getJan();

		$data['sum_totalJan1'] = $this->M_Jan->get_sumJan1();
		$data['sum_totalJan2'] = $this->M_Jan->get_sumJan2();
		$data['sum_totalJan3'] = $this->M_Jan->get_sumJan3();
		$data['sum_totalJan4'] = $this->M_Jan->get_sumJan4();
		$data['sum_totalJan5'] = $this->M_Jan->get_sumJan5();
		$data['sum_totalJan6'] = $this->M_Jan->get_sumJan6();
		$data['sum_totalJan7'] = $this->M_Jan->get_sumJan7();
		$data['sum_totalJan8'] = $this->M_Jan->get_sumJan8();
		$data['sum_totalJan9'] = $this->M_Jan->get_sumJan9();
		$data['sum_totalJan10'] = $this->M_Jan->get_sumJan10();
		$data['sum_totalJan11'] = $this->M_Jan->get_sumJan11();
		$data['sum_totalJan12'] = $this->M_Jan->get_sumJan12();
		$data['sum_totalJan13'] = $this->M_Jan->get_sumJan13();
		$data['sum_totalJan14'] = $this->M_Jan->get_sumJan14();
		$data['sum_totalJan15'] = $this->M_Jan->get_sumJan15();
		$data['sum_totalJan16'] = $this->M_Jan->get_sumJan16();
		$data['sum_totalJan17'] = $this->M_Jan->get_sumJan17();
		$data['sum_totalJan18'] = $this->M_Jan->get_sumJan18();
		$data['sum_totalJan19'] = $this->M_Jan->get_sumJan19();
		$data['sum_totalJan20'] = $this->M_Jan->get_sumJan20();
		$data['sum_totalJan21'] = $this->M_Jan->get_sumJan21();
		$data['sum_totalJan22'] = $this->M_Jan->get_sumJan22();
		$data['sum_totalJan23'] = $this->M_Jan->get_sumJan23();
		$data['sum_totalJan24'] = $this->M_Jan->get_sumJan24();
		$data['sum_totalJan25'] = $this->M_Jan->get_sumJan25();
		$data['sum_totalJan26'] = $this->M_Jan->get_sumJan26();
		$data['sum_totalJan27'] = $this->M_Jan->get_sumJan27();
		$data['sum_totalJan28'] = $this->M_Jan->get_sumJan28();
		$data['sum_totalJan29'] = $this->M_Jan->get_sumJan29();
		$data['sum_totalJan30'] = $this->M_Jan->get_sumJan30();
		$data['sum_totalJan31'] = $this->M_Jan->get_sumJan31();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTJan1'] = $this->M_Jan->get_sum_mejaJan1();
		$data['sum_mejaTJan2'] = $this->M_Jan->get_sum_mejaJan2();
		$data['sum_mejaTJan3'] = $this->M_Jan->get_sum_mejaJan3();
		$data['sum_mejaTJan4'] = $this->M_Jan->get_sum_mejaJan4();
		$data['sum_mejaTJan5'] = $this->M_Jan->get_sum_mejaJan5();
		$data['sum_mejaTJan6'] = $this->M_Jan->get_sum_mejaJan6();
		$data['sum_mejaTJan7'] = $this->M_Jan->get_sum_mejaJan7();
		$data['sum_mejaTJan8'] = $this->M_Jan->get_sum_mejaJan8();
		$data['sum_mejaTJan9'] = $this->M_Jan->get_sum_mejaJan9();
		$data['sum_mejaTJan10'] = $this->M_Jan->get_sum_mejaJan10();
		$data['sum_mejaTJan11'] = $this->M_Jan->get_sum_mejaJan11();
		$data['sum_mejaTJan12'] = $this->M_Jan->get_sum_mejaJan12();
		$data['sum_mejaTJan13'] = $this->M_Jan->get_sum_mejaJan13();
		$data['sum_mejaTJan14'] = $this->M_Jan->get_sum_mejaJan14();
		$data['sum_mejaTJan15'] = $this->M_Jan->get_sum_mejaJan15();
		$data['sum_mejaTJan16'] = $this->M_Jan->get_sum_mejaJan16();
		$data['sum_mejaTJan17'] = $this->M_Jan->get_sum_mejaJan17();
		$data['sum_mejaTJan18'] = $this->M_Jan->get_sum_mejaJan18();
		$data['sum_mejaTJan19'] = $this->M_Jan->get_sum_mejaJan19();
		$data['sum_mejaTJan20'] = $this->M_Jan->get_sum_mejaJan20();
		$data['sum_mejaTJan21'] = $this->M_Jan->get_sum_mejaJan21();
		$data['sum_mejaTJan22'] = $this->M_Jan->get_sum_mejaJan22();
		$data['sum_mejaTJan23'] = $this->M_Jan->get_sum_mejaJan23();
		$data['sum_mejaTJan24'] = $this->M_Jan->get_sum_mejaJan24();
		$data['sum_mejaTJan25'] = $this->M_Jan->get_sum_mejaJan25();
		$data['sum_mejaTJan26'] = $this->M_Jan->get_sum_mejaJan26();
		$data['sum_mejaTJan27'] = $this->M_Jan->get_sum_mejaJan27();
		$data['sum_mejaTJan28'] = $this->M_Jan->get_sum_mejaJan28();
		$data['sum_mejaTJan29'] = $this->M_Jan->get_sum_mejaJan29();
		$data['sum_mejaTJan30'] = $this->M_Jan->get_sum_mejaJan30();
		$data['sum_mejaTJan31'] = $this->M_Jan->get_sum_mejaJan31();

		$data['sum_totalAllJan'] = $this->M_Eticket->get_sumJan();
		$data['sum_totalAllMejaJan'] = $this->M_Eticket->get_summejaJan();

		$this->load->view('detail_bulan/detail_jan', $data);
	}

	public function detail_rekapFeb()
	{
		$data['data'] = $this->M_Eticket->getFeb();

		$data['sum_totalFeb1'] = $this->M_Feb->get_sumFeb1();
		$data['sum_totalFeb2'] = $this->M_Feb->get_sumFeb2();
		$data['sum_totalFeb3'] = $this->M_Feb->get_sumFeb3();
		$data['sum_totalFeb4'] = $this->M_Feb->get_sumFeb4();
		$data['sum_totalFeb5'] = $this->M_Feb->get_sumFeb5();
		$data['sum_totalFeb6'] = $this->M_Feb->get_sumFeb6();
		$data['sum_totalFeb7'] = $this->M_Feb->get_sumFeb7();
		$data['sum_totalFeb8'] = $this->M_Feb->get_sumFeb8();
		$data['sum_totalFeb9'] = $this->M_Feb->get_sumFeb9();
		$data['sum_totalFeb10'] = $this->M_Feb->get_sumFeb10();
		$data['sum_totalFeb11'] = $this->M_Feb->get_sumFeb11();
		$data['sum_totalFeb12'] = $this->M_Feb->get_sumFeb12();
		$data['sum_totalFeb13'] = $this->M_Feb->get_sumFeb13();
		$data['sum_totalFeb14'] = $this->M_Feb->get_sumFeb14();
		$data['sum_totalFeb15'] = $this->M_Feb->get_sumFeb15();
		$data['sum_totalFeb16'] = $this->M_Feb->get_sumFeb16();
		$data['sum_totalFeb17'] = $this->M_Feb->get_sumFeb17();
		$data['sum_totalFeb18'] = $this->M_Feb->get_sumFeb18();
		$data['sum_totalFeb19'] = $this->M_Feb->get_sumFeb19();
		$data['sum_totalFeb20'] = $this->M_Feb->get_sumFeb20();
		$data['sum_totalFeb21'] = $this->M_Feb->get_sumFeb21();
		$data['sum_totalFeb22'] = $this->M_Feb->get_sumFeb22();
		$data['sum_totalFeb23'] = $this->M_Feb->get_sumFeb23();
		$data['sum_totalFeb24'] = $this->M_Feb->get_sumFeb24();
		$data['sum_totalFeb25'] = $this->M_Feb->get_sumFeb25();
		$data['sum_totalFeb26'] = $this->M_Feb->get_sumFeb26();
		$data['sum_totalFeb27'] = $this->M_Feb->get_sumFeb27();
		$data['sum_totalFeb28'] = $this->M_Feb->get_sumFeb28();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTFeb1'] = $this->M_Feb->get_sum_mejaFeb1();
		$data['sum_mejaTFeb2'] = $this->M_Feb->get_sum_mejaFeb2();
		$data['sum_mejaTFeb3'] = $this->M_Feb->get_sum_mejaFeb3();
		$data['sum_mejaTFeb4'] = $this->M_Feb->get_sum_mejaFeb4();
		$data['sum_mejaTFeb5'] = $this->M_Feb->get_sum_mejaFeb5();
		$data['sum_mejaTFeb6'] = $this->M_Feb->get_sum_mejaFeb6();
		$data['sum_mejaTFeb7'] = $this->M_Feb->get_sum_mejaFeb7();
		$data['sum_mejaTFeb8'] = $this->M_Feb->get_sum_mejaFeb8();
		$data['sum_mejaTFeb9'] = $this->M_Feb->get_sum_mejaFeb9();
		$data['sum_mejaTFeb10'] = $this->M_Feb->get_sum_mejaFeb10();
		$data['sum_mejaTFeb11'] = $this->M_Feb->get_sum_mejaFeb11();
		$data['sum_mejaTFeb12'] = $this->M_Feb->get_sum_mejaFeb12();
		$data['sum_mejaTFeb13'] = $this->M_Feb->get_sum_mejaFeb13();
		$data['sum_mejaTFeb14'] = $this->M_Feb->get_sum_mejaFeb14();
		$data['sum_mejaTFeb15'] = $this->M_Feb->get_sum_mejaFeb15();
		$data['sum_mejaTFeb16'] = $this->M_Feb->get_sum_mejaFeb16();
		$data['sum_mejaTFeb17'] = $this->M_Feb->get_sum_mejaFeb17();
		$data['sum_mejaTFeb18'] = $this->M_Feb->get_sum_mejaFeb18();
		$data['sum_mejaTFeb19'] = $this->M_Feb->get_sum_mejaFeb19();
		$data['sum_mejaTFeb20'] = $this->M_Feb->get_sum_mejaFeb20();
		$data['sum_mejaTFeb21'] = $this->M_Feb->get_sum_mejaFeb21();
		$data['sum_mejaTFeb22'] = $this->M_Feb->get_sum_mejaFeb22();
		$data['sum_mejaTFeb23'] = $this->M_Feb->get_sum_mejaFeb23();
		$data['sum_mejaTFeb24'] = $this->M_Feb->get_sum_mejaFeb24();
		$data['sum_mejaTFeb25'] = $this->M_Feb->get_sum_mejaFeb25();
		$data['sum_mejaTFeb26'] = $this->M_Feb->get_sum_mejaFeb26();
		$data['sum_mejaTFeb27'] = $this->M_Feb->get_sum_mejaFeb27();
		$data['sum_mejaTFeb28'] = $this->M_Feb->get_sum_mejaFeb28();

		$data['sum_totalAllFeb'] = $this->M_Eticket->get_sumFeb();
		$data['sum_totalAllMejaFeb'] = $this->M_Eticket->get_summejaFeb();

		$this->load->view('detail_bulan/detail_feb', $data);
	}

	public function detail_rekapMar()
	{
		$data['data'] = $this->M_Eticket->getMar();

		$data['sum_totalMar1'] = $this->M_Mar->get_sumMar1();
		$data['sum_totalMar2'] = $this->M_Mar->get_sumMar2();
		$data['sum_totalMar3'] = $this->M_Mar->get_sumMar3();
		$data['sum_totalMar4'] = $this->M_Mar->get_sumMar4();
		$data['sum_totalMar5'] = $this->M_Mar->get_sumMar5();
		$data['sum_totalMar6'] = $this->M_Mar->get_sumMar6();
		$data['sum_totalMar7'] = $this->M_Mar->get_sumMar7();
		$data['sum_totalMar8'] = $this->M_Mar->get_sumMar8();
		$data['sum_totalMar9'] = $this->M_Mar->get_sumMar9();
		$data['sum_totalMar10'] = $this->M_Mar->get_sumMar10();
		$data['sum_totalMar11'] = $this->M_Mar->get_sumMar11();
		$data['sum_totalMar12'] = $this->M_Mar->get_sumMar12();
		$data['sum_totalMar13'] = $this->M_Mar->get_sumMar13();
		$data['sum_totalMar14'] = $this->M_Mar->get_sumMar14();
		$data['sum_totalMar15'] = $this->M_Mar->get_sumMar15();
		$data['sum_totalMar16'] = $this->M_Mar->get_sumMar16();
		$data['sum_totalMar17'] = $this->M_Mar->get_sumMar17();
		$data['sum_totalMar18'] = $this->M_Mar->get_sumMar18();
		$data['sum_totalMar19'] = $this->M_Mar->get_sumMar19();
		$data['sum_totalMar20'] = $this->M_Mar->get_sumMar20();
		$data['sum_totalMar21'] = $this->M_Mar->get_sumMar21();
		$data['sum_totalMar22'] = $this->M_Mar->get_sumMar22();
		$data['sum_totalMar23'] = $this->M_Mar->get_sumMar23();
		$data['sum_totalMar24'] = $this->M_Mar->get_sumMar24();
		$data['sum_totalMar25'] = $this->M_Mar->get_sumMar25();
		$data['sum_totalMar26'] = $this->M_Mar->get_sumMar26();
		$data['sum_totalMar27'] = $this->M_Mar->get_sumMar27();
		$data['sum_totalMar28'] = $this->M_Mar->get_sumMar28();
		$data['sum_totalMar29'] = $this->M_Mar->get_sumMar29();
		$data['sum_totalMar30'] = $this->M_Mar->get_sumMar30();
		$data['sum_totalMar31'] = $this->M_Mar->get_sumMar31();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTMar1'] = $this->M_Mar->get_sum_mejaMar1();
		$data['sum_mejaTMar2'] = $this->M_Mar->get_sum_mejaMar2();
		$data['sum_mejaTMar3'] = $this->M_Mar->get_sum_mejaMar3();
		$data['sum_mejaTMar4'] = $this->M_Mar->get_sum_mejaMar4();
		$data['sum_mejaTMar5'] = $this->M_Mar->get_sum_mejaMar5();
		$data['sum_mejaTMar6'] = $this->M_Mar->get_sum_mejaMar6();
		$data['sum_mejaTMar7'] = $this->M_Mar->get_sum_mejaMar7();
		$data['sum_mejaTMar8'] = $this->M_Mar->get_sum_mejaMar8();
		$data['sum_mejaTMar9'] = $this->M_Mar->get_sum_mejaMar9();
		$data['sum_mejaTMar10'] = $this->M_Mar->get_sum_mejaMar10();
		$data['sum_mejaTMar11'] = $this->M_Mar->get_sum_mejaMar11();
		$data['sum_mejaTMar12'] = $this->M_Mar->get_sum_mejaMar12();
		$data['sum_mejaTMar13'] = $this->M_Mar->get_sum_mejaMar13();
		$data['sum_mejaTMar14'] = $this->M_Mar->get_sum_mejaMar14();
		$data['sum_mejaTMar15'] = $this->M_Mar->get_sum_mejaMar15();
		$data['sum_mejaTMar16'] = $this->M_Mar->get_sum_mejaMar16();
		$data['sum_mejaTMar17'] = $this->M_Mar->get_sum_mejaMar17();
		$data['sum_mejaTMar18'] = $this->M_Mar->get_sum_mejaMar18();
		$data['sum_mejaTMar19'] = $this->M_Mar->get_sum_mejaMar19();
		$data['sum_mejaTMar20'] = $this->M_Mar->get_sum_mejaMar20();
		$data['sum_mejaTMar21'] = $this->M_Mar->get_sum_mejaMar21();
		$data['sum_mejaTMar22'] = $this->M_Mar->get_sum_mejaMar22();
		$data['sum_mejaTMar23'] = $this->M_Mar->get_sum_mejaMar23();
		$data['sum_mejaTMar24'] = $this->M_Mar->get_sum_mejaMar24();
		$data['sum_mejaTMar25'] = $this->M_Mar->get_sum_mejaMar25();
		$data['sum_mejaTMar26'] = $this->M_Mar->get_sum_mejaMar26();
		$data['sum_mejaTMar27'] = $this->M_Mar->get_sum_mejaMar27();
		$data['sum_mejaTMar28'] = $this->M_Mar->get_sum_mejaMar28();
		$data['sum_mejaTMar29'] = $this->M_Mar->get_sum_mejaMar29();
		$data['sum_mejaTMar30'] = $this->M_Mar->get_sum_mejaMar30();
		$data['sum_mejaTMar31'] = $this->M_Mar->get_sum_mejaMar31();

		$data['sum_totalAllMar'] = $this->M_Eticket->get_sumMar();
		$data['sum_totalAllMejaMar'] = $this->M_Eticket->get_summejaMar();

		$this->load->view('detail_bulan/detail_mar', $data);
	}

	public function detail_rekapApr()
	{
		$data['data'] = $this->M_Eticket->getApr();

		$data['sum_totalApr1'] = $this->M_Apr->get_sumApr1();
		$data['sum_totalApr2'] = $this->M_Apr->get_sumApr2();
		$data['sum_totalApr3'] = $this->M_Apr->get_sumApr3();
		$data['sum_totalApr4'] = $this->M_Apr->get_sumApr4();
		$data['sum_totalApr5'] = $this->M_Apr->get_sumApr5();
		$data['sum_totalApr6'] = $this->M_Apr->get_sumApr6();
		$data['sum_totalApr7'] = $this->M_Apr->get_sumApr7();
		$data['sum_totalApr8'] = $this->M_Apr->get_sumApr8();
		$data['sum_totalApr9'] = $this->M_Apr->get_sumApr9();
		$data['sum_totalApr10'] = $this->M_Apr->get_sumApr10();
		$data['sum_totalApr11'] = $this->M_Apr->get_sumApr11();
		$data['sum_totalApr12'] = $this->M_Apr->get_sumApr12();
		$data['sum_totalApr13'] = $this->M_Apr->get_sumApr13();
		$data['sum_totalApr14'] = $this->M_Apr->get_sumApr14();
		$data['sum_totalApr15'] = $this->M_Apr->get_sumApr15();
		$data['sum_totalApr16'] = $this->M_Apr->get_sumApr16();
		$data['sum_totalApr17'] = $this->M_Apr->get_sumApr17();
		$data['sum_totalApr18'] = $this->M_Apr->get_sumApr18();
		$data['sum_totalApr19'] = $this->M_Apr->get_sumApr19();
		$data['sum_totalApr20'] = $this->M_Apr->get_sumApr20();
		$data['sum_totalApr21'] = $this->M_Apr->get_sumApr21();
		$data['sum_totalApr22'] = $this->M_Apr->get_sumApr22();
		$data['sum_totalApr23'] = $this->M_Apr->get_sumApr23();
		$data['sum_totalApr24'] = $this->M_Apr->get_sumApr24();
		$data['sum_totalApr25'] = $this->M_Apr->get_sumApr25();
		$data['sum_totalApr26'] = $this->M_Apr->get_sumApr26();
		$data['sum_totalApr27'] = $this->M_Apr->get_sumApr27();
		$data['sum_totalApr28'] = $this->M_Apr->get_sumApr28();
		$data['sum_totalApr29'] = $this->M_Apr->get_sumApr29();
		$data['sum_totalApr30'] = $this->M_Apr->get_sumApr30();

		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTApr1'] = $this->M_Apr->get_sum_mejaApr1();
		$data['sum_mejaTApr2'] = $this->M_Apr->get_sum_mejaApr2();
		$data['sum_mejaTApr3'] = $this->M_Apr->get_sum_mejaApr3();
		$data['sum_mejaTApr4'] = $this->M_Apr->get_sum_mejaApr4();
		$data['sum_mejaTApr5'] = $this->M_Apr->get_sum_mejaApr5();
		$data['sum_mejaTApr6'] = $this->M_Apr->get_sum_mejaApr6();
		$data['sum_mejaTApr7'] = $this->M_Apr->get_sum_mejaApr7();
		$data['sum_mejaTApr8'] = $this->M_Apr->get_sum_mejaApr8();
		$data['sum_mejaTApr9'] = $this->M_Apr->get_sum_mejaApr9();
		$data['sum_mejaTApr10'] = $this->M_Apr->get_sum_mejaApr10();
		$data['sum_mejaTApr11'] = $this->M_Apr->get_sum_mejaApr11();
		$data['sum_mejaTApr12'] = $this->M_Apr->get_sum_mejaApr12();
		$data['sum_mejaTApr13'] = $this->M_Apr->get_sum_mejaApr13();
		$data['sum_mejaTApr14'] = $this->M_Apr->get_sum_mejaApr14();
		$data['sum_mejaTApr15'] = $this->M_Apr->get_sum_mejaApr15();
		$data['sum_mejaTApr16'] = $this->M_Apr->get_sum_mejaApr16();
		$data['sum_mejaTApr17'] = $this->M_Apr->get_sum_mejaApr17();
		$data['sum_mejaTApr18'] = $this->M_Apr->get_sum_mejaApr18();
		$data['sum_mejaTApr19'] = $this->M_Apr->get_sum_mejaApr19();
		$data['sum_mejaTApr20'] = $this->M_Apr->get_sum_mejaApr20();
		$data['sum_mejaTApr21'] = $this->M_Apr->get_sum_mejaApr21();
		$data['sum_mejaTApr22'] = $this->M_Apr->get_sum_mejaApr22();
		$data['sum_mejaTApr23'] = $this->M_Apr->get_sum_mejaApr23();
		$data['sum_mejaTApr24'] = $this->M_Apr->get_sum_mejaApr24();
		$data['sum_mejaTApr25'] = $this->M_Apr->get_sum_mejaApr25();
		$data['sum_mejaTApr26'] = $this->M_Apr->get_sum_mejaApr26();
		$data['sum_mejaTApr27'] = $this->M_Apr->get_sum_mejaApr27();
		$data['sum_mejaTApr28'] = $this->M_Apr->get_sum_mejaApr28();
		$data['sum_mejaTApr29'] = $this->M_Apr->get_sum_mejaApr29();
		$data['sum_mejaTApr30'] = $this->M_Apr->get_sum_mejaApr30();

		$data['sum_totalAllApr'] = $this->M_Eticket->get_sumApr();
		$data['sum_totalAllMejaApr'] = $this->M_Eticket->get_summejaApr();

		$this->load->view('detail_bulan/detail_apr', $data);
	}

	public function detail_rekapMei()
	{
		$data['data'] = $this->M_Eticket->getMei();

		$data['sum_totalMei1'] = $this->M_Mei->get_sumMei1();
		$data['sum_totalMei2'] = $this->M_Mei->get_sumMei2();
		$data['sum_totalMei3'] = $this->M_Mei->get_sumMei3();
		$data['sum_totalMei4'] = $this->M_Mei->get_sumMei4();
		$data['sum_totalMei5'] = $this->M_Mei->get_sumMei5();
		$data['sum_totalMei6'] = $this->M_Mei->get_sumMei6();
		$data['sum_totalMei7'] = $this->M_Mei->get_sumMei7();
		$data['sum_totalMei8'] = $this->M_Mei->get_sumMei8();
		$data['sum_totalMei9'] = $this->M_Mei->get_sumMei9();
		$data['sum_totalMei10'] = $this->M_Mei->get_sumMei10();
		$data['sum_totalMei11'] = $this->M_Mei->get_sumMei11();
		$data['sum_totalMei12'] = $this->M_Mei->get_sumMei12();
		$data['sum_totalMei13'] = $this->M_Mei->get_sumMei13();
		$data['sum_totalMei14'] = $this->M_Mei->get_sumMei14();
		$data['sum_totalMei15'] = $this->M_Mei->get_sumMei15();
		$data['sum_totalMei16'] = $this->M_Mei->get_sumMei16();
		$data['sum_totalMei17'] = $this->M_Mei->get_sumMei17();
		$data['sum_totalMei18'] = $this->M_Mei->get_sumMei18();
		$data['sum_totalMei19'] = $this->M_Mei->get_sumMei19();
		$data['sum_totalMei20'] = $this->M_Mei->get_sumMei20();
		$data['sum_totalMei21'] = $this->M_Mei->get_sumMei21();
		$data['sum_totalMei22'] = $this->M_Mei->get_sumMei22();
		$data['sum_totalMei23'] = $this->M_Mei->get_sumMei23();
		$data['sum_totalMei24'] = $this->M_Mei->get_sumMei24();
		$data['sum_totalMei25'] = $this->M_Mei->get_sumMei25();
		$data['sum_totalMei26'] = $this->M_Mei->get_sumMei26();
		$data['sum_totalMei27'] = $this->M_Mei->get_sumMei27();
		$data['sum_totalMei28'] = $this->M_Mei->get_sumMei28();
		$data['sum_totalMei29'] = $this->M_Mei->get_sumMei29();
		$data['sum_totalMei30'] = $this->M_Mei->get_sumMei30();
		$data['sum_totalMei31'] = $this->M_Mei->get_sumMei31();
		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTMei1'] = $this->M_Mei->get_sum_mejaMei1();
		$data['sum_mejaTMei2'] = $this->M_Mei->get_sum_mejaMei2();
		$data['sum_mejaTMei3'] = $this->M_Mei->get_sum_mejaMei3();
		$data['sum_mejaTMei4'] = $this->M_Mei->get_sum_mejaMei4();
		$data['sum_mejaTMei5'] = $this->M_Mei->get_sum_mejaMei5();
		$data['sum_mejaTMei6'] = $this->M_Mei->get_sum_mejaMei6();
		$data['sum_mejaTMei7'] = $this->M_Mei->get_sum_mejaMei7();
		$data['sum_mejaTMei8'] = $this->M_Mei->get_sum_mejaMei8();
		$data['sum_mejaTMei9'] = $this->M_Mei->get_sum_mejaMei9();
		$data['sum_mejaTMei10'] = $this->M_Mei->get_sum_mejaMei10();
		$data['sum_mejaTMei11'] = $this->M_Mei->get_sum_mejaMei11();
		$data['sum_mejaTMei12'] = $this->M_Mei->get_sum_mejaMei12();
		$data['sum_mejaTMei13'] = $this->M_Mei->get_sum_mejaMei13();
		$data['sum_mejaTMei14'] = $this->M_Mei->get_sum_mejaMei14();
		$data['sum_mejaTMei15'] = $this->M_Mei->get_sum_mejaMei15();
		$data['sum_mejaTMei16'] = $this->M_Mei->get_sum_mejaMei16();
		$data['sum_mejaTMei17'] = $this->M_Mei->get_sum_mejaMei17();
		$data['sum_mejaTMei18'] = $this->M_Mei->get_sum_mejaMei18();
		$data['sum_mejaTMei19'] = $this->M_Mei->get_sum_mejaMei19();
		$data['sum_mejaTMei20'] = $this->M_Mei->get_sum_mejaMei20();
		$data['sum_mejaTMei21'] = $this->M_Mei->get_sum_mejaMei21();
		$data['sum_mejaTMei22'] = $this->M_Mei->get_sum_mejaMei22();
		$data['sum_mejaTMei23'] = $this->M_Mei->get_sum_mejaMei23();
		$data['sum_mejaTMei24'] = $this->M_Mei->get_sum_mejaMei24();
		$data['sum_mejaTMei25'] = $this->M_Mei->get_sum_mejaMei25();
		$data['sum_mejaTMei26'] = $this->M_Mei->get_sum_mejaMei26();
		$data['sum_mejaTMei27'] = $this->M_Mei->get_sum_mejaMei27();
		$data['sum_mejaTMei28'] = $this->M_Mei->get_sum_mejaMei28();
		$data['sum_mejaTMei29'] = $this->M_Mei->get_sum_mejaMei29();
		$data['sum_mejaTMei30'] = $this->M_Mei->get_sum_mejaMei30();
		$data['sum_mejaTMei31'] = $this->M_Mei->get_sum_mejaMei31();

		$data['sum_totalAllMei'] = $this->M_Eticket->get_sumMei();
		$data['sum_totalAllMejaMei'] = $this->M_Eticket->get_summejaMei();

		$this->load->view('detail_bulan/detail_mei', $data);
	}

	public function detail_rekapJun()
	{
		$data['data'] = $this->M_Eticket->getJun();

		$data['sum_totalJun1'] = $this->M_Jun->get_sumJun1();
		$data['sum_totalJun2'] = $this->M_Jun->get_sumJun2();
		$data['sum_totalJun3'] = $this->M_Jun->get_sumJun3();
		$data['sum_totalJun4'] = $this->M_Jun->get_sumJun4();
		$data['sum_totalJun5'] = $this->M_Jun->get_sumJun5();
		$data['sum_totalJun6'] = $this->M_Jun->get_sumJun6();
		$data['sum_totalJun7'] = $this->M_Jun->get_sumJun7();
		$data['sum_totalJun8'] = $this->M_Jun->get_sumJun8();
		$data['sum_totalJun9'] = $this->M_Jun->get_sumJun9();
		$data['sum_totalJun10'] = $this->M_Jun->get_sumJun10();
		$data['sum_totalJun11'] = $this->M_Jun->get_sumJun11();
		$data['sum_totalJun12'] = $this->M_Jun->get_sumJun12();
		$data['sum_totalJun13'] = $this->M_Jun->get_sumJun13();
		$data['sum_totalJun14'] = $this->M_Jun->get_sumJun14();
		$data['sum_totalJun15'] = $this->M_Jun->get_sumJun15();
		$data['sum_totalJun16'] = $this->M_Jun->get_sumJun16();
		$data['sum_totalJun17'] = $this->M_Jun->get_sumJun17();
		$data['sum_totalJun18'] = $this->M_Jun->get_sumJun18();
		$data['sum_totalJun19'] = $this->M_Jun->get_sumJun19();
		$data['sum_totalJun20'] = $this->M_Jun->get_sumJun20();
		$data['sum_totalJun21'] = $this->M_Jun->get_sumJun21();
		$data['sum_totalJun22'] = $this->M_Jun->get_sumJun22();
		$data['sum_totalJun23'] = $this->M_Jun->get_sumJun23();
		$data['sum_totalJun24'] = $this->M_Jun->get_sumJun24();
		$data['sum_totalJun25'] = $this->M_Jun->get_sumJun25();
		$data['sum_totalJun26'] = $this->M_Jun->get_sumJun26();
		$data['sum_totalJun27'] = $this->M_Jun->get_sumJun27();
		$data['sum_totalJun28'] = $this->M_Jun->get_sumJun28();
		$data['sum_totalJun29'] = $this->M_Jun->get_sumJun29();
		$data['sum_totalJun30'] = $this->M_Jun->get_sumJun30();


		///////////////// SUM TOTAL TIKET TERJUAL //////////////

		$data['sum_mejaTJun1'] = $this->M_Jun->get_sum_mejaJun1();
		$data['sum_mejaTJun2'] = $this->M_Jun->get_sum_mejaJun2();
		$data['sum_mejaTJun3'] = $this->M_Jun->get_sum_mejaJun3();
		$data['sum_mejaTJun4'] = $this->M_Jun->get_sum_mejaJun4();
		$data['sum_mejaTJun5'] = $this->M_Jun->get_sum_mejaJun5();
		$data['sum_mejaTJun6'] = $this->M_Jun->get_sum_mejaJun6();
		$data['sum_mejaTJun7'] = $this->M_Jun->get_sum_mejaJun7();
		$data['sum_mejaTJun8'] = $this->M_Jun->get_sum_mejaJun8();
		$data['sum_mejaTJun9'] = $this->M_Jun->get_sum_mejaJun9();
		$data['sum_mejaTJun10'] = $this->M_Jun->get_sum_mejaJun10();
		$data['sum_mejaTJun11'] = $this->M_Jun->get_sum_mejaJun11();
		$data['sum_mejaTJun12'] = $this->M_Jun->get_sum_mejaJun12();
		$data['sum_mejaTJun13'] = $this->M_Jun->get_sum_mejaJun13();
		$data['sum_mejaTJun14'] = $this->M_Jun->get_sum_mejaJun14();
		$data['sum_mejaTJun15'] = $this->M_Jun->get_sum_mejaJun15();
		$data['sum_mejaTJun16'] = $this->M_Jun->get_sum_mejaJun16();
		$data['sum_mejaTJun17'] = $this->M_Jun->get_sum_mejaJun17();
		$data['sum_mejaTJun18'] = $this->M_Jun->get_sum_mejaJun18();
		$data['sum_mejaTJun19'] = $this->M_Jun->get_sum_mejaJun19();
		$data['sum_mejaTJun20'] = $this->M_Jun->get_sum_mejaJun20();
		$data['sum_mejaTJun21'] = $this->M_Jun->get_sum_mejaJun21();
		$data['sum_mejaTJun22'] = $this->M_Jun->get_sum_mejaJun22();
		$data['sum_mejaTJun23'] = $this->M_Jun->get_sum_mejaJun23();
		$data['sum_mejaTJun24'] = $this->M_Jun->get_sum_mejaJun24();
		$data['sum_mejaTJun25'] = $this->M_Jun->get_sum_mejaJun25();
		$data['sum_mejaTJun26'] = $this->M_Jun->get_sum_mejaJun26();
		$data['sum_mejaTJun27'] = $this->M_Jun->get_sum_mejaJun27();
		$data['sum_mejaTJun28'] = $this->M_Jun->get_sum_mejaJun28();
		$data['sum_mejaTJun29'] = $this->M_Jun->get_sum_mejaJun29();
		$data['sum_mejaTJun30'] = $this->M_Jun->get_sum_mejaJun30();

		$data['sum_totalAllJun'] = $this->M_Eticket->get_sumJun();
		$data['sum_totalAllMejaJun'] = $this->M_Eticket->get_summejaJun();

		$this->load->view('detail_bulan/detail_jun', $data);
	}

	public function cari()
	{
		$this->load->view('transaksi');
	}

	public function hasil()
	{
		$data2['cari'] = $this->M_Eticket->cari();
		$this->load->view('result_cari', $data2);
	}

	//////////////// ENGNEERING CRUD //////////////////

	public function cariIKC()
	{
		$this->load->view('edit_transaksi');
	}

	public function hasilIKC()
	{
		$data2['cari'] = $this->M_Eticket->cari();
		$this->load->view('result_cari_ikc', $data2);
	}

	public function halaman_transaksi_admin()
	{
		$config = array();
		$config['base_url'] = site_url('home/halaman_transaksi_admin');
		$config['total_rows'] = $this->db->count_all('transaksi');
		$config['per_page'] = 10;
		$config['uri_segment'] = 3;
		$choice = $config["total_rows"] / $config['per_page'];
		$config["num_links"] = floor($choice);
		$config['first_link'] = 'First';
		$config['last_link'] = 'Last';
		$config['next_link'] = 'Next';
		$config['prev_link'] = 'Prev';
		$config['full_tag_open'] = '<div class="pagging text-center"><nav><ul class="pagination justify-content-center">';
		$config['full_tag_close'] = '</ul></nav></div>';
		$config['num_tag_open'] = '<li class="page-item"><span class="page-link">';
		$config['num_tag_close'] = '</span></li>';
		$config['cur_tag_open'] = '<li class="page-item active"><span class="page-link">';
		$config['cur_tag_close'] = '</span></li>';
		$config['next_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['next_tagl_close'] = '<span aria-hidden= "true">&raquo</span></span></li>';
		$config['prev_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['prev_tagl_close'] = '</span>Next</li>';
		$config['first_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['first_tagl_close'] = '</span></li>';
		$config['last_tag_open'] = '<li class="page-item "><span class="page-link">';
		$config['last_tagl_close'] = '</span></li>';

		$this->pagination->initialize($config);
		$data['page'] = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;
		$data['pagination'] = $this->pagination->create_links();

		$data['data'] = $this->M_Eticket->getDataTransaksi($config["per_page"], $data['page']);
		$this->load->view('hapus_transaksi', $data);
	}

	public function delete($id_transaksi)
	{
		$this->M_Eticket->deleteData($id_transaksi);
		redirect(base_url('/home/halaman_transaksi_admin'));
	}
}
