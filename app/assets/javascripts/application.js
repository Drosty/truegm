// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-animate
//= require angular-resource
//= require angular-sanitize
//= require angular-route
//= require angular-ui-bootstrap-tpls
//= require ng-rails-csrf
//= require main
//= require angular-rails-templates
//= require_tree ../templates
//= require_tree .

$( document ).ready(function(){
  $('.slider').slider({full_width: true});
  
  $('.button-collapse').sideNav({
      menuWidth: 240,
      closeOnClick: false // Closes side-nav on <a> clicks, useful for Angular/Meteor
    }
  );
  
  $('.modal-trigger').leanModal();
  $('.scrollspy').scrollSpy();
  $('.datepicker').pickadate({selectYears: 20});
  $('select').not('.disabled').material_select();
})
