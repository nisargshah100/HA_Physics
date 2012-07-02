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
//= require cookie
//= require twitter/bootstrap
//= require typeahead
//= require_tree .

velocity_by_hour = new VelocityByHour();
top_districts = new TopDistricts();
projected_revenue = new ProjectedRevenue();
deal_probability = new DealProbability();

if($.cookie('current_page') && $.cookie('current_element')) {
  $(".charts-link").parent().removeClass('active');
  $("#"+$.cookie('current_element')).parent().addClass('active');
  eval($.cookie("current_page")+".fetch()"); 
}
else {
  velocity_by_hour.fetch();
}

$(".charts-link").click(function() {
  $(".charts-link").parent().removeClass('active');
  $(this).parent().addClass('active');
  $.cookie('current_page', $(this).data('f'));
  $.cookie('current_element', $(this).attr('id'));

  $("#container").html('');
  $("#header").html('');
  eval($(this).data('f')+".fetch()");
});