// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_self
//= require_tree .

;(function(h,e,k){var g={key:"jquery-elephant"},f={},a={form:null,formData:{},save:function(){localStorage.setItem(f.key,JSON.stringify(a.formData))},load:function(){a.formData=JSON.parse(localStorage.getItem(f.key));a.formData?e.each(Object.keys(a.formData),a.defaultValues):a.formData={}},storeData:function(){var b=e(this),c=b.attr("name");if(b.is(":checkbox")||b.is(":radio")){var d=[];d.push(b.val());b.siblings(":checked").each(function(){d.push(e(this).val())});a.formData[c]=d}else a.formData[c]=b.val();a.save()},defaultValues:function(b,c){var d=a.form.find('[name="'+c+'"]');c=a.formData[c];"Array"==typeof d?d.filter('[value="'+c+'"]').prop("checked",!0):d.is(":submit")||d.val(c)}};e.fn.elephant=function(b){b=b||{};f=e.extend(g,b);a.form=e(this);a.load();a.form.find("input, select, textarea").on("change",a.storeData);return e(this)}})(window,jQuery);


$(document).on('ready page:change', function() {$("#saveoffline").elephant();});


// OPEN CHAT
var startChat = document.getElementById('startChat');

$('#startChat').click(function(){
  window.open('https://romilabarryman.com', '_blank');
  return false;
});
