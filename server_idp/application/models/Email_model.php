<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Email_model extends CI_Model {

    public function is_email_registered($email) {
        $this->db->select('email');
        $this->db->from('users'); // Sesuaikan nama table user Anda
        $this->db->where('email', $email);
        $query = $this->db->get();

        return $query->num_rows() > 0;
    }
}