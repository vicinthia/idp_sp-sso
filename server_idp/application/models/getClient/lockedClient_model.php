<?php

class lockedClient_model extends CI_Model
{
    public function getAllProduk($user_id = null)
    {
        if ($user_id === null) {
            return $this->db->get('sso_clients')->result_array();
        } else {
            // return $this->db->get_where('sso_clients', ['user_id' => $user_id])->result_array();
            return $this->db->query("SELECT * FROM `sso_clients` WHERE user_id LIKE '%$user_id%'")->result_array();

            // CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, user_id)))
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('sso_clients', ['user_id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('sso_clients', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id, $client_id)
    {
        $this->db->update('sso_clients', $data, ['user_id' => $id, 'client_id' => $client_id]);
        return $this->db->affected_rows();
    }
}
