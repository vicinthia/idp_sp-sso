<?php

class Transaksi_model extends CI_Model
{
    public function getAllProduk($id = null)
    {
        if ($id === null) {
            return $this->db->get('transaksi')->result_array();
        } else {
            return $this->db->get_where('transaksi', ['id_transaksi' => $id])->result_array();
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
