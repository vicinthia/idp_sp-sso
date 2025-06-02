<?php
defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';

class Link extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Link_model', 'transaksi');
    }
    public function index_get()
    {
        $data['judul'] = 'Daftar Transaksi';
        $link = $this->get('password');

        if ($link === null) {
            $masterku = $this->transaksi->getAllProduk();
        } else {
            $masterku = $this->transaksi->getAllProduk($link);
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
            'id' => $this->post('id'),
            'username' => $this->post('username'),
            'password' => $this->post('password'),
	    'alamat_objek' => $this->post('alamat_objek'),
	    'besar_pajak' => $this->post('besar_pajak'),

            'nama_objek' => $this->post('nama_objek'),
            'link' => $this->post('link'),
          
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
        $id = $this->put('id');

        $data = [
            'id' => $this->put('id'),
            'username' => $this->put('username'),
            'password' => $this->put('password'),
 	    'alamat_objek' => $this->put('alamat_objek'),
	    'besar_pajak' => $this->put('besar_pajak'),

            'nama_objek' => $this->put('nama_objek'),
            'link' => $this->put('link'),
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
