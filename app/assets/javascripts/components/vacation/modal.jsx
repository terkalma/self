var VacationModal = React.createClass({
    loadEditVacationModal: function (selector = '.card-content') {
        $(selector).children('.edit-vacation-modal').leanModal({
            ready: function() {
                $.ajax({
                    url: $('#vacation-form-container').data('vacationRequestPath'),
                    method: 'GET',
                    dataType: 'html',
                    cache: false,
                    success: function(data) {
                        $('#vacation-form-container .modal-content').html(data);
                        $('.datepicker').pickadate({
                            selectMonths: true,
                            selectYears: 2,
                            onStart: function() {
                            $('.picker').appendTo('body')}
                        });
                    },
                    error: function(xhr, status, err) {
                        console.error(status, err.toString());
                    }.bind(this)
                });
            },
        });
    },

    componentDidMount: function () {
        vacationIds = [];
        this.loadEditVacationModal();
        $( "#pending-vacations .edit-vacation-modal" ).each(function() {
            vacationIds.push($( this ).parents('div').data('vacationId'));
        });
    },

    componentDidUpdate: function () {
        var id,
            self = this;
        $( "#pending-vacations .edit-vacation-modal" ).each(function() {
            id = $( this ).parents('div').data('vacationId');
            if (_.indexOf(vacationIds, id) == -1 ) {
                vacationIds.push(id);
                var selector = '[data-vacation-id = ' + id + ']';
                self.loadEditVacationModal(selector);
            }

        });
    },

    render: function() {
        return null;
    }
});