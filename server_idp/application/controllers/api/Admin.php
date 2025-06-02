<?php

defined('BASEPATH') OR exit('No direct script access allowed');

// require APPPATH . 'libraries/REST_Controller.php';

class Admin extends CI_Controller
{
    public function myLogin() {
      
        $username = $this->input->post("username");
        $password = $this->input->post("password");

        $dataAdmin = array();

        $dataLogin = $this->db->query("SELECT * FROM admin WHERE username = '".$username."' and password = '".$password."'");


        foreach($dataLogin->result() as $dl) {
            $dataAdmin[] = $dl;
        }

     echo json_encode($dataAdmin);
        
     }
}