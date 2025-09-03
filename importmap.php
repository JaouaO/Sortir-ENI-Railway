<?php

/**
 * Importmap configuration for AssetMapper.
 */

return [
    'app' => [
        'path' => './assets/app.js',
        'entrypoint' => true,
    ],
    '@hotwired/stimulus' => [
        'path' => 'https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3.2.2/dist/stimulus.umd.js',
    ],
    '@hotwired/turbo-rails' => [
        'path' => 'https://cdn.jsdelivr.net/npm/@hotwired/turbo-rails@8.0.16/dist/turbo.es2017-umd.js',
    ],
    'bootstrap' => [
        'version' => '5.3.8',
    ],
    '@popperjs/core' => [
        'version' => '2.11.8',
    ],
    'bootstrap/dist/css/bootstrap.min.css' => [
        'version' => '5.3.8',
        'type' => 'css',
    ],
];
