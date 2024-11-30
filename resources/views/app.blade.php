<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title inertia>{{ config('app.name', 'LaraReact') }}</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <!-- Scripts -->
        @routes
        @viteReactRefresh
        @vite(['resources/js/app.jsx', "resources/js/Pages/{$page['component']}.jsx"])
        @inertiaHead

        <link id="theme-css" href={{asset('/themes/lara-light-blue/theme.css')}} rel="stylesheet"></link>
        
           <!-- Tambahkan script Google Maps API disini -->
    <!-- Menambahkan script Google Maps API dengan pustaka yang benar -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key={{ config('app.google_maps_api_key') }}&libraries=places,advanced-markers"></script>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    
    </head>
    <body class="font-sans antialiased">
        @inertia
    </body>
</html>
