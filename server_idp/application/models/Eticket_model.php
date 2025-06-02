<?php

class Eticket_model extends CI_Model
{
    public function getAllProduk($id = null)
    {
        if ($id === null) {
            return $this->db->get('transaksi')->result_array();
        } else {
            return $this->db->get_where('transaksi', ['id_transaksi' => $id])->result_array();
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('transaksi', ['id_transaksi' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('transaksi', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('transaksi', $data, ['id_transaksi' => $id]);
        return $this->db->affected_rows();
    }





    public function getJan($tgl_awal = '2022-01-01', $tgl_akhir = '2022-01-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }
    public function getFeb($tgl_awal = '2022-02-01', $tgl_akhir = '2022-02-28')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }
    public function getMar($tgl_awal = '2022-03-01', $tgl_akhir = '2022-03-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }
    public function getApr($tgl_awal = '2022-04-01', $tgl_akhir = '2022-04-30')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }
    public function getMei($tgl_awal = '2022-05-01', $tgl_akhir = '2022-05-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getJun($tgl_awal = '2022-06-01', $tgl_akhir = '2022-06-30')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getJul($tgl_awal = '2022-07-01', $tgl_akhir = '2022-07-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getAug($tgl_awal = '2022-08-01', $tgl_akhir = '2022-08-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getSep($tgl_awal = '2022-09-01', $tgl_akhir = '2022-09-30')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getOct($tgl_awal = '2022-10-01', $tgl_akhir = '2022-10-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getNov($tgl_awal = '2022-11-01', $tgl_akhir = '2022-11-30')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }

    public function getDec($tgl_awal = '2022-12-01', $tgl_akhir = '2022-12-31')
    {
        $this->db->select('*');
        $this->db->from('transaksi');
        $this->db->where('tgl >=', $tgl_awal);
        $this->db->where('tgl <=', $tgl_akhir);
        return $this->db->get()->result();
    }
}
