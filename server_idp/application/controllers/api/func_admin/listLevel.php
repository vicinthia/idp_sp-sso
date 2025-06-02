<?php
defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';

class listLevel extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('modelAdmin/listMhs_model', 'ticket');
    }
    public function index_get()
    {
        $data['judul'] = 'Daftar Transaksi';
        $level = $this->get('level');

        if ($level === null) {
            $masterku = $this->ticket->getAllProduk();
        } else {
            $masterku = $this->ticket->getAllProduk($level);
        }

        if ($masterku) {
            $this->response([
                'status' => TRUE,
                'data' => $masterku
            ], REST_Controller::HTTP_OK);
        } else {
            $this->response([
                'status' => FALSE,
                'message' => 'id not found'
            ], REST_Controller::HTTP_NOT_FOUND);
        }
        $this->load->view('home', $masterku);
    }


    public function index_delete()
    {
        $id = $this->delete('id');

        if ($id === null) {
            $this->response([
                'status' => FALSE,
                'message' => 'provide an id'
            ], REST_Controller::HTTP_BAD_REQUEST);
        } else {
            if ($this->ticket->deleteProduk($id) > 0) {
                // ok
                $this->response([
                    'status' => TRUE,
                    'id' => $id,
                    'message' => 'deleted'
                ], REST_Controller::HTTP_NO_CONTENT);
            } else {
                // id not found
                $this->response([
                    'status' => FALSE,
                    'message' => 'id not found'
                ], REST_Controller::HTTP_NOT_FOUND);
            }
        }
    }

    public function index_post()
    {
        $data = [
            'id' => $this->post('id'),
            'name' => $this->post('name'),
            'email' => $this->post('email'),
            'password' => $this->post('password'),
            'level' => $this->post('level'),
            'no_induk' => $this->post('no_induk'),
            'jurusan' => $this->post('jurusan'),
            'no_telp' => $this->post('no_telp'),
            'created_at' => $this->post('created_at'),
          
            // 'user_id' => $this->post('user_id'),
            // 'status' => $this->post('status'),
        ];

        if ($this->ticket->createProduk($data) > 0) {
            $this->response([
                'status' => TRUE,
                'message' => 'new produk has been created'
            ], REST_Controller::HTTP_CREATED);
        } else {
            $this->response([
                'status' => FALSE,
                'message' => 'failed to created new data'
            ], REST_Controller::HTTP_BAD_REQUEST);
        }
    }

    public function index_put()
    {
        $id = $this->put('id');

        $data = [
            'id' => $this->put('id'),
            'name' => $this->put('name'),
            'email' => $this->put('email'),
            'no_induk' => $this->put('no_induk'),
            'no_telp' => $this->put('no_telp'),
            // 'user_id' => $this->put('user_id'),
            // 'status' => $this->put('status'),
        ];

        if ($this->ticket->updateProduk($data, $id) > 0) {
            $this->response([
                'status' => TRUE,
                'message' => 'data produk has been updated'
            ], REST_Controller::HTTP_NO_CONTENT);
        } else {
            $this->response([
                'status' => FALSE,
                'message' => 'failed to update data'
            ], REST_Controller::HTTP_BAD_REQUEST);
        }
    }
}
