<?php

class User_model extends CI_Model
{
    public function getAllProduk($id = null)
    {
        if ($id === null) {
            return $this->db->get('status_user')->result_array();
        } else {
            return $this->db->get_where('status_user', ['id' => $id])->result_array();
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('status_user', ['id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('status_user', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('status_user', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
