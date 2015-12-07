var Project = React.createClass({
	render: function() {
		return (
			React.DOM.table(null,
				React.DOM.tr(null,
            		React.DOM.td({className:"project-name", colSpan : 3}, null, "Project: " + this.props.projectName)),
        		React.DOM.tr({className:"task-header"}, null,
             		React.DOM.td(null, "Task description"),
		            React.DOM.td({className:"duration"}, null, "Task duration"),
		            React.DOM.td({className:"total"}, null, "Total earned")),
				this.props.project.map(function (event) {
		            return (
		            	<Event event={event} />
		            )
				})
			)
		)
	}
});

	


