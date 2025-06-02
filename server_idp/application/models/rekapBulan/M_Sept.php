<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Sept extends CI_Model
{
    public function get_sumSept1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-01'");
        return $this->db->get('')->row();
    }
    public function get_sumSept2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-02'");
        return $this->db->get('')->row();
    }
    public function get_sumSept3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-03'");
        return $this->db->get('')->row();
    }
    public function get_sumSept4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-04'");
        return $this->db->get('')->row();
    }
    public function get_sumSept5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-05'");
        return $this->db->get('')->row();
    }
    public function get_sumSept6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-06'");
        return $this->db->get('')->row();
    }
    public function get_sumSept7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-09'");
        return $this->db->get('')->row();
    }
    public function get_sumSept8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-08'");
        return $this->db->get('')->row();
    }
    public function get_sumSept9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-09'");
        return $this->db->get('')->row();
    }
    public function get_sumSept10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-10'");
        return $this->db->get('')->row();
    }
    public function get_sumSept11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-11'");
        return $this->db->get('')->row();
    }
    public function get_sumSept12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-12'");
        return $this->db->get('')->row();
    }
    public function get_sumSept13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-13'");
        return $this->db->get('')->row();
    }
    public function get_sumSept14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-14'");
        return $this->db->get('')->row();
    }
    public function get_sumSept15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-15'");
        return $this->db->get('')->row();
    }
    public function get_sumSept16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-16'");
        return $this->db->get('')->row();
    }
    public function get_sumSept17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-17'");
        return $this->db->get('')->row();
    }
    public function get_sumSept18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-18'");
        return $this->db->get('')->row();
    }
    public function get_sumSept19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-19'");
        return $this->db->get('')->row();
    }
    public function get_sumSept20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-20'");
        return $this->db->get('')->row();
    }
    public function get_sumSept21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-21'");
        return $this->db->get('')->row();
    }
    public function get_sumSept22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-22'");
        return $this->db->get('')->row();
    }
    public function get_sumSept23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-23'");
        return $this->db->get('')->row();
    }
    public function get_sumSept24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-24'");
        return $this->db->get('')->row();
    }
    public function get_sumSept25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-25'");
        return $this->db->get('')->row();
    }
    public function get_sumSept26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-26'");
        return $this->db->get('')->row();
    }
    public function get_sumSept27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-27'");
        return $this->db->get('')->row();
    }
    public function get_sumSept28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-28'");
        return $this->db->get('')->row();
    }
    public function get_sumSept29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-29'");
        return $this->db->get('')->row();
    }
    public function get_sumSept30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-09-30'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaSept1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaSept30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-09-30'");
        return $this->db->get('')->row();
    }
}
