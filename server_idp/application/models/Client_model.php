<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Client_model extends CI_Model {

    public function is_client_registered($user_id) {
        $this->db->select('user_id');
        $this->db->from('sso_clients'); // Sesuaikan nama table user Anda
        $this->db->where('user_id', $user_id);
        $query = $this->db->get();

        return $query->num_rows() > 0;
    }
}