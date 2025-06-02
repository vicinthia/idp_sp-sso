<?php

class UserLogin_model extends CI_Model
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

    public function updateProduk($data, $id)
    {
        $this->db->update('users', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
