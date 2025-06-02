<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Oct extends CI_Model
{
    public function get_sumOct1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-01'");
        return $this->db->get('')->row();
    }
    public function get_sumOct2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-02'");
        return $this->db->get('')->row();
    }
    public function get_sumOct3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-03'");
        return $this->db->get('')->row();
    }
    public function get_sumOct4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-04'");
        return $this->db->get('')->row();
    }
    public function get_sumOct5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-05'");
        return $this->db->get('')->row();
    }
    public function get_sumOct6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-06'");
        return $this->db->get('')->row();
    }
    public function get_sumOct7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-07'");
        return $this->db->get('')->row();
    }
    public function get_sumOct8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-08'");
        return $this->db->get('')->row();
    }
    public function get_sumOct9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-09'");
        return $this->db->get('')->row();
    }
    public function get_sumOct10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-10'");
        return $this->db->get('')->row();
    }
    public function get_sumOct11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-11'");
        return $this->db->get('')->row();
    }
    public function get_sumOct12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-12'");
        return $this->db->get('')->row();
    }
    public function get_sumOct13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-13'");
        return $this->db->get('')->row();
    }
    public function get_sumOct14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-14'");
        return $this->db->get('')->row();
    }
    public function get_sumOct15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-15'");
        return $this->db->get('')->row();
    }
    public function get_sumOct16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-16'");
        return $this->db->get('')->row();
    }
    public function get_sumOct17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-17'");
        return $this->db->get('')->row();
    }
    public function get_sumOct18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-18'");
        return $this->db->get('')->row();
    }
    public function get_sumOct19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-19'");
        return $this->db->get('')->row();
    }
    public function get_sumOct20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-20'");
        return $this->db->get('')->row();
    }
    public function get_sumOct21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-21'");
        return $this->db->get('')->row();
    }
    public function get_sumOct22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-22'");
        return $this->db->get('')->row();
    }
    public function get_sumOct23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-23'");
        return $this->db->get('')->row();
    }
    public function get_sumOct24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-24'");
        return $this->db->get('')->row();
    }
    public function get_sumOct25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-25'");
        return $this->db->get('')->row();
    }
    public function get_sumOct26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-26'");
        return $this->db->get('')->row();
    }
    public function get_sumOct27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-27'");
        return $this->db->get('')->row();
    }
    public function get_sumOct28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-28'");
        return $this->db->get('')->row();
    }
    public function get_sumOct29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-29'");
        return $this->db->get('')->row();
    }
    public function get_sumOct30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-30'");
        return $this->db->get('')->row();
    }
    public function get_sumOct31()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-10-31'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaOct1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-30'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaOct31()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-10-31'");
        return $this->db->get('')->row();
    }
}
