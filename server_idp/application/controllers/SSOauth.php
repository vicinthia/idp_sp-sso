<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class SSOauth extends CI_Controller {

    public function index() {
      echo 'Auth Controller';
    }

    // public function __construct() {
    //     parent::__construct();
    //     $this->load->database();
    // }

    public function tokens() {
        $this->load->database();

        $username = $this->input->post('email');
        $password = $this->input->post('password');

        $jwt = new JWT();
        $this->load->library('jwt');
  

        $JwtSecretkey = "Mysecret";
      
        $query = $this->db->get_where('users', array('email' => $username));


    if ($query->num_rows() > 0) {
        $userData = $query->row_array();
        
        // Buat token dengan data user
        $tokenDA = array(
            "iat" => time(), // waktu token dibuat
            "exp" => time() + 60, // waktu token kedaluwarsa (1 jam)
            "data" => array(
                'id' => $userData['id'],
                'email' => $userData['email'],
                'level' => $userData['level']
            )
        );

        // Encode token menggunakan JWT dan secret key
        $token = $this->jwt->encode($tokenDA, $JwtSecretkey, 'HS256');
        echo $token;

      
    } else {
        // User tidak ditemukan
        echo json_encode(array('message' => 'User not found'));
    }
    
    }

    // public function decode_token(){
    //     $token = $this->uri->segment(3);

    //     $jwt = new JWT();

    //     $JwtSecretkey = "Mysecret";

    //     $decode_token = $jwt->decode($token,$JwtSecretkey,'HS256');

    //     // this will return
    //    $token1 = $jwt->jsonEncode($decode_token);
    //    echo $token1;
    // }
    public function decode_token(){
        $token = $this->uri->segment(3);

        if (!$token) {
            // Handle missing token (e.g., return error message)
            echo json_encode(array('status' => false, 'message' => 'Missing token'));
            exit;
        }
    

        $jwt = new JWT();

        $JwtSecretkey = "Mysecret";

      

        // this will return
       
        try {
            $decoded_token = $jwt->decode($token,$JwtSecretkey,'HS256');
    
            // Verify expiration
            $exp = $decoded_token->exp; // Assuming 'exp' is the claim for expiration time
            if ($exp <= time()) {
                echo json_encode(array('status' => false, 'message' => 'Token is expired'));
                exit;
            }
    
            // Success response with decoded data
            echo json_encode(array('status' => true, 'massage' => $decoded_token));
    
        } catch (Exception $e) {
            echo json_encode(array('status' => false, 'message' => 'Error decoding token: ' . $e->getMessage()));
            exit;
        }
    }

 

    public function validate_token() {
        $token = $this->input->get_request_header('Authorization'); // Assuming token is in headers
    
        if (!$token) {
            // Handle missing token (e.g., return error message)
            echo json_encode(array('error' => 'Missing token'));
            exit;
        }
    
        $token = str_replace('Bearer ', '', $token); // Remove "Bearer " prefix
    
        $jwt = new JWT(); // Assuming you have included the JWT library
        $JwtSecretKey = "Mysecret"; // Replace with your secret key
    
        try {
            $decoded_data = $jwt->decode($token, $JwtSecretKey, 'HS256');
    
            // Verify expiration
            $exp = $decoded_data->exp; // Assuming 'exp' is the claim for expiration time
            if ($exp <= time()) {
                echo json_encode(array('error' => 'Token is expired'));
                exit;
            }
    
            // Success response with decoded data
            echo json_encode(array('data' => $decoded_data));
    
        } catch (Exception $e) {
            echo json_encode(array('error' => 'Error decoding token: ' . $e->getMessage()));
            exit;
        }
    }

   

   
}
