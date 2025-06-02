<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Mar extends CI_Model
{
    public function get_sumMar1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-01'");
        return $this->db->get('')->row();
    }
    public function get_sumMar2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-02'");
        return $this->db->get('')->row();
    }
    public function get_sumMar3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-03'");
        return $this->db->get('')->row();
    }
    public function get_sumMar4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-04'");
        return $this->db->get('')->row();
    }
    public function get_sumMar5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-05'");
        return $this->db->get('')->row();
    }
    public function get_sumMar6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-06'");
        return $this->db->get('')->row();
    }
    public function get_sumMar7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-07'");
        return $this->db->get('')->row();
    }
    public function get_sumMar8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-08'");
        return $this->db->get('')->row();
    }
    public function get_sumMar9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-09'");
        return $this->db->get('')->row();
    }
    public function get_sumMar10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-10'");
        return $this->db->get('')->row();
    }
    public function get_sumMar11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-11'");
        return $this->db->get('')->row();
    }
    public function get_sumMar12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-12'");
        return $this->db->get('')->row();
    }
    public function get_sumMar13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-13'");
        return $this->db->get('')->row();
    }
    public function get_sumMar14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-14'");
        return $this->db->get('')->row();
    }
    public function get_sumMar15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-15'");
        return $this->db->get('')->row();
    }
    public function get_sumMar16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-16'");
        return $this->db->get('')->row();
    }
    public function get_sumMar17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-17'");
        return $this->db->get('')->row();
    }
    public function get_sumMar18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-18'");
        return $this->db->get('')->row();
    }
    public function get_sumMar19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-19'");
        return $this->db->get('')->row();
    }
    public function get_sumMar20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-20'");
        return $this->db->get('')->row();
    }
    public function get_sumMar21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-21'");
        return $this->db->get('')->row();
    }
    public function get_sumMar22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-22'");
        return $this->db->get('')->row();
    }
    public function get_sumMar23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-23'");
        return $this->db->get('')->row();
    }
    public function get_sumMar24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-24'");
        return $this->db->get('')->row();
    }
    public function get_sumMar25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-25'");
        return $this->db->get('')->row();
    }
    public function get_sumMar26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-26'");
        return $this->db->get('')->row();
    }
    public function get_sumMar27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-27'");
        return $this->db->get('')->row();
    }
    public function get_sumMar28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-28'");
        return $this->db->get('')->row();
    }
    public function get_sumMar29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-29'");
        return $this->db->get('')->row();
    }
    public function get_sumMar30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-30'");
        return $this->db->get('')->row();
    }
    public function get_sumMar31()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-03-31'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaMar1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-30'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaMar31()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-03-31'");
        return $this->db->get('')->row();
    }
}
