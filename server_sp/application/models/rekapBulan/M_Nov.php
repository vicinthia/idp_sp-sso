<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Nov extends CI_Model
{
    public function get_sumNov1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-01'");
        return $this->db->get('')->row();
    }
    public function get_sumNov2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-02'");
        return $this->db->get('')->row();
    }
    public function get_sumNov3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-03'");
        return $this->db->get('')->row();
    }
    public function get_sumNov4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-04'");
        return $this->db->get('')->row();
    }
    public function get_sumNov5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-05'");
        return $this->db->get('')->row();
    }
    public function get_sumNov6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-06'");
        return $this->db->get('')->row();
    }
    public function get_sumNov7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-07'");
        return $this->db->get('')->row();
    }
    public function get_sumNov8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-08'");
        return $this->db->get('')->row();
    }
    public function get_sumNov9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-09'");
        return $this->db->get('')->row();
    }
    public function get_sumNov10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-10'");
        return $this->db->get('')->row();
    }
    public function get_sumNov11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-11'");
        return $this->db->get('')->row();
    }
    public function get_sumNov12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-12'");
        return $this->db->get('')->row();
    }
    public function get_sumNov13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-13'");
        return $this->db->get('')->row();
    }
    public function get_sumNov14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-14'");
        return $this->db->get('')->row();
    }
    public function get_sumNov15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-15'");
        return $this->db->get('')->row();
    }
    public function get_sumNov16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-16'");
        return $this->db->get('')->row();
    }
    public function get_sumNov17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-17'");
        return $this->db->get('')->row();
    }
    public function get_sumNov18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-18'");
        return $this->db->get('')->row();
    }
    public function get_sumNov19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-19'");
        return $this->db->get('')->row();
    }
    public function get_sumNov20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-20'");
        return $this->db->get('')->row();
    }
    public function get_sumNov21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-21'");
        return $this->db->get('')->row();
    }
    public function get_sumNov22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-22'");
        return $this->db->get('')->row();
    }
    public function get_sumNov23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-23'");
        return $this->db->get('')->row();
    }
    public function get_sumNov24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-24'");
        return $this->db->get('')->row();
    }
    public function get_sumNov25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-25'");
        return $this->db->get('')->row();
    }
    public function get_sumNov26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-26'");
        return $this->db->get('')->row();
    }
    public function get_sumNov27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-27'");
        return $this->db->get('')->row();
    }
    public function get_sumNov28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-28'");
        return $this->db->get('')->row();
    }
    public function get_sumNov29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-29'");
        return $this->db->get('')->row();
    }
    public function get_sumNov30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-11-30'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaNov1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaNov30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-11-30'");
        return $this->db->get('')->row();
    }
}
