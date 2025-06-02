<?php
defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';

class getListClient extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('getClient/getClient_model', 'transaksi');
    }
    public function index_get()
    {
        $data['judul'] = 'Daftar Transaksi';
        $user_id = $this->get('user_id');

        if ($user_id === null) {
            $masterku = $this->transaksi->getAllProduk();
        } else {
            $masterku = $this->transaksi->getAllProduk($user_id);
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
        $id = $this->delete('user_id');

        if ($id === null) {
            $this->response([
                'status' => FALSE,
                'message' => 'provide an id'
            ], REST_Controller::HTTP_BAD_REQUEST);
        } else {
            if ($this->transaksi->deleteProduk($id) > 0) {
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
            'client_id' => $this->post('client_id'),
            'user_id' => $this->post('user_id'),
            'user_status' => $this->post('user_status'),
            'name_client' => $this->post('name_client'),
            'client_secret' => $this->post('client_secret'),
            'create_at' => $this->post('create_at'),
            'image' => $this->post('image'),
           
        ];

        if ($this->transaksi->createProduk($data) > 0) {
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
        $id = $this->put('user_id');

        $data = [
            'client_id' => $this->put('client_id'),
            'user_id' => $this->put('user_id'),
            'user_status' => $this->put('user_status'),
            'name_client' => $this->put('name_client'),
            'client_secret' => $this->put('client_secret'),
            'create_at' => $this->put('create_at'),
            'image' => $this->put('image'),
        ];

        if ($this->transaksi->updateProduk($data, $id) > 0) {
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
