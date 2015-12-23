var VacationRequests = React.createClass({
    propTypes: {
        requestsUrl: React.PropTypes.string
    },

    getInitialState: function(){
        return { requests: null };
    },

    loadRequestsFromServer: function() {
        $.ajax({
            url: this.props.requestsUrl,
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({ requests: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });

    },

    componentWillMount: function() {
        this.loadRequestsFromServer();
    },

    render: function() {
        if (this.state.requests) {
            var requests = this.state.requests.vacation_requests,
                key;
            return (
                React.DOM.div({className: " col s12 l5"}, null,
                    React.DOM.div({className: "vacation-requests-container"}, null,
                        React.DOM.table(null,
                            React.DOM.thead(null, null),
                            React.DOM.tbody(null,
                                React.DOM.tr(null,
                                    React.DOM.td({className:"project-name", colSpan : 4}, null, "Vacation requests")),
                                React.DOM.tr({className:"task-header"}, null,
                                    React.DOM.td({className:"vacation-date"}, null, "Vacation from"),
                                    React.DOM.td({className:"vacation-date"}, null, "Vacation to"),
                                    React.DOM.td({className:"vacation-duration"}, null, "Duration"),
                                    React.DOM.td({className:""}, null, "Reason")
                                ),
                                requests.pending.map(function (request) {
                                    key+=1;
                                    return (
                                        <Request key={request.reason+key} class = "vacation-pending" request={request} />
                                    )
                                }),
                                requests.approved.map(function (request) {
                                    key+=1;
                                    return (
                                        <Request key={request.reason+key} class = "vacation-approved" request={request} />
                                    )
                                }),
                                requests.declined.map(function (request) {
                                    key+=1;
                                    return (
                                        <Request key={request.reason+key} class = "vacation-declined" request={request} />
                                    )
                                })
                            )
                        )
                    )
                )
            )
        } else {
        return <div>Loading...</div>;
        }
    }
});