import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import FullReload from 'vite-plugin-full-reload';
import StimulusHMR from 'vite-plugin-stimulus-hmr';
import ViteRails from 'vite-plugin-rails';

export default defineConfig({
  plugins: [
    RubyPlugin(),
    StimulusHMR(),
    FullReload(['app/views/**/*.erb']),
    ViteRails()
  ]
})
