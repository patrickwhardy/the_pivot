var resDays = [[5, 28, 2016]];

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

function reservedDays(date) {
    if(date.getMonth() == 5) {
	return[false];
    } else {
	return[true];
    }
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
