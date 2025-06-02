<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class validateSP extends CI_Controller {

    public function index() {
      echo 'Auth Controller';
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
