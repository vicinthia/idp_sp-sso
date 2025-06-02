<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Jun extends CI_Model
{
    public function get_sumJun1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-01'");
        return $this->db->get('')->row();
    }
    public function get_sumJun2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-02'");
        return $this->db->get('')->row();
    }
    public function get_sumJun3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-03'");
        return $this->db->get('')->row();
    }
    public function get_sumJun4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-04'");
        return $this->db->get('')->row();
    }
    public function get_sumJun5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-05'");
        return $this->db->get('')->row();
    }
    public function get_sumJun6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-06'");
        return $this->db->get('')->row();
    }
    public function get_sumJun7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-07'");
        return $this->db->get('')->row();
    }
    public function get_sumJun8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-08'");
        return $this->db->get('')->row();
    }
    public function get_sumJun9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-09'");
        return $this->db->get('')->row();
    }
    public function get_sumJun10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-10'");
        return $this->db->get('')->row();
    }
    public function get_sumJun11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-11'");
        return $this->db->get('')->row();
    }
    public function get_sumJun12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-12'");
        return $this->db->get('')->row();
    }
    public function get_sumJun13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-13'");
        return $this->db->get('')->row();
    }
    public function get_sumJun14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-14'");
        return $this->db->get('')->row();
    }
    public function get_sumJun15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-15'");
        return $this->db->get('')->row();
    }
    public function get_sumJun16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-16'");
        return $this->db->get('')->row();
    }
    public function get_sumJun17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-17'");
        return $this->db->get('')->row();
    }
    public function get_sumJun18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-18'");
        return $this->db->get('')->row();
    }
    public function get_sumJun19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-19'");
        return $this->db->get('')->row();
    }
    public function get_sumJun20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-20'");
        return $this->db->get('')->row();
    }
    public function get_sumJun21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-21'");
        return $this->db->get('')->row();
    }
    public function get_sumJun22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-22'");
        return $this->db->get('')->row();
    }
    public function get_sumJun23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-23'");
        return $this->db->get('')->row();
    }
    public function get_sumJun24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-24'");
        return $this->db->get('')->row();
    }
    public function get_sumJun25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-25'");
        return $this->db->get('')->row();
    }
    public function get_sumJun26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-26'");
        return $this->db->get('')->row();
    }
    public function get_sumJun27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-27'");
        return $this->db->get('')->row();
    }
    public function get_sumJun28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-28'");
        return $this->db->get('')->row();
    }
    public function get_sumJun29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-29'");
        return $this->db->get('')->row();
    }
    public function get_sumJun30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2023-06-30'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaJun1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaJun30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2023-06-30'");
        return $this->db->get('')->row();
    }
}
