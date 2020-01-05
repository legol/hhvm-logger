namespace Log;

/**
 * Describes log levels.
 */
enum LogLevel: string {
    EMERGENCY = 'emergency';
    ALERT = 'alert';
    CRITICAL = 'critical';
    ERROR = 'error';
    WARNING = 'warning';
    NOTICE = 'notice';
    INFO = 'info';
    DEBUG = 'debug';
}

/**
 * Describes a logger instance. Ported from PSR-3.
 *
 * See https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md
 * for the original PSR-3 interface specification.
 */
interface ILogger {
    public function name(): string;

    /**
     * Logs with an arbitrary level.
     *
     * @param LogLevel $level
     * @param string $message
     * @return void
     */
    public function log(LogLevel $level, string $message): void;
}

interface ILoggerHandler {
    /**
     * Called by a logger to actually write $message to somewhere -- a file, network, a variable, etc
     *
     * @param LogLevel $level
     * @param string $message
     * @return void
     */
    public function log(
        ILogger $logger,
        LogLevel $level,
        string $message,
    ): void;
}
