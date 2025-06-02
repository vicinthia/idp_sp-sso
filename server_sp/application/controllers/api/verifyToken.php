<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class verifyToken extends CI_Controller {

    public function verify_token() {
        
        $jwtToken = $this->input->get_request_header('Authorization');
        $jwtToken = str_replace('Bearer ', '', $jwtToken);

        // Dekode JWT (gunakan library yang sesuai untuk decode JWT)
        $decodedToken = $this->decode_jwt($jwtToken);

        if ($decodedToken) {
            // Data user yang didapat dari JWT
            $userData = array(
                'iat' => date('Y-m-d H:i:s', $decodedToken->iat),
                'exp' => date('Y-m-d H:i:s', $decodedToken->exp),
               
                // 'id' => $decodedToken->data->id,
                'name' => $decodedToken->data->name,
                'email' => $decodedToken->data->email,
                'level' => $decodedToken->data->level,
                'jurusan' => $decodedToken->data->jurusan,
                'no_induk' => $decodedToken->data->no_induk,
                    // 'refresh_token' => $decodedToken->data->refresh_token,
                    // 'status' => $decodedToken->data->status
            
                // 'user_id' => $decodedToken->sub,
                // 'name' => $decodedToken->name,
                // 'email' => $decodedToken->email,
               
            );

            // Panggil model untuk menyimpan data ke database
            $this->load->model('verifySP_model');
            $this->verifySP_model->saveUserToDatabase($userData);

            // Berikan respon sukses
            $this->output
                ->set_content_type('application/json')
                ->set_output(json_encode(array('status' => 'success', 'message' => 'User data saved successfully')));
        } else {
            // Token tidak valid atau expired
            $this->output
                ->set_content_type('application/json')
                ->set_output(json_encode(array('status' => 'error', 'message' => 'Invalid token')));
        }
    }
    private function decode_jwt($jwt) {
        $this->load->helper('jwt_helper');
        try {
            $decoded = JWT::decode($jwt, 'Mysecret', array('HS256'));
            print_r($decoded);
            return $decoded;
            
        } catch (Exception $e) {
            return false;
        }
    }

   
   
}
