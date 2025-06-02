<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;

class Firebase {

    protected $firebase;

    public function __construct() {
        $ci =& get_instance();
        $ci->load->config('firebase');

        $firebaseConfig = [
            'keyFilePath' => $ci->config->item('firebase_json'),
            'databaseUrl' => $ci->config->item('firebase_url'),
        ];

        $serviceAccount = ServiceAccount::fromJsonFile($firebaseConfig['keyFilePath']);
        $this->firebase = (new Factory)
            ->withServiceAccount($serviceAccount)
            ->withDatabaseUri($firebaseConfig['databaseUrl'])
            ->createDatabase();
    }

    public function get($path) {
        $reference = $this->firebase->getReference($path);
        $snapshot = $reference->getSnapshot();

        return $snapshot->getValue();
    }
}
