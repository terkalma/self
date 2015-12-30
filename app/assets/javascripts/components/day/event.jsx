var Event = React.createClass({
    onEditModal: function(url) {
        $('#event-form-container').data('eventPath', url);
        $('#event-form-container .modal-content').html('');
    },

	render: function() {
		return <div className="col l6">
            <div className="card">
                <div className="card-content">
                    <h5>{this.props.event.duration}h (${this.props.event.total})</h5>
                    <p className="flow-text-mini">{this.props.event.description}</p>
                    <a className="edit-event-modal absolute-btn right-align btn-floating btn waves-effect waves-light blue"
                        href="#event-form-container"
                        data-edit-path={this.props.event.url}
                        onClick={this.onEditModal.bind(this, this.props.event.url)}>
                        <i className="material-icons">edit</i>
                    </a>
                </div>
            </div>
        </div>
	}
});

	


