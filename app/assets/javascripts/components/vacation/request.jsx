var Request = React.createClass({
    onEditModal: function(url) {
        $('#vacation-form-container').data('vacationRequestPath', url);
        $('#vacation-form-container .modal-content').html('');
    },

    render: function() {
        var editButton,
            deleteButton,
            cardClass = this.props.className + " card";
        
        if (this.props.request.status == "pending") {
            editButton = <a className="edit-vacation-modal absolute-btn right-align btn-floating btn waves-effect waves-light blue"
                            href="#vacation-form-container"
                            data-edit-path={this.props.request.url}
                            onClick={this.onEditModal.bind(this, this.props.request.url)}>
                            <i className="material-icons">edit</i>
                        </a>;
            deleteButton = <a className="delete-vacation delete-btn right-align btn-floating btn waves-effect waves-light red"
                               href={this.props.request.vacation_url}
                               data-method="delete"
                               data-confirm="Are you sure?">
                                <i className="material-icons">delete</i>
                            </a>}
        else {
            editButton = '';
            deleteButton = '';
        }
        return <div className={cardClass}>
            <div className="card-content" data-vacation-id={this.props.request.id}>
                <h5>
                    {this.props.request.vacation_from} - {this.props.request.vacation_to} ({this.props.request.length} days)
                </h5>
                <p>{this.props.request.reason}</p>
                {editButton}
                {deleteButton}
            </div>
        </div>
    }
});