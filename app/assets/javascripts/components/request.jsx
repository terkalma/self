var Request = React.createClass({
    render: function() {
        return (
            React.DOM.tr({className: this.props.class}, null,
                React.DOM.td({className:"vacation-date"}, null, this.props.request.vacation_from),
                React.DOM.td({className:"vacation-date"}, null, this.props.request.vacation_to),
                React.DOM.td({className:"vacation-duration"}, null, this.props.request.length),
                React.DOM.td({className:""}, null,  this.props.request.reason)
            )
        )
    }
});
