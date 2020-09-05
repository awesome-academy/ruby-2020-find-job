// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('jquery')
require('datatables.net-bs4')
require('packs/datatable')
require('cocoon')
require('packs/custom')
require('chartkick')
require('chart.js')

import '@fortawesome/fontawesome-free/js/all';
import $ from 'jquery';
global.$ = jQuery;
global.toastr = require('toastr')

import { showPreviewImage } from './show_image';
import { passwordRegex } from './regex_password';
import { enterComment, showMessageCancel,escapeEditComment } from './enter_comment';
import { countAssociation } from './count_association';

$(document).on('turbolinks:load', function () {
  showPreviewImage()
  passwordRegex()
  enterComment()
  countAssociation()
  showMessageCancel()
  escapeEditComment()
})
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
