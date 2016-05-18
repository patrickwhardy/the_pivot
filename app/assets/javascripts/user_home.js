// var resDays = ["2016-07-20", "2016-07-14"];

resDays = [$(".pizza").data("reserved")];
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

function reservedDays(date){
    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
    console.log('Checking (raw): ' + m + '-' + d + '-' + y);
    for (var i = 0; i < resDays.length; i++) {
	if($.inArray((m+1) + '-' + d + '-' + y,resDays) != -1) {
	    console.log('reserved:  ' + (m+1) + '-' + d + '-' + y + ' / ' + resDays[i]);
	    return [false, ""];
	}
    }
    console.log('free:  ' + (m+1) + '-' + d + '-' + y);
    return [true, ""];
}

$(document).ready(function(){
    $('.date-picker').datepicker({
	format: 'mm/dd/yyyy',
	startDate: '-3d',
	minDate: 0,
	maxDate: '+365d',
	constrainInput: true,
	beforeShowDay: reservedDays
  });
});
