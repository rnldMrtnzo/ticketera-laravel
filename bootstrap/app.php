<?php

$app = new Illuminate\Foundation\Application(
    $_ENV["APP_BASE_PATH"] ?? dirname(__DIR__)
);

$app->singleton(
    Illuminate\Contracts\Http\Kernel::class,
    App\Http\Kernel::class
);

$app->singleton(
    Illuminate\Contracts\Console\Kernel::class,
    function ($app) {
        return new class($app, $app["events"]) extends Illuminate\Foundation\Console\Kernel {
            protected function schedule($schedule) {}
            protected function commands() {}
        };
    }
);

$app->singleton(
    Illuminate\Contracts\Debug\ExceptionHandler::class,
    App\Exceptions\Handler::class
);

return $app;
