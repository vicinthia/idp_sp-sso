<?php

class Kamar_model extends CI_Model
{
    public function getAllProduk($id = null)
    {
        if ($id === null) {
            return $this->db->get('kategori_kamar')->result_array();
        } else {
            return $this->db->get_where('kategori_kamar', ['id' => $id])->result_array();
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('kategori_kamar', ['id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('kategori_kamar', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('kategori_kamar', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
