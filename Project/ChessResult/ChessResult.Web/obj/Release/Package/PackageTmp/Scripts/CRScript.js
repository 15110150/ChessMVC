$(function () {
    $('.nav-tabs li:first-child a').tab('show');

    $('#startdate-picker').datepicker({
        uiLibrary: 'bootstrap4',
    });

    $('#enddate-picker').datepicker({
        uiLibrary: 'bootstrap4',
        minDate: function () {
            return $('#startdate-picker').val();
        }
    });

    $('#listForm').on('click', 'li a', function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#content-data').html(data);
        });
    });

    $('#staringRank').click(function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#content-data').html(data);
        });
    });

    $('#tbPairt').on('click', 'td', function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#content-data').html(data);
        });
    });

    $('#boardPairing').click(function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#content-data').html(data);
        });
    });

    $('#playerInfo').click(function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#exampleModal').modal('show');
        });
    });

    $('#fedeParticipate').click(function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#content-data').html(data);
        });
    });

    $('#pageSubmenu').on('click', 'li a', function () {
        var url = $(this).data('request-url');
        $.get(url, function (data) {
            $('#content-data').html(data);
        });
    });
});
