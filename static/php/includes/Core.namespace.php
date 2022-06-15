<?php

namespace Core {

    require_once 'Upload.class.php';

    use Exception;
    use PDO;
    use Upload as Upload;

    class Settings
    {

        public static mixed $DB;

        public static string $DB_MODE;
        public static string $DB_PATH;
        public static string $DB_USER;
        public static string $DB_PASS;

        public static bool $LOG_IP;
        public static bool $ANTI_DUPE;
        public static bool $BLACKLIST_DB;
        public static bool $FILTER_MODE;

        public static string $FILES_ROOT;
        public static int $FILES_RETRIES;
        public static int $MAX_UPLOAD_SIZE;

        public static bool $SSL;
        public static string $URL;

        public static int $NAME_LENGTH;
        public static string $ID_CHARSET;
        public static array $BLOCKED_EXTENSIONS;
        public static array $BLOCKED_MIME;


        /**
         * @throws Exception
         */
        public static function loadConfig()
        {
            if (!file_exists('/home/webminas/share.onn.li/dist.json')) {
                throw new Exception('Can\'t read settings file.', 500);
            }
            try {
                $settings_array = json_decode(
                    file_get_contents('/home/webminas/share.onn.li/dist.json'),
                    true
                );
                self::$DB_MODE = $settings_array['DB_MODE'];
                self::$DB_PATH = $settings_array['DB_PATH'];
                self::$DB_USER = $settings_array['DB_USER'];
                self::$DB_PASS = $settings_array['DB_PASS'];
                self::$LOG_IP = $settings_array['LOG_IP'];
                self::$ANTI_DUPE = $settings_array['ANTI_DUPE'];
                self::$BLACKLIST_DB = $settings_array['BLACKLIST_DB'];
                self::$FILTER_MODE = $settings_array['FILTER_MODE'];
                self::$FILES_ROOT = $settings_array['FILES_ROOT'];
                self::$FILES_RETRIES = $settings_array['FILES_RETRIES'];
                self::$MAX_UPLOAD_SIZE = $settings_array['max_upload_size'];
                self::$SSL = $settings_array['SSL'];
                self::$URL = $settings_array['URL'];
                self::$NAME_LENGTH = $settings_array['NAME_LENGTH'];
                self::$ID_CHARSET = $settings_array['ID_CHARSET'];
                self::$BLOCKED_EXTENSIONS = $settings_array['BLOCKED_EXTENSIONS'];
                self::$BLOCKED_MIME = $settings_array['BLOCKED_MIME'];
            } catch (Exception) {
                throw new Exception('Can\'t populate settings.', 500);
            }
            Database::assemblePDO();
        }
    }


    class Response
    {
        private mixed $type;

        public function __construct($response_type = null)
        {
            switch ($response_type) {
                case 'csv':
                    header('Content-Type: text/csv; charset=UTF-8');
                    $this->type = $response_type;
                    break;
                case 'html':
                    header('Content-Type: text/html; charset=UTF-8');
                    $this->type = $response_type;
                    break;
                case 'json':
                    header('Content-Type: application/json; charset=UTF-8');
                    $this->type = $response_type;
                    break;
                case 'gyazo':
                    header('Content-Type: text/plain; charset=UTF-8');
                    $this->type = 'text';
                    break;
                case 'text':
                    header('Content-Type: text/plain; charset=UTF-8');
                    $this->type = $response_type;
                    break;
                default:
                    header('Content-Type: application/json; charset=UTF-8');
                    $this->type = 'json';
                    $this->error(400, 'Invalid response type. Valid options are: csv, html, json, text.');
                    break;
            }
        }

        public function error($code, $desc)
        {
            $response = null;

            switch ($this->type) {
                case 'csv':
                    $response = $this->csvError($desc);
                    break;
                case 'html':
                    $response = $this->htmlError($code, $desc);
                    break;
                case 'json':
                    $response = $this->jsonError($code, $desc);
                    break;
                case 'text':
                    $response = $this->textError($code, $desc);
                    break;
            }
            http_response_code($code);
            echo $response;
        }

        private static function csvError($description): string
        {
            return '"error"' . "\r\n" . "\"$description\"" . "\r\n";
        }

        private static function htmlError($code, $description): string
        {
            return '<p>ERROR: (' . $code . ') ' . $description . '</p>';
        }

        private static function jsonError($code, $description): bool|string
        {
            return json_encode([
                'success' => false,
                'errorcode' => $code,
                'description' => $description,
            ], JSON_PRETTY_PRINT);
        }


        private static function textError($code, $description): string
        {
            return 'ERROR: (' . $code . ') ' . $description;
        }

        public function send($files)
        {
            $response = null;

            switch ($this->type) {
                case 'csv':
                    $response = $this->csvSuccess($files);
                    break;
                case 'html':
                    $response = $this->htmlSuccess($files);
                    break;
                case 'json':
                    $response = $this->jsonSuccess($files);
                    break;
                case 'text':
                    $response = $this->textSuccess($files);
                    break;
            }

            http_response_code(200); // "200 OK". Success.
            echo $response;
        }

        private static function csvSuccess($files): string
        {
            $result = '"name","url","hash","size"' . "\r\n";
            foreach ($files as $file) {
                $result .= '"' . $file['name'] . '"' . ',' .
                    '"' . $file['url'] . '"' . ',' .
                    '"' . $file['hash'] . '"' . ',' .
                    '"' . $file['size'] . '"' . "\r\n";
            }

            return $result;
        }

        private static function htmlSuccess($files): string
        {
            $result = '';

            foreach ($files as $file) {
                $result .= '<a href="' . $file['url'] . '">' . $file['url'] . '</a><br/>';
            }

            return $result;
        }

        private static function jsonSuccess($files): bool|string
        {
            return json_encode([
                'success' => true,
                'files' => $files,
            ], JSON_PRETTY_PRINT);
        }

        private static function textSuccess($files): string
        {
            $result = '';

            foreach ($files as $file) {
                $result .= $file['url'] . "\n";
            }

            return $result;
        }
    }

    class Database
    {
        /**
         * @throws Exception
         */
        public static function assemblePDO()
        {
            try {
                Settings::$DB = new PDO(
                    Settings::$DB_MODE . ':' . Settings::$DB_PATH,
                    Settings::$DB_USER,
                    Settings::$DB_PASS
                );
            } catch (Exception) {
                throw new Exception('Can\'t connect to DB.', 500);
            }
        }

        /**
         * @throws Exception
         */
        public static function dbCheckNameExists()
        {
            try {
                $q = Settings::$DB->prepare('SELECT COUNT(filename) FROM files WHERE filename = (:name)');
                $q->bindValue(':name', Upload::$NEW_NAME_FULL);
                $q->execute();
                return $q->fetchColumn();
            } catch (Exception) {
                throw new Exception('Can\'t check if name exists in DB.', 500);
            }
        }

        /**
         * @throws Exception
         */
        public static function checkFileBlacklist()
        {
            try {
                $q = Settings::$DB->prepare('SELECT hash, COUNT(*) AS count FROM blacklist WHERE hash = (:hash)');
                $q->bindValue(':hash', Upload::$SHA1, PDO::PARAM_STR);
                $q->execute();
                $result = $q->fetch();
                if ($result['count'] > 0) {
                    throw new Exception('File blacklisted!', 415);
                }
            } catch (Exception) {
                throw new Exception('Can\'t check blacklist DB.', 500);
            }
        }

        /**
         * @throws Exception
         */
        public static function antiDupe()
        {
            try {
                $q = Settings::$DB->prepare(
                    'SELECT filename, COUNT(*) AS count FROM files WHERE hash = (:hash) AND size = (:size)'
                );
                $q->bindValue(':hash', Upload::$SHA1, PDO::PARAM_STR);
                $q->bindValue(':size', Upload::$FILE_SIZE, PDO::PARAM_INT);
                $q->execute();
                $result = $q->fetch();
                if ($result['count'] > 0) {
                    Upload::$NEW_NAME_FULL = $result['filename'];
                } else {
                    Upload::generateName();
                }
            } catch (Exception) {
                throw new Exception('Can\'t check for dupes in DB.', 500);
            }
        }

        /**
         * @throws Exception
         */
        public static function newIntoDB()
        {
            try {
                $q = Settings::$DB->prepare(
                    'INSERT INTO files (hash, originalname, filename, size, date, ip) VALUES (:hash, :orig, :name, :size, :date, :ip)'
                );
                $q->bindValue(':hash', Upload::$SHA1, PDO::PARAM_STR);
                $q->bindValue(':orig', Upload::$FILE_NAME, PDO::PARAM_STR);
                $q->bindValue(':name', Upload::$NEW_NAME_FULL, PDO::PARAM_STR);
                $q->bindValue(':size', Upload::$FILE_SIZE, PDO::PARAM_INT);
                $q->bindValue(':date', time(), PDO::PARAM_STR);
                $q->bindValue(':ip', Upload::$IP, PDO::PARAM_STR);
                $q->execute();
            } catch (Exception) {
                throw new Exception('Can\'t insert into DB.', 500);
            }
        }
    }
}
