var Event = React.createClass({
	render: function() {
		return <div className="col l6">
            <div className="card">
                <div className="card-content">
                    <h5>{this.props.event.duration}h (${this.props.event.total})</h5>
                    <p className="flow-text-mini">{this.props.event.description}</p>
                    <a className="absolute-btn right-align btn-floating btn waves-effect waves-light blue">
                        <i className="material-icons">edit</i>
                    </a>
                </div>
            </div>
        </div>
	}
});

	


