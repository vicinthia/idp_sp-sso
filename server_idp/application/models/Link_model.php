<?php

class Link_model extends CI_Model
{
    public function getAllProduk($link = null)
    {
        if ($link === null) {
            return $this->db->get('master_linktiket')->result_array();
            // return $this->db->query('SELECT (tgl), SUM(total) FROM `master_linkhotel` WHERE tgl LIKE '%2023-08-01%'')->result_array();
        } else {
          
            return $this->db->query("SELECT * FROM `master_linkhotel` WHERE password LIKE '%$link%'")->result_array();
           
        }
    }

    public function deleteProduk($id)
    {
        $this->db->delete('master_linktiket', ['id' => $id]);
        return $this->db->affected_rows();
    }

    public function createProduk($data)
    {
        $this->db->insert('master_linktiket', $data);
        return $this->db->affected_rows();
    }

    public function updateProduk($data, $id)
    {
        $this->db->update('master_linktiket', $data, ['id' => $id]);
        return $this->db->affected_rows();
    }
}
