<?php

class clientLevel_model extends CI_Model
{
    public function getAllProduk($level = null, $jurusan = null)
    {
        if ($level === null && $jurusan === null) {
            return $this->db->get('users')->result_array();
        } else {
          
            return $this->db->query("SELECT * FROM `users` WHERE level LIKE '%$level%' && jurusan LIKE '%$jurusan%'")->result_array();
           
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('users', ['id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('users', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('users', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
