<?php
require_once 'includes/Upload.class.php';

$type = $_GET['output'] ?? 'json';
$response = (new Core\Response($type));

if (isset($_FILES['files'])) {
    $uploads = Upload::reFiles($_FILES['files']);

    try {
        foreach ($uploads as $upload) {
            $res[] = Upload::uploadFile();
        }
        if (isset($res)) {
            $response->send($res);
        }
    } catch (Exception $e) {
        $response->error($e->getCode(), $e->getMessage());
    }
} else {
    $response->error(400, 'No input file(s)');
}
