// var resDays = ["2016-07-20", "2016-07-14"];
$(document).ready(function(){
    $('.date-picker').datepicker({
	format: 'mm/dd/yyyy',
	startDate: '-3d',
	minDate: 0,
	maxDate: '+365d',
	constrainInput: true,
	beforeShowDay: reservedDays
    });
    
    var resDays = Array.from($(".pizza").data("reserved"));
    
    function reservedDays(date){
	var m = ("0" + (date.getMonth() + 1)).slice(-2), d = ("0" + date.getDate()).slice(-2), y = date.getFullYear().toString();
	console.log('Checking (raw): ' + m + '-' + d + '-' + y);
	for (var i = 0; i < resDays.length; i++) {
	    if($.inArray(y + '-' + m + '-' + d,resDays) != -1) {
		console.log('reserved:  ' + y + '-' + m + '-' + d + ' / ' + resDays);
		return [false, ""];
	    }
	}
	console.log('free:  ' + y + '-' + m + '-' + d + '/' + resDays);
	return [true, ""];
    }
    
});
// function reservedDays(date) {
//     for (i = 0; i < resDays.length; i++) {
// 	if(date.getMonth() == resDays[i][0] - 1
// 	   && date.getDate() == resDays[i][1]
// 	   && date.getYear() == resDays[i][2])
// 	{
//             return [false];
// 	    console.log("checking may 28 2016");
// 	}
//     }
//     return [true];
// }


// function reservedDays(date) {
//     var formattedDate = $.datepicker.formatDate("yy-mm-dd", date)
//     $.each(resDays, function(key, value) {
// 	if(formattedDate !== value) {
// 	   return [true, ""];
// 	}
//     });
//     return [false, ""];
// }

// function reservedDays(date) {
//     var formattedDate = $.datepicker.formatDate("yy-mm-dd", date)
//     for(i = 0; i < resDays.length; i++) {
// 	console.log("formatted:" +  formattedDate)
// 	console.log("resDays:" +  resDays[i])
// 	if(formattedDate == resDays[i]){
// 	    return [false, ""];
// 	}
//     }
//     return [true, ""];
// }
