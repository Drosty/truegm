$(document).ready(function() {
  $('select').selectpicker({
    liveSearch: true,
    width: 'fit'
  });
  $('select').on('changed.bs.select', function (e) {
    updateSalary();
  });
  updateSalary();
});

function updateSalary(){
  sum = 0;
  p=$("option:selected");
  $.map(p, function(item){
    salary_val = item.attributes["salary"] ? item.attributes["salary"].value : "0";
    sum += Number.parseInt(salary_val);
  });
  sumNumber = $.number(sum, 0);
  $("#js-total-salary").text("$" + sumNumber);
}