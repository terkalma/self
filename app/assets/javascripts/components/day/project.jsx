var Project = React.createClass({
	render: function() {
        var event_key = 0,
            events = this.props.project.map(function (event) {
                event_key += 1;
                return <Event key={event_key} event={event} />
            });

        return <div className="section">
            <h4 className="center">{this.props.projectName}</h4>
            <div className="row">
                {events}
            </div>
        </div>

	}
});

	


