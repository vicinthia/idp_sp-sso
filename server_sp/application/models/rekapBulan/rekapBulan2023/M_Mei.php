<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Mei extends CI_Model
{
    public function get_sumMei1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-01'");
        return $this->db->get('')->row();
    }
    public function get_sumMei2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-02'");
        return $this->db->get('')->row();
    }
    public function get_sumMei3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-03'");
        return $this->db->get('')->row();
    }
    public function get_sumMei4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-04'");
        return $this->db->get('')->row();
    }
    public function get_sumMei5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-05'");
        return $this->db->get('')->row();
    }
    public function get_sumMei6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-06'");
        return $this->db->get('')->row();
    }
    public function get_sumMei7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-07'");
        return $this->db->get('')->row();
    }
    public function get_sumMei8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-08'");
        return $this->db->get('')->row();
    }
    public function get_sumMei9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-09'");
        return $this->db->get('')->row();
    }
    public function get_sumMei10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-10'");
        return $this->db->get('')->row();
    }
    public function get_sumMei11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-11'");
        return $this->db->get('')->row();
    }
    public function get_sumMei12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-12'");
        return $this->db->get('')->row();
    }
    public function get_sumMei13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-13'");
        return $this->db->get('')->row();
    }
    public function get_sumMei14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-14'");
        return $this->db->get('')->row();
    }
    public function get_sumMei15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-15'");
        return $this->db->get('')->row();
    }
    public function get_sumMei16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-16'");
        return $this->db->get('')->row();
    }
    public function get_sumMei17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-17'");
        return $this->db->get('')->row();
    }
    public function get_sumMei18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-18'");
        return $this->db->get('')->row();
    }
    public function get_sumMei19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-19'");
        return $this->db->get('')->row();
    }
    public function get_sumMei20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-20'");
        return $this->db->get('')->row();
    }
    public function get_sumMei21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-21'");
        return $this->db->get('')->row();
    }
    public function get_sumMei22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-22'");
        return $this->db->get('')->row();
    }
    public function get_sumMei23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-23'");
        return $this->db->get('')->row();
    }
    public function get_sumMei24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-24'");
        return $this->db->get('')->row();
    }
    public function get_sumMei25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-25'");
        return $this->db->get('')->row();
    }
    public function get_sumMei26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-26'");
        return $this->db->get('')->row();
    }
    public function get_sumMei27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-27'");
        return $this->db->get('')->row();
    }
    public function get_sumMei28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-28'");
        return $this->db->get('')->row();
    }
    public function get_sumMei29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-29'");
        return $this->db->get('')->row();
    }
    public function get_sumMei30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-30'");
        return $this->db->get('')->row();
    }
    public function get_sumMei31()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-05-31'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaMei1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-30'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMei31()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-05-31'");
        return $this->db->get('')->row();
    }
}
