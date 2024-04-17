import { createRequire } from 'node:module';
const require = createRequire( import.meta.url );

import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import FullReload from 'vite-plugin-full-reload';
import StimulusHMR from 'vite-plugin-stimulus-hmr';
import ckeditor5 from '@ckeditor/vite-plugin-ckeditor5';

export default defineConfig({
  plugins: [
    RubyPlugin(),
    StimulusHMR(),
    FullReload(['app/views/**/*.erb', 'app/javascript/**/*.scss']),
    ckeditor5({theme: require.resolve( '@ckeditor/ckeditor5-theme-lark' )})
  ]
})
