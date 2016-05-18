$(document).ready(function(){
    $('.date-picker').datepicker({
	    format: 'mm/dd/yyyy',
      startDate: '-3d',
      minDate: 0,
      maxDate: '+365d',
      constrainInput: true,
      beforeShowDay: reservedDays
    });

    var resDays = Array.from($(".dates").data("reserved"));

    function reservedDays(date){
	    var m = ("0" + (date.getMonth() + 1)).slice(-2), d = ("0" + date.getDate()).slice(-2), y = date.getFullYear().toString();
	    for (var i = 0; i < resDays.length; i++) {
	      if($.inArray(y + '-' + m + '-' + d,resDays) != -1) {
		    return [false, ""];
	      }
	    }
	    return [true, ""];
    }
});
