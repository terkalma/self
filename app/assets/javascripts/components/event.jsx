var Event = React.createClass({
	render: function() {
		return (
            React.DOM.tr(null,
                React.DOM.td(null, this.props.event.description),
                React.DOM.td({className:"duration"}, null, this.props.event.duration),
                React.DOM.td({className:"total"}, null, this.props.event.total)
            )
		)
	}
});

	


