/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function treatAsUTC(date) {
    var result = new Date(date);
    result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
    return result;
}
 
function daysBetween(dayIn, dayOut) {
    var millisecondsPerDay = 24 * 60 * 60 * 1000;
    return (treatAsUTC(dayOut) - treatAsUTC(dayIn)) / millisecondsPerDay;
}
 
alert(daysBetween($('#dayIn').val(), $('#dayOut').val()));

