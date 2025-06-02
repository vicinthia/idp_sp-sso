<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ssoClients extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->database();
        $this->load->model('crudUser_model');
       
    }

    // MAHASISWA //

    public function create_applicationMahasiswa() {
        $name = $this->input->post('name_client');
        $user_id = $this->input->post('user_id');
        // $user_id = $this->crudUser_modell->insert_id($data_registrasi);
        $user_status = $this->input->post('user_status');
        $create_at = $this->input->post('create_at');
        $image = $this->input->post('image');

        if (empty($name)) {
            $this->output
                ->set_status_header(400)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Application name is required')));
            return;
        }

        // ENKRIPSI 1 BUAT CLIENT ID
        function enkripsi($plaintext, $kunci) {
            $ciphertext = "";
            $panjang_teks = strlen($plaintext);
        
            for ($i = 0; $i < $panjang_teks; $i++) {
                // Mendapatkan kode ASCII asli dari karakter
                $kode_ascii_asli = ord($plaintext[$i]);
              
                // Mengenkripsi indeks karakter dengan menggunakan kunci (dengan modulus 93 untuk loop)
                $indeks_terenkripsi = ($kode_ascii_asli  + $kunci) % 93;
                // Mengembalikan karakter terenkripsi dari indeks terenkripsi
                $karakter_terenkripsi = chr(33 + $indeks_terenkripsi);
                // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
                $ciphertext .= $karakter_terenkripsi;
            }
        
            return $ciphertext;
        }

        $kunci = 119;
        $teks_terenkripsi = enkripsi($name, $kunci);

        // ENKRIPSI 2 BUAT CLIENT ID
        function ubahCiphertext($ciphertext, $kunci) {
            // Inisialisasi array dua dimensi untuk menampung chipertext baru
            $array_baris = array();
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array();
            }
        
            $baris_sekarang = 1;
            $turun = true;
        
            // Menyusun ciphertext menjadi pola zig-zag
            $panjang_ciphertext = strlen($ciphertext);
            for ($i = 0; $i < $panjang_ciphertext; $i++) {
                $array_baris[$baris_sekarang][] = $ciphertext[$i];
                if ($baris_sekarang == 1) {
                    $turun = true;
                } elseif ($baris_sekarang == $kunci) {
                    $turun = false;
                }
                if ($turun) {
                    $baris_sekarang++;
                } else {
                    $baris_sekarang--;
                }
            }
        
            // Mengubah urutan karakter dari belakang ke depan dalam setiap baris
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array_reverse($array_baris[$i]);
            }
        
            // Mengambil hasil transposisi per baris sesuai dengan jumlah karakter di baris tersebut
            $chipertext_baru = "";
            for ($i = 1; $i <= $kunci; $i++) {
                foreach ($array_baris[$i] as $karakter) {
                    $chipertext_baru .= $karakter;
                }
            }
        
            return $chipertext_baru;
        }
        
        // Ciphertext yang diberikan
        $ciphertext1 = $teks_terenkripsi;
        $kunci = 3;
        
        // Mengubah ciphertext menjadi chipertext baru
        $chipertext2 = ubahCiphertext($ciphertext1, $kunci);
        
        // Menampilkan hasil chipertext baru
        // echo "Chipertext baru: " . $chipertext2;


        // ENKRIPSI 1 BUAT CLIENT SECRET
        function enkripsiSecret($plainSecret, $kunci) {
            $cipherSecret = "";
            $panjang_teks = strlen($plainSecret);
        
            for ($i = 0; $i < $panjang_teks; $i++) {
                // Mendapatkan kode ASCII asli dari karakter
                $kode_ascii_asli = ord($plainSecret[$i]);
              
                // Mengenkripsi indeks karakter dengan menggunakan kunci (dengan modulus 93 untuk loop)
                $indeks_terenkripsi = ($kode_ascii_asli  + $kunci) % 93;
                // Mengembalikan karakter terenkripsi dari indeks terenkripsi
                $karakter_terenkripsi = chr(33 + $indeks_terenkripsi);
                // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
                $cipherSecret .= $karakter_terenkripsi;
            }
        
            return $cipherSecret;
        }
    
        $kunciSecret = 111;
        $secret_terenkripsi = enkripsiSecret($name, $kunciSecret);
    
        // ENKRIPSI 2 BUAT CLIENT SECRET
        function ubahCipherSecret($cipherSecret, $kunci) {
            // Inisialisasi array dua dimensi untuk menampung chipertext baru
            $array_baris = array();
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array();
            }
        
            $baris_sekarang = 1;
            $turun = true;
        
            // Menyusun cipherSecret menjadi pola zig-zag
            $panjang_cipherSecret = strlen($cipherSecret);
            for ($i = 0; $i < $panjang_cipherSecret; $i++) {
                $array_baris[$baris_sekarang][] = $cipherSecret[$i];
                if ($baris_sekarang == 1) {
                    $turun = true;
                } elseif ($baris_sekarang == $kunci) {
                    $turun = false;
                }
                if ($turun) {
                    $baris_sekarang++;
                } else {
                    $baris_sekarang--;
                }
            }
        
            // Mengubah urutan karakter dari belakang ke depan dalam setiap baris
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array_reverse($array_baris[$i]);
            }
        
            // Mengambil hasil transposisi per baris sesuai dengan jumlah karakter di baris tersebut
            $chipertext_baru = "";
            for ($i = 1; $i <= $kunci; $i++) {
                foreach ($array_baris[$i] as $karakter) {
                    $chipertext_baru .= $karakter;
                }
            }
        
            return $chipertext_baru;
        }
        
        // CipherSecret yang diberikan
        $cipherSecret1 = $secret_terenkripsi;
        $kunciTranposSecret = 3;
        
        // Mengubah cipherSecret menjadi chipertext baru
        $chiperSecret2 = ubahCipherSecret($cipherSecret1, $kunciTranposSecret);
        
        
        
        // Set static Client ID and Client Secret for specific applications
        $clientId = '';
        $clientSecret = '';
        if ($name == 'Sistem Informasi Manajemen') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Lab Teknik Informatika') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Lab Teknik Sipil') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Lab Teknik Elektronika') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Kuliah Kerja Nyata') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Sistem Monitoring Tugas Akhir') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else {
            $this->output
                ->set_status_header(400)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Unknown application name')));
            return;
        }

        // Simpan informasi aplikasi di tabel applications
        $data = array(
            'name_client' => $name,
            'client_id' => $clientId,
            'client_secret' => $clientSecret,
            'user_id' => $user_id,
            'user_status' => $user_status,
            'create_at' => $create_at,
            'image' => $image
        );

        if ($this->db->insert('sso_clients', $data)) {
            $response = array(
                'message' => 'Application created successfully',
                'clientId' => $clientId,
                'clientSecret' => $clientSecret
            );
            $this->output
                ->set_content_type('application/json')
                ->set_output(json_encode($response));
        } else {
            $this->output
                ->set_status_header(500)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Error creating application')));
        }
    }


     // DOSEN //

     public function create_applicationDosen() {
        $name = $this->input->post('name_client');
        $user_id = $this->input->post('user_id');
        // $user_id = $this->crudUser_modell->insert_id($data_registrasi);
        $user_status = $this->input->post('user_status');
        $create_at = $this->input->post('create_at');
        $image = $this->input->post('image');

        if (empty($name)) {
            $this->output
                ->set_status_header(400)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Application name is required')));
            return;
        }

        // ENKRIPSI 1 BUAT CLIENT ID
        function enkripsi($plaintext, $kunci) {
            $ciphertext = "";
            $panjang_teks = strlen($plaintext);
        
            for ($i = 0; $i < $panjang_teks; $i++) {
                // Mendapatkan kode ASCII asli dari karakter
                $kode_ascii_asli = ord($plaintext[$i]);
              
                // Mengenkripsi indeks karakter dengan menggunakan kunci (dengan modulus 93 untuk loop)
                $indeks_terenkripsi = ($kode_ascii_asli  + $kunci) % 93;
                // Mengembalikan karakter terenkripsi dari indeks terenkripsi
                $karakter_terenkripsi = chr(33 + $indeks_terenkripsi);
                // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
                $ciphertext .= $karakter_terenkripsi;
            }
        
            return $ciphertext;
        }

        $kunci = 119;
        $teks_terenkripsi = enkripsi($name, $kunci);

        // ENKRIPSI 2 BUAT CLIENT ID
        function ubahCiphertext($ciphertext, $kunci) {
            // Inisialisasi array dua dimensi untuk menampung chipertext baru
            $array_baris = array();
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array();
            }
        
            $baris_sekarang = 1;
            $turun = true;
        
            // Menyusun ciphertext menjadi pola zig-zag
            $panjang_ciphertext = strlen($ciphertext);
            for ($i = 0; $i < $panjang_ciphertext; $i++) {
                $array_baris[$baris_sekarang][] = $ciphertext[$i];
                if ($baris_sekarang == 1) {
                    $turun = true;
                } elseif ($baris_sekarang == $kunci) {
                    $turun = false;
                }
                if ($turun) {
                    $baris_sekarang++;
                } else {
                    $baris_sekarang--;
                }
            }
        
            // Mengubah urutan karakter dari belakang ke depan dalam setiap baris
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array_reverse($array_baris[$i]);
            }
        
            // Mengambil hasil transposisi per baris sesuai dengan jumlah karakter di baris tersebut
            $chipertext_baru = "";
            for ($i = 1; $i <= $kunci; $i++) {
                foreach ($array_baris[$i] as $karakter) {
                    $chipertext_baru .= $karakter;
                }
            }
        
            return $chipertext_baru;
        }
        
        // Ciphertext yang diberikan
        $ciphertext1 = $teks_terenkripsi;
        $kunci = 3;
        
        // Mengubah ciphertext menjadi chipertext baru
        $chipertext2 = ubahCiphertext($ciphertext1, $kunci);
        
        // Menampilkan hasil chipertext baru
        // echo "Chipertext baru: " . $chipertext2;


        // ENKRIPSI 1 BUAT CLIENT SECRET
        function enkripsiSecret($plainSecret, $kunci) {
            $cipherSecret = "";
            $panjang_teks = strlen($plainSecret);
        
            for ($i = 0; $i < $panjang_teks; $i++) {
                // Mendapatkan kode ASCII asli dari karakter
                $kode_ascii_asli = ord($plainSecret[$i]);
              
                // Mengenkripsi indeks karakter dengan menggunakan kunci (dengan modulus 93 untuk loop)
                $indeks_terenkripsi = ($kode_ascii_asli  + $kunci) % 93;
                // Mengembalikan karakter terenkripsi dari indeks terenkripsi
                $karakter_terenkripsi = chr(33 + $indeks_terenkripsi);
                // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
                $cipherSecret .= $karakter_terenkripsi;
            }
        
            return $cipherSecret;
        }
    
        $kunciSecret = 111;
        $secret_terenkripsi = enkripsiSecret($name, $kunciSecret);
    
        // ENKRIPSI 2 BUAT CLIENT SECRET
        function ubahCipherSecret($cipherSecret, $kunci) {
            // Inisialisasi array dua dimensi untuk menampung chipertext baru
            $array_baris = array();
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array();
            }
        
            $baris_sekarang = 1;
            $turun = true;
        
            // Menyusun cipherSecret menjadi pola zig-zag
            $panjang_cipherSecret = strlen($cipherSecret);
            for ($i = 0; $i < $panjang_cipherSecret; $i++) {
                $array_baris[$baris_sekarang][] = $cipherSecret[$i];
                if ($baris_sekarang == 1) {
                    $turun = true;
                } elseif ($baris_sekarang == $kunci) {
                    $turun = false;
                }
                if ($turun) {
                    $baris_sekarang++;
                } else {
                    $baris_sekarang--;
                }
            }
        
            // Mengubah urutan karakter dari belakang ke depan dalam setiap baris
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array_reverse($array_baris[$i]);
            }
        
            // Mengambil hasil transposisi per baris sesuai dengan jumlah karakter di baris tersebut
            $chipertext_baru = "";
            for ($i = 1; $i <= $kunci; $i++) {
                foreach ($array_baris[$i] as $karakter) {
                    $chipertext_baru .= $karakter;
                }
            }
        
            return $chipertext_baru;
        }
        
        // CipherSecret yang diberikan
        $cipherSecret1 = $secret_terenkripsi;
        $kunciTranposSecret = 3;
        
        // Mengubah cipherSecret menjadi chipertext baru
        $chiperSecret2 = ubahCipherSecret($cipherSecret1, $kunciTranposSecret);
        
        
        
        // Set static Client ID and Client Secret for specific applications
        $clientId = '';
        $clientSecret = '';
        if ($name == 'Sistem Informasi Manajemen') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Lab Teknik Informatika') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Lab Teknik Sipil') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Lab Teknik Elektronika') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Kuliah Kerja Nyata') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Sistem Monitoring Tugas Akhir') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'SISTER') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'SINTA') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'SIMPEL') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else {
            $this->output
                ->set_status_header(400)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Unknown application name')));
            return;
        }

        // Simpan informasi aplikasi di tabel applications
        $data = array(
            'name_client' => $name,
            'client_id' => $clientId,
            'client_secret' => $clientSecret,
            'user_id' => $user_id,
            'user_status' => $user_status,
            'create_at' => $create_at,
            'image' => $image
        );

        if ($this->db->insert('sso_clients', $data)) {
            $response = array(
                'message' => 'Application created successfully',
                'clientId' => $clientId,
                'clientSecret' => $clientSecret
            );
            $this->output
                ->set_content_type('application/json')
                ->set_output(json_encode($response));
        } else {
            $this->output
                ->set_status_header(500)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Error creating application')));
        }
    }


     // KARYAWAN //

     public function create_applicationKryn() {
        $name = $this->input->post('name_client');
        $user_id = $this->input->post('user_id');
        // $user_id = $this->crudUser_modell->insert_id($data_registrasi);
        $user_status = $this->input->post('user_status');
        $create_at = $this->input->post('create_at');
        $image = $this->input->post('image');

        if (empty($name)) {
            $this->output
                ->set_status_header(400)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Application name is required')));
            return;
        }

        // ENKRIPSI 1 BUAT CLIENT ID
        function enkripsi($plaintext, $kunci) {
            $ciphertext = "";
            $panjang_teks = strlen($plaintext);
        
            for ($i = 0; $i < $panjang_teks; $i++) {
                // Mendapatkan kode ASCII asli dari karakter
                $kode_ascii_asli = ord($plaintext[$i]);
              
                // Mengenkripsi indeks karakter dengan menggunakan kunci (dengan modulus 93 untuk loop)
                $indeks_terenkripsi = ($kode_ascii_asli  + $kunci) % 93;
                // Mengembalikan karakter terenkripsi dari indeks terenkripsi
                $karakter_terenkripsi = chr(33 + $indeks_terenkripsi);
                // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
                $ciphertext .= $karakter_terenkripsi;
            }
        
            return $ciphertext;
        }

        $kunci = 119;
        $teks_terenkripsi = enkripsi($name, $kunci);

        // ENKRIPSI 2 BUAT CLIENT ID
        function ubahCiphertext($ciphertext, $kunci) {
            // Inisialisasi array dua dimensi untuk menampung chipertext baru
            $array_baris = array();
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array();
            }
        
            $baris_sekarang = 1;
            $turun = true;
        
            // Menyusun ciphertext menjadi pola zig-zag
            $panjang_ciphertext = strlen($ciphertext);
            for ($i = 0; $i < $panjang_ciphertext; $i++) {
                $array_baris[$baris_sekarang][] = $ciphertext[$i];
                if ($baris_sekarang == 1) {
                    $turun = true;
                } elseif ($baris_sekarang == $kunci) {
                    $turun = false;
                }
                if ($turun) {
                    $baris_sekarang++;
                } else {
                    $baris_sekarang--;
                }
            }
        
            // Mengubah urutan karakter dari belakang ke depan dalam setiap baris
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array_reverse($array_baris[$i]);
            }
        
            // Mengambil hasil transposisi per baris sesuai dengan jumlah karakter di baris tersebut
            $chipertext_baru = "";
            for ($i = 1; $i <= $kunci; $i++) {
                foreach ($array_baris[$i] as $karakter) {
                    $chipertext_baru .= $karakter;
                }
            }
        
            return $chipertext_baru;
        }
        
        // Ciphertext yang diberikan
        $ciphertext1 = $teks_terenkripsi;
        $kunci = 3;
        
        // Mengubah ciphertext menjadi chipertext baru
        $chipertext2 = ubahCiphertext($ciphertext1, $kunci);
        
        // Menampilkan hasil chipertext baru
        // echo "Chipertext baru: " . $chipertext2;


        // ENKRIPSI 1 BUAT CLIENT SECRET
        function enkripsiSecret($plainSecret, $kunci) {
            $cipherSecret = "";
            $panjang_teks = strlen($plainSecret);
        
            for ($i = 0; $i < $panjang_teks; $i++) {
                // Mendapatkan kode ASCII asli dari karakter
                $kode_ascii_asli = ord($plainSecret[$i]);
              
                // Mengenkripsi indeks karakter dengan menggunakan kunci (dengan modulus 93 untuk loop)
                $indeks_terenkripsi = ($kode_ascii_asli  + $kunci) % 93;
                // Mengembalikan karakter terenkripsi dari indeks terenkripsi
                $karakter_terenkripsi = chr(33 + $indeks_terenkripsi);
                // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
                $cipherSecret .= $karakter_terenkripsi;
            }
        
            return $cipherSecret;
        }
    
        $kunciSecret = 111;
        $secret_terenkripsi = enkripsiSecret($name, $kunciSecret);
    
        // ENKRIPSI 2 BUAT CLIENT SECRET
        function ubahCipherSecret($cipherSecret, $kunci) {
            // Inisialisasi array dua dimensi untuk menampung chipertext baru
            $array_baris = array();
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array();
            }
        
            $baris_sekarang = 1;
            $turun = true;
        
            // Menyusun cipherSecret menjadi pola zig-zag
            $panjang_cipherSecret = strlen($cipherSecret);
            for ($i = 0; $i < $panjang_cipherSecret; $i++) {
                $array_baris[$baris_sekarang][] = $cipherSecret[$i];
                if ($baris_sekarang == 1) {
                    $turun = true;
                } elseif ($baris_sekarang == $kunci) {
                    $turun = false;
                }
                if ($turun) {
                    $baris_sekarang++;
                } else {
                    $baris_sekarang--;
                }
            }
        
            // Mengubah urutan karakter dari belakang ke depan dalam setiap baris
            for ($i = 1; $i <= $kunci; $i++) {
                $array_baris[$i] = array_reverse($array_baris[$i]);
            }
        
            // Mengambil hasil transposisi per baris sesuai dengan jumlah karakter di baris tersebut
            $chipertext_baru = "";
            for ($i = 1; $i <= $kunci; $i++) {
                foreach ($array_baris[$i] as $karakter) {
                    $chipertext_baru .= $karakter;
                }
            }
        
            return $chipertext_baru;
        }
        
        // CipherSecret yang diberikan
        $cipherSecret1 = $secret_terenkripsi;
        $kunciTranposSecret = 3;
        
        // Mengubah cipherSecret menjadi chipertext baru
        $chiperSecret2 = ubahCipherSecret($cipherSecret1, $kunciTranposSecret);
        
        
        
        // Set static Client ID and Client Secret for specific applications
        $clientId = '';
        $clientSecret = '';
        if ($name == 'Sistem Informasi Manajemen') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else if ($name == 'Koperasi') {
            $clientId = $chipertext2;
            $clientSecret = $chiperSecret2;
        } else {
            $this->output
                ->set_status_header(400)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Unknown application name')));
            return;
        }

        // Simpan informasi aplikasi di tabel applications
        $data = array(
            'name_client' => $name,
            'client_id' => $clientId,
            'client_secret' => $clientSecret,
            'user_id' => $user_id,
            'user_status' => $user_status,
            'create_at' => $create_at,
            'image' => $image,
        );

        if ($this->db->insert('sso_clients', $data)) {
            $response = array(
                'message' => 'Application created successfully',
                'clientId' => $clientId,
                'clientSecret' => $clientSecret
            );
            $this->output
                ->set_content_type('application/json')
                ->set_output(json_encode($response));
        } else {
            $this->output
                ->set_status_header(500)
                ->set_content_type('application/json')
                ->set_output(json_encode(array('message' => 'Error creating application')));
        }
    }
}
