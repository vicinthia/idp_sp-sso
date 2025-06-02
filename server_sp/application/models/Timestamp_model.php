<?php

class Timestamp_model extends CI_Model
{
    public function getAllProduk($id = null)
    {
        if ($id === null) {
            return $this->db->get('koneksi_apk')->result_array();
        } else {
            return $this->db->get_where('koneksi_apk', ['id' => $id])->result_array();
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('koneksi_apk', ['id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('koneksi_apk', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('koneksi_apk', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
