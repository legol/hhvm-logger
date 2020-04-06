namespace Log;

class Logger implements ILogger {
    private vec<ILoggerHandler> $handlers;

    public function __construct(private string $name): void {
        $this->handlers = vec[];
    }

    public function name(): string {
        return $this->name;
    }

    public function addHandler(ILoggerHandler $handler): void {
        $this->handlers[] = $handler;
    }

    private static function argsToString(?varray<mixed> $args): string {
        if (!\is_array($args)) {
            return "";
        }

        return \HH\Lib\Vec\map($args, $arg ==> \json_encode($arg))
            |> \HH\Lib\Str\join($$, ", ");
    }

    private static function stacktrace(): string {
        $stack = \debug_backtrace();
        return \HH\Lib\Vec\map($stack, $frame ==> {
            $class = \HH\idx($frame, "class");
            $instance_or_class = \HH\idx($frame, "type");
            $function = \HH\idx($frame, "function");
            $args = \HH\idx($frame, "args");
            if ($class !== null) {
                $full_function = \HH\Lib\Str\format(
                    "%s%s%s(%s)",
                    $class,
                    (string)$instance_or_class,
                    (string)$function,
                    self::argsToString($args),
                );
            } else {
                $full_function = \HH\Lib\Str\format(
                    "%s(%s)",
                    (string)$function,
                    self::argsToString($args),
                );
            }

            $file = \HH\idx($frame, "file");
            if ($file !== null) {
                $pretty_frame = \HH\Lib\Str\format(
                    "  %s called at [%s:%d]",
                    $full_function,
                    (string)\HH\idx($frame, "file"),
                    (int)\HH\idx($frame, "line"),
                );
            } else {
                $pretty_frame = \HH\Lib\Str\format(
                    "  %s called at [unknown]",
                    $full_function,
                );
            }

            return $pretty_frame;
        })
            |> \HH\Lib\Str\join($$, "\n");
    }

    public function log(LogLevel $level, string $message): void {
        foreach ($this->handlers as $handler) {
            $handler->log(
                $this,
                $level,
                \HH\Lib\Str\format(
                    "%s\nstack trace:\n%s",
                    $message,
                    self::stacktrace(),
                ),
            );
        }
    }
}

// tail -f /home/ubuntu/git_root/www_badminton/logs.log
class MainLogger {
    private static ?Logger $logger = null;
    public static function log(LogLevel $level, string $message): void {
        if (self::$logger === null) {
            self::$logger = new \Log\Logger(self::class);

            self::$logger->addHandler(
                new \Log\LogToFileHandler(
                    '/home/ubuntu/git_root/www_badminton/logs.log',
                ),
            );
        }

        invariant(self::$logger !== null, 'not null');
        self::$logger->log($level, $message);
    }
}
