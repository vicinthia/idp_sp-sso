<?php
defined('BASEPATH') or exit('No direct script access allowed');


class M_Aug extends CI_Model
{
    public function get_sumAug1()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-01'");
        return $this->db->get('')->row();
    }
    public function get_sumAug2()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-02'");
        return $this->db->get('')->row();
    }
    public function get_sumAug3()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-03'");
        return $this->db->get('')->row();
    }
    public function get_sumAug4()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-04'");
        return $this->db->get('')->row();
    }
    public function get_sumAug5()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-05'");
        return $this->db->get('')->row();
    }
    public function get_sumAug6()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-06'");
        return $this->db->get('')->row();
    }
    public function get_sumAug7()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-08'");
        return $this->db->get('')->row();
    }
    public function get_sumAug8()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-08'");
        return $this->db->get('')->row();
    }
    public function get_sumAug9()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-09'");
        return $this->db->get('')->row();
    }
    public function get_sumAug10()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-10'");
        return $this->db->get('')->row();
    }
    public function get_sumAug11()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-11'");
        return $this->db->get('')->row();
    }
    public function get_sumAug12()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-12'");
        return $this->db->get('')->row();
    }
    public function get_sumAug13()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-13'");
        return $this->db->get('')->row();
    }
    public function get_sumAug14()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-14'");
        return $this->db->get('')->row();
    }
    public function get_sumAug15()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-15'");
        return $this->db->get('')->row();
    }
    public function get_sumAug16()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-16'");
        return $this->db->get('')->row();
    }
    public function get_sumAug17()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-17'");
        return $this->db->get('')->row();
    }
    public function get_sumAug18()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-18'");
        return $this->db->get('')->row();
    }
    public function get_sumAug19()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-19'");
        return $this->db->get('')->row();
    }
    public function get_sumAug20()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-20'");
        return $this->db->get('')->row();
    }
    public function get_sumAug21()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-21'");
        return $this->db->get('')->row();
    }
    public function get_sumAug22()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-22'");
        return $this->db->get('')->row();
    }
    public function get_sumAug23()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-23'");
        return $this->db->get('')->row();
    }
    public function get_sumAug24()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-24'");
        return $this->db->get('')->row();
    }
    public function get_sumAug25()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-25'");
        return $this->db->get('')->row();
    }
    public function get_sumAug26()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-26'");
        return $this->db->get('')->row();
    }
    public function get_sumAug27()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-27'");
        return $this->db->get('')->row();
    }
    public function get_sumAug28()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-28'");
        return $this->db->get('')->row();
    }
    public function get_sumAug29()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-29'");
        return $this->db->get('')->row();
    }
    public function get_sumAug30()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-30'");
        return $this->db->get('')->row();
    }
    public function get_sumAug31()
    {
        $this->db->select_sum('total');
        $this->db->from("transaksi where date (tgl) = '2022-08-31'");
        return $this->db->get('')->row();
    }


    //////////////// TICKET TERJUAL //////////////////
    public function get_sum_mejaAug1()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-01'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug2()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-02'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug3()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-03'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug4()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-04'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug5()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-05'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug6()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-06'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug7()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-07'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug8()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-08'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug9()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-09'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug10()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-10'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug11()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-11'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug12()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-12'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug13()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-13'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug14()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-14'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug15()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-15'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug16()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-16'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug17()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-17'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug18()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-18'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug19()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-19'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug20()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-20'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug21()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-21'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug22()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-22'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug23()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-23'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug24()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-24'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug25()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-25'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug26()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-26'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug27()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-27'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug28()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-28'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug29()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-29'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug30()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-30'");
        return $this->db->get('')->row();
    }
    public function get_sum_mejaAug31()
    {
        $this->db->select_sum('meja');
        $this->db->from("transaksi where date (tgl) = '2022-08-31'");
        return $this->db->get('')->row();
    }
}
