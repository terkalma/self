var Request = React.createClass({
    render: function() {

        return <div className="vacation {this.props.class} card">
            <div className="card-content">
                <h5>
                    {this.props.request.vacation_from} - {this.props.request.vacation_to} ({this.props.request.length} days)
                </h5>
                <p>{this.props.request.reason}</p>
            </div>
        </div>
    }
});