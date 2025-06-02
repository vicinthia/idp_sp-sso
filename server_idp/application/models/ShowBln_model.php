<?php

class ShowBln_model extends CI_Model
{
    public function getAllProduk($tgl = null)
    {
        if ($tgl === null) {
            return $this->db->get('transaksi')->result_array();
            // return $this->db->query('SELECT (tgl), SUM(total) FROM `transaksi` WHERE tgl LIKE '%2023-08-01%'')->result_array();
        } else {
            // return $this->db->get_where('transaksi', ['id' => $id])->result_array();
            // return $this->db->query("SELECT (tgl), SUM(total) FROM `transaksi` WHERE tgl LIKE '%$tgl%'")->result_array();
            // return $this->db->query("SELECT SUM(total), DAY(tgl) FROM transaksi WHERE tgl LIKE '%$tgl%' GROUP BY DAY(tgl)")->result_array(); //SUM PENDAPATAN HARIAN DALAM 1 BULAN
            return $this->db->query("SELECT * FROM `transaksi` WHERE tgl LIKE '%$tgl%'")->result_array();
           
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('transaksi', ['id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('transaksi', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('transaksi', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
