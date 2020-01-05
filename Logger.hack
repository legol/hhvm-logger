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

    public function log(LogLevel $level, string $message): void {
        foreach ($this->handlers as $handler) {
            $handler->log($this, $level, $message);
        }
    }

}
