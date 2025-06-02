<?php
defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';

class statusUser extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_model', 'kamar');
    }
    public function index_get()
    {
        $data['judul'] = 'Daftar Transaksi';
        $id = $this->get('id');

        if ($id === null) {
            $masterku = $this->kamar->getAllProduk();
        } else {
            $masterku = $this->kamar->getAllProduk($id);
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
            if ($this->kamar->deleteProduk($id) > 0) {
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
            'user' => $this->post('user'),
            'jurusan' => $this->post('jurusan'),
            // 'user_id' => $this->post('user_id'),
            // 'status' => $this->post('status'),
        ];

        if ($this->kamar->createProduk($data) > 0) {
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
            'user' => $this->put('user'),
            'jurusan' => $this->put('jurusan'),
            // 'user_id' => $this->post('user_id'),
            // 'status' => $this->post('status'),

        ];

        if ($this->kamar->updateProduk($data, $id) > 0) {
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
