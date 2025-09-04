<?php

/**
 * Returns the importmap for this application.
 *
 * - "path" is a path inside the asset mapper system.
 * - "entrypoint" (JavaScript only) set to true for any module used as an "entrypoint".
 */
return [
    'app' => [
        'path' => './assets/app.js',
        'entrypoint' => true,
    ],

    // Hotwired Stimulus
    '@hotwired/stimulus' => [
        'path' => './assets/vendor/@hotwired/stimulus/stimulus.index.js',
    ],

    // Hotwired Turbo
    '@hotwired/turbo' => [
        'path' => './assets/vendor/@hotwired/turbo/turbo.index.js',
    ],

    // Bootstrap JS
    'bootstrap' => [
        'path' => './assets/vendor/bootstrap/bootstrap.index.js',
    ],

    // Popper.js (Bootstrap dependency)
    '@popperjs/core' => [
        'path' => './assets/vendor/@popperjs/core/core.index.js',
    ],

    // Bootstrap CSS
    'bootstrap/dist/css/bootstrap.min.css' => [
        'path' => './assets/vendor/bootstrap/dist/css/bootstrap.min.css',
        'type' => 'css',
    ],
];
