<?php

class ShowTransaksi_model extends CI_Model
{
    public function getAllProduk($tgl = null)
    {
        if ($tgl === null) {
            return $this->db->get('transaksi')->result_array();
        } else {
            // return $this->db->get_where('transaksi', ['tgl' => $tgl])->result_array();
            return $this->db->query("SELECT * FROM `transaksi` WHERE tgl LIKE '%$tgl%'")->result_array();

            // CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, tgl)))
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('transaksi', ['id_transaksi' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('transaksi', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('transaksi', $data, ['id_transaksi' => $id]);
        return $this->db->affected_rows();
    }
}
