<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class auth_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function login($username, $password) {
        // Query database untuk memeriksa kredensial pengguna
        $query = $this->db->get_where('users', array('email' => $username, 'password' => md5($password)));

        if ($query->num_rows() == 1) {
            return $query->row();
        } else {
            return false;
        }
    }
}
