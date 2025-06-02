<?php

class revokeToken_model extends CI_Model
{
    public function getAllProduk($id = null)
    {
        if ($id === null) {
            return $this->db->get('users')->result_array();
           
        } else {
            return $this->db->get_where('users', ['id' => $id])->result_array();
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

    public function insert_id($data) {
        // Insert data ke tabel registrasi
        $this->db->insert('users', $data);
        
        // Mendapatkan user_id yang baru saja di-insert
        return $this->db->insert_id();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('users', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
    
}
