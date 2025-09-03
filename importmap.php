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
                'version' => '3.2.2',
        ],
        '@hotwired/turbo-rails' => [
                'version' => '8.0.16',
        ],
        '@rails/actioncable/src' => [
                'version' => '8.0.200',
        ],
        '@symfony/stimulus-bundle' => [
                'path' => './vendor/symfony/stimulus-bundle/assets/dist/loader.js',
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
