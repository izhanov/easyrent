// ckeditor.js

import { ClassicEditor as ClassicEditorBase } from '@ckeditor/ckeditor5-editor-classic';
import { Alignment } from '@ckeditor/ckeditor5-alignment';
import { Essentials } from '@ckeditor/ckeditor5-essentials';
import { Autoformat } from '@ckeditor/ckeditor5-autoformat';
import { Bold, Italic } from '@ckeditor/ckeditor5-basic-styles';
import { BlockQuote } from '@ckeditor/ckeditor5-block-quote';
import { Heading } from '@ckeditor/ckeditor5-heading';
import { Link } from '@ckeditor/ckeditor5-link';
import { List } from '@ckeditor/ckeditor5-list';
import { Paragraph } from '@ckeditor/ckeditor5-paragraph';
import { Table, TableCellProperties, TableProperties, TableToolbar } from '@ckeditor/ckeditor5-table';
import { Style } from '@ckeditor/ckeditor5-style';
import { GeneralHtmlSupport } from '@ckeditor/ckeditor5-html-support';
import { Image, ImageCaption, ImageResize, ImageStyle, ImageToolbar, ImageInsert } from '@ckeditor/ckeditor5-image';
import { LinkImage } from '@ckeditor/ckeditor5-link';
import { Base64UploadAdapter } from '@ckeditor/ckeditor5-upload';

export default class ClassicEditor extends ClassicEditorBase {}

ClassicEditor.builtinPlugins = [
    Image,
    ImageToolbar,
    ImageInsert,
    ImageCaption,
    ImageStyle,
    ImageResize,
    LinkImage,
    Base64UploadAdapter,
    GeneralHtmlSupport,
    Essentials,
    Autoformat,
    Alignment,
    Bold,
    Italic,
    BlockQuote,
    Heading,
    Link,
    List,
    Paragraph,
    Table,
    TableCellProperties,
    TableProperties,
    TableToolbar,
    Style
];

ClassicEditor.defaultConfig = {
  toolbar: {
    items: [
      'heading',
      '|',
      'bold',
      'italic',
      'link',
      'bulletedList',
      'numberedList',
      'blockQuote',
      'undo',
      'redo',
      'insertTable',
      'insertImage',
      'alignment',
      'style'
    ]
  },
  style: {
    definitions: [
      {
        name: 'TD border none',
        element: 'td',
        classes: ['ck-table-border-none']
      },
      {
        name: 'TD border all',
        element: 'td',
        classes: ['ck-table-border-all']
      },
      {
        name: 'TD border top',
        element: 'td',
        classes: ['ck-table-border-top']
      },
      {
        name: 'TD border right',
        element: 'td',
        classes: ['ck-table-border-right']
      },
      {
        name: 'TD border bottpm',
        element: 'td',
        classes: ['ck-table-border-bottom']
      },
      {
        name: 'TD border left',
        element: 'td',
        classes: ['ck-table-border-left']
      }
    ]
  },
  table: {
    contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells', 'tableCellProperties', 'tableProperties']
  },
  image: {
    toolbar: ['imageStyle:block', 'imageStyle:side', '|', 'imageTextAlternative'],
  },
  language: 'en',
};
