namespace Log;

class LogToFileHandler implements ILoggerHandler {
    public function __construct(private string $file_name): void {}

    public function log(
        ILogger $logger,
        LogLevel $level,
        string $message,
    ): void {
        $message = \HH\Lib\Str\format(
            "[%s] [%s] [%s]: %s\n",
            (new \DateTime('now', new \DateTimeZone('UTC')))->format(
                'Y-m-d H:i:s',
            ),
            $logger->name(),
            (string)$level,
            $message,
        );

        \file_put_contents($this->file_name, $message, \FILE_APPEND);
    }
}
