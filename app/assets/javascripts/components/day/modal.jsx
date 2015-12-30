var Modal = React.createClass({
    componentDidMount: function () {
        $('.event-modal').leanModal();
        $('.edit-event-modal').leanModal({
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
            }
        });
    },

    render: function() {
        return null;
    }
});