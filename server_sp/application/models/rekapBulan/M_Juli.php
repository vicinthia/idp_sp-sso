<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Juli extends CI_Model
{
    public function get_sumJul1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-01'");
        return $this->db->get('')->row();
    }
    public function get_sumJul2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-02'");
        return $this->db->get('')->row();
    }
    public function get_sumJul3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-03'");
        return $this->db->get('')->row();
    }
    public function get_sumJul4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-04'");
        return $this->db->get('')->row();
    }
    public function get_sumJul5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-05'");
        return $this->db->get('')->row();
    }
    public function get_sumJul6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-06'");
        return $this->db->get('')->row();
    }
    public function get_sumJul7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-07'");
        return $this->db->get('')->row();
    }
    public function get_sumJul8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-08'");
        return $this->db->get('')->row();
    }
    public function get_sumJul9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-09'");
        return $this->db->get('')->row();
    }
    public function get_sumJul10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-10'");
        return $this->db->get('')->row();
    }
    public function get_sumJul11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-11'");
        return $this->db->get('')->row();
    }
    public function get_sumJul12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-12'");
        return $this->db->get('')->row();
    }
    public function get_sumJul13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-13'");
        return $this->db->get('')->row();
    }
    public function get_sumJul14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-14'");
        return $this->db->get('')->row();
    }
    public function get_sumJul15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-15'");
        return $this->db->get('')->row();
    }
    public function get_sumJul16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-16'");
        return $this->db->get('')->row();
    }
    public function get_sumJul17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-17'");
        return $this->db->get('')->row();
    }
    public function get_sumJul18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-18'");
        return $this->db->get('')->row();
    }
    public function get_sumJul19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-19'");
        return $this->db->get('')->row();
    }
    public function get_sumJul20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-20'");
        return $this->db->get('')->row();
    }
    public function get_sumJul21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-21'");
        return $this->db->get('')->row();
    }
    public function get_sumJul22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-22'");
        return $this->db->get('')->row();
    }
    public function get_sumJul23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-23'");
        return $this->db->get('')->row();
    }
    public function get_sumJul24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-24'");
        return $this->db->get('')->row();
    }
    public function get_sumJul25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-25'");
        return $this->db->get('')->row();
    }
    public function get_sumJul26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-26'");
        return $this->db->get('')->row();
    }
    public function get_sumJul27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-27'");
        return $this->db->get('')->row();
    }
    public function get_sumJul28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-28'");
        return $this->db->get('')->row();
    }
    public function get_sumJul29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-29'");
        return $this->db->get('')->row();
    }
    public function get_sumJul30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-30'");
        return $this->db->get('')->row();
    }
    public function get_sumJul31()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-07-31'");
        return $this->db->get('')->row();
    }



    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaJul1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-30'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJul31()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-07-31'");
        return $this->db->get('')->row();
    }
}
