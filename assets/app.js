import './bootstrap.js';
/*
 * Welcome to your app's main JavaScript file!
 *
 * This file will be included onto the page via the importmap() Twig function,
 * which should already be in your base.html.twig.
 */
import { Turbo } from "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";

// Initialiser Turbo
window.Turbo = Turbo;

// Initialiser Stimulus
window.Stimulus = Application.start();

import './styles/app.css';

console.log('App.js loaded: Stimulus + Turbo actifs!');