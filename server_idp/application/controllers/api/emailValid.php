<?php

class emailValid extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Email_model'); // Load model User_model
    }


    public function check_email() {
        $email = trim($this->input->post('email'));
        $email = strtolower($email); // Assuming case-sensitive storage
    
        $is_registered = $this->Email_model->is_email_registered($email);
    
        if ($is_registered) {
            echo json_encode(array('status' => false, 'message' => 'Email is already registered'));
        } else {
            echo json_encode(array('status' => true, 'message' => 'Email is available'));
        }
    }


}

