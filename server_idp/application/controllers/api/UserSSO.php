<?php

defined('BASEPATH') OR exit('No direct script access allowed');

// require APPPATH . 'libraries/REST_Controller.php';

class UserSSO extends CI_Controller
{
  
    public function login() {
        $this->load->database();
        $this->load->library('jwt');
    
        $username = $this->input->post("email");
        $password = $this->input->post("password");
    
        // Validasi input
        if (empty($username) || empty($password)) {
            echo json_encode(array('message' => 'Email and Password are required'));
            return;
        }
    
        // Pengecekan pengguna
        $query = $this->db->query("SELECT * FROM users WHERE email = ? AND password = ?", array($username, $password));
    
        if ($query->num_rows() > 0) {
            $userData = $query->row_array();
            
            // Buat token JWT dengan data pengguna
            $JwtSecretkey = "Mysecret";
            $tokenData = array(
                "iat" => time(), // waktu token dibuat
                "exp" => time() + 900, // waktu token kedaluwarsa (15 menit)
                "data" => array(
                    'id' => $userData['id'],
                    'name' => $userData['name'],
                    'email' => $userData['email'],
                    'level' => $userData['level'],
                    'jurusan' => $userData['jurusan'],
                    'no_induk' => $userData['no_induk'],
                    'refresh_token' => $userData['refresh_token'],
                    'status' => $userData['status']
                )
            );

            $refreshTokenData = array(
                "iat" => time(),
                "exp" => time() + 604800, // waktu token kedaluwarsa (7 hari)
                "data" => array(
                    'id' => $userData['id']
                )
            );

            // Encode token menggunakan JWT dan secret key
            $token = $this->jwt->encode($tokenData, $JwtSecretkey, 'HS256');
           
   

            // Buat respons JSON
            $response = array(
                'user' => $userData,
                'token' => $token,
               
            );
    
            echo json_encode($response);
        } else {
            // User tidak ditemukan
            echo json_encode(array('message' => 'Invalid email or password'));
        }
    }


    public function create_refresh() {
        $this->load->database();
        $this->load->library('jwt');
    
        $id = $this->input->post("id");
        $time_refresh = $this->input->post("time_refresh");
  
    
        // Validasi input
        if (empty($id)) {
            echo json_encode(array('message' => 'Email and Password are required'));
            return;
        }
        $JwtSecretkey = "Mysecret";
        // Validasi refresh token
        $query = $this->db->query("SELECT * FROM users WHERE id = ?", array($id));
        if ($query->num_rows() > 0) {
            $userData = $query->row_array();
    

            $newCreateData = array(
                "iat" => time(),
                "exp" => time() + 604800, // waktu refresh token lebih banyak drpd access token agar lebih aman 
                "data" => array(
                    'id' => $userData['id']
                    
                )
            );
            $newCreate = $this->jwt->encode($newCreateData, $JwtSecretkey, 'HS256');

            $this->db->update('users', array('refresh_token' => $newCreate, 'time_refresh' => $time_refresh), array('id' => $userData['id']));
            

            $response = array(
                'newCreate' => $newCreate,
                'time_refresh' => $time_refresh
            );
            echo json_encode($response);
        } else {
            echo json_encode(array('message' => 'Invalid refresh token'));
        }
    }


    public function refresh_token() {
        $this->load->database();
        $this->load->library('jwt');
    
        $refreshToken = $this->input->post("refresh_token");
      

        if (empty($refreshToken)) {
            echo json_encode(array('message' => 'Refresh token is required'));
            return;
        }
    
        // Validasi refresh token
        $query = $this->db->query("SELECT * FROM users WHERE refresh_token = ?", array($refreshToken));
        if ($query->num_rows() > 0) {
            $userData = $query->row_array();
    
            // Buat token JWT baru dengan data pengguna
            $JwtSecretkey = "Mysecret";
            $tokenData = array(
                "iat" => time(),
                "exp" => time() + 900, // waktu token kedaluwarsa dalam 15 menit
                "data" => array(
                    'id' => $userData['id'],
                    'name' => $userData['name'],
                    'email' => $userData['email'],
                    'level' => $userData['level'],
                    'jurusan' => $userData['jurusan'],
                    'no_induk' => $userData['no_induk'],
                    'refresh_token' => $userData['refresh_token'],
                    'status' => $userData['status']
                )
            );
    
            $newToken = $this->jwt->encode($tokenData, $JwtSecretkey, 'HS256');

            $response = array(
                'user' => $userData,
                'newtoken' => $newToken,
            );
            echo json_encode($response);
        } else {
            echo json_encode(array('message' => 'Invalid refresh token'));
        }
    }
    
}


