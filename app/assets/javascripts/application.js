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

var serotonin = {                                                                                    
  formData: {},                                                                                      
  save: function() { 
    console.log('saving data', serotonin.formData);                                                                                
    localStorage.setItem('serotonin', JSON.stringify(serotonin.formData));                           
  },
  load: function() {
    console.log('loading data');
    serotonin.formData = JSON.parse(localStorage.getItem('serotonin'));
    if (serotonin.formData) {
      $.each(Object.keys(serotonin.formData), serotonin.defaultValues);
    } else {
      serotonin.formData = {};
    }
  }, 
  storeData: function() {
    var box = $(this),                                                                               
        label = box.attr('name');                                                                    
        
    if (box.attr('type') == 'checkbox') {
        var values = [];
            
        values.push(box.val());
        box.siblings('input[type="checkbox"]:checked').each(function() {                             
          values.push($(this).val());                                                                
        });
        serotonin.formData[label] = values;                                                          
    } else {
      serotonin.formData[label]  = box.val();                                                        
    }     
          
    serotonin.save();
  },
  defaultValues: function(key, value) {                                                              
    var box = $('[name="'+value+'"]'),                                                               
        value = serotonin.formData[value];                                                           
    
    if (box.attr('type') != 'submit') {                                                              
      if (typeof box == 'Array') {                                                                   
        box.each(function() {
          if ($.inArray($(this).val(), value)) {                                                     
            $(this).attr('checked', 'checked');                                                      
          }
        });
      } else {
        box.val(value);
      }
    }
  },
  init: function() {
    console.log('blah hello');
    var saveOffline = $('#saveoffline');                                                               
    serotonin.load(); 
      
    saveOffline.find('input, select').on('change', serotonin.storeData);                               
  }
};  
    
$(document).on('ready page:change', serotonin.init); 