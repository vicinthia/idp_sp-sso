<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class verifySP_model extends CI_Model {

    // Fungsi untuk menyimpan data user ke database
    public function saveUserToDatabase($userData) {
        // Cek apakah user sudah ada berdasarkan user ID atau email
        $this->db->where('email', $userData['email']);
        $query = $this->db->get('users');

        if ($query->num_rows() > 0) {
            // Jika user sudah ada, bisa melakukan update data
            $this->db->where('email', $userData['email']);
            $this->db->update('users', $userData);
        } else {
            // Jika user belum ada, insert data baru
            $this->db->insert('users', $userData);
        }
    }
}
