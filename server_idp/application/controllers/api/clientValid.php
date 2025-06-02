<?php

class clientValid extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Client_model'); // Load model User_model
    }


    public function check_client() {
        $user_id = trim($this->input->post('user_id'));
        $user_id = strtolower($user_id); // Assuming case-sensitive storage
    
        $is_registered = $this->Client_model->is_client_registered($user_id);
    
        if ($is_registered) {
            echo json_encode(array('status' => false, 'message' => 'Client is already registered'));
        } else {
            echo json_encode(array('status' => true, 'message' => 'Client is available'));
        }
    }


}

