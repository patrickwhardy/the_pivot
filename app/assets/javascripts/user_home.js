var resDays = ["2016-07-20", "2016-07-14"];

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
// 	if(formattedDate == value) {
// 	    return [false];
// 	}
//     });
// }

function reservedDays(date) {
    var formattedDate = $.datepicker.formatDate("yy-mm-dd", date)
    for(i = 0; i < resDays.length; i++) {
	if(resDays[i] == formattedDate){
	    return [false];
	}
    }
    return [true];
}

$(document).ready(function(){
    $('.date-picker').datepicker({
	format: 'mm/dd/yyyy',
	startDate: '-3d',
	minDate: 0,
	constrainInput: true,
	beforeShowDay: reservedDays
  });
});
