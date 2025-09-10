# Crear todos los archivos de middleware necesarios
$middlewareFiles = @{
    "TrustProxies.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Http\Middleware\TrustProxies as Middleware;
use Illuminate\Http\Request;

class TrustProxies extends Middleware
{
    protected `$proxies;

    protected `$headers =
        Request::HEADER_X_FORWARDED_FOR |
        Request::HEADER_X_FORWARDED_HOST |
        Request::HEADER_X_FORWARDED_PORT |
        Request::HEADER_X_FORWARDED_PROTO |
        Request::HEADER_X_FORWARDED_AWS_ELB;
}
"@

    "EncryptCookies.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Cookie\Middleware\EncryptCookies as Middleware;

class EncryptCookies extends Middleware
{
    protected `$except = [
        //
    ];
}
"@

    "VerifyCsrfToken.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;

class VerifyCsrfToken extends Middleware
{
    protected `$except = [
        //
    ];
}
"@

    "Authenticate.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Request;

class Authenticate extends Middleware
{
    protected function redirectTo(Request `$request): ?string
    {
        return `$request->expectsJson() ? null : route('login');
    }
}
"@

    "RedirectIfAuthenticated.php" = @"
<?php

namespace App\Http\Middleware;

use App\Providers\RouteServiceProvider;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RedirectIfAuthenticated
{
    public function handle(Request `$request, Closure `$next, string ...`$guards): Response
    {
        `$guards = empty(`$guards) ? [null] : `$guards;

        foreach (`$guards as `$guard) {
            if (Auth::guard(`$guard)->check()) {
                return redirect('/');
            }
        }

        return `$next(`$request);
    }
}
"@

    "PreventRequestsDuringMaintenance.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\PreventRequestsDuringMaintenance as Middleware;

class PreventRequestsDuringMaintenance extends Middleware
{
    protected `$except = [
        //
    ];
}
"@

    "TrimStrings.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\TrimStrings as Middleware;

class TrimStrings extends Middleware
{
    protected `$except = [
        'current_password',
        'password',
        'password_confirmation',
    ];
}
"@

    "ValidateSignature.php" = @"
<?php

namespace App\Http\Middleware;

use Illuminate\Routing\Middleware\ValidateSignature as Middleware;

class ValidateSignature extends Middleware
{
    protected `$except = [
        //
    ];
}
"@
}

# Crear cada archivo de middleware
foreach (`$file in `$middlewareFiles.Keys) {
    `$content = `$middlewareFiles[`$file]
    `$content | Out-File -FilePath "app/Http/Middleware/`$file" -Encoding UTF8
    Write-Host "Created: app/Http/Middleware/`$file"
}
