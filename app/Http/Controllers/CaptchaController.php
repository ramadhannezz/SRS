<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class CaptchaController extends Controller
{
    public function getRandomCaptcha(Request $request)
    {
        $files = File::files(public_path('images/captchas'));
        $file = $files[array_rand($files)];

        $filename = $file->getFilename();
        $captchaText = pathinfo($filename, PATHINFO_FILENAME); // Asumsi nama file adalah teks captcha

        // Simpan teks captcha di sesi
        $request->session()->put('captcha_text', $captchaText);

        return response()->json([
            'captcha' => asset('images/captchas/' . $filename),
        ]);
    }
}
