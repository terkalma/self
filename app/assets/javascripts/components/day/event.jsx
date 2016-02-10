var Event = React.createClass({
    onEditModal: function(url) {
        $('#event-form-container').data('eventPath', url);
        $('#event-form-container .modal-content').html('');
    },

	render: function() {
        var editButton,
            deleteButton;
        if (!this.props.event.vacation) {
            editButton =
                <a className="edit-event-modal absolute-btn right-align btn-floating btn waves-effect waves-light blue"
                   href="#event-form-container"
                   data-edit-path={this.props.event.url}
                   onClick={this.onEditModal.bind(this, this.props.event.url)}>
                    <i className="material-icons">edit</i>
                </a>;
            deleteButton =
                <a className="delete-event delete-btn right-align btn-floating btn waves-effect waves-light red"
                   href={this.props.event.event_url}
                   data-method="delete"
                   data-confirm="Are you sure?">
                    <i className="material-icons">delete</i>
                </a>;
        }
        else {
            editButton = '';
            deleteButton = '';
        }
		return <div className="col l6">
            <div className="card">
                <div className="card-content" data-event-id={this.props.event.id}>
                    <h5>{this.props.event.duration}h (${this.props.event.total})</h5>
                    <p className="flow-text-mini">{this.props.event.description}</p>
                    {editButton}
                    {deleteButton}
                </div>
            </div>
        </div>
	}
});

	


