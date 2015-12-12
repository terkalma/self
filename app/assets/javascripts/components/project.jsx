var Project = React.createClass({
	render: function() {
        var event_key = 0;

		return (
			React.DOM.table(null,
                React.DOM.thead(null, null),
                React.DOM.tbody(null,
                    React.DOM.tr(null,
                        React.DOM.td({className:"project-name", colSpan : 3}, null, "Project: " + this.props.projectName)),
                    React.DOM.tr({className:"task-header"}, null,
                        React.DOM.td(null, "Task description"),
                        React.DOM.td({className:"duration"}, null, "Task duration"),
                        React.DOM.td({className:"total"}, null, "Total earned")),
                    this.props.project.map(function (event) {

                        event_key += 1;

                        return (
                            <Event key={event_key} event={event} />
                        )
                    })
                )
			)
		)
	}
});

	


