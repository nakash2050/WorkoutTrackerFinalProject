$(function () {
    $('#txtEndDate').val(new Date().toISOString().split('T')[0]);
    $('#txtEndTime').val(new Date().toLocaleTimeString('it-IT'));
})