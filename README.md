I'm surprised to realize that there is NO logger available for HHVM! So I made this very simple (yet sufficient) one.

Usage:

Option 1:
You can define a class similar to \Log\MainLogger. Set up log file in the class.
Then use it like this:

    \Log\MainLogger::log(\Log\LogLevel::DEBUG, \HH\Lib\Str\format(
    "web_controller=%s query_string=%s",
    $responder,
        json_encode($query_string),
    ));

Option 2:

    \$logger = new \Log\Logger('main');

    \$logger->addHandler(new \Log\LogToFileHandler(
    '/path/to/your/logging/file.log',
    ));

    \$logger->log(\Log\LogLevel::WARNING, 'test log content');
