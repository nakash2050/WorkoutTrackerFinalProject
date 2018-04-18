$(function () {
    $('#txtStartDate').val(new Date().toISOString().split('T')[0]);
    $('#txtStartTime').val(new Date().toLocaleTimeString('it-IT'));
})