I'm surprised to realize that there is NO logger available for HHVM! So I made this very simple (yet sufficient) one.

To use it:

\$logger = new \Log\Logger('main');

\$logger->addHandler(new \Log\LogToFileHandler(
'/path/to/your/logging/file.log',
));

\$logger->log(\Log\LogLevel::WARNING, 'test log content');

//////////////////////////////
\Log\MainLogger::log(
\Log\LogLevel::ERROR,
$e->getMessage().$e->getTraceAsString(),
);
