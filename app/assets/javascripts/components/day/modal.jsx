var Modal = React.createClass({
    loadEditEventModal: function (selector = '.card-content') {
        $(selector).children('.edit-event-modal').leanModal({
            ready: function() {
                $.ajax({
                    url: $('#event-form-container').data('eventPath'),
                    method: 'GET',
                    dataType: 'html',
                    cache: false,
                    success: function(data) {
                        $('#event-form-container .modal-content').html(data);
                        $('#event-form-container select').material_select('destroy');
                        $('#event-form-container select').material_select();
                    },
                    error: function(xhr, status, err) {
                        console.error(status, err.toString());
                    }.bind(this)
                });
            },
        });
    },

    componentDidMount: function () {
        eventIds = [];
        $('.event-modal').leanModal();
        this.loadEditEventModal();
        $( ".edit-event-modal" ).each(function() {
            eventIds.push($( this ).parents('div').data('eventId'));
        });
    },

    componentDidUpdate: function () {
        var id,
            self = this;
        $( ".edit-event-modal" ).each(function() {
            id = $( this ).parents('div').data('eventId');
            if (_.indexOf(eventIds, id) == -1 ) {
                eventIds.push(id);
                var selector = '[data-event-id = ' + id + ']';
                self.loadEditEventModal(selector);
            }

        });
    },

    render: function() {
        return null;
    }
});