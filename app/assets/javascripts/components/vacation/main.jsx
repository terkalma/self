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

    componentDidUpdate: function() {
        $('ul.tabs').tabs();
    },

    componentWillMount: function() {
        this.loadRequestsFromServer();
    },

    vacationRequestTab: function(status, requests) {
        var key = 0,
            presentedRequests = requests.map(function (request) {
                return <Request key={status+key} className={"vacation-" + status} request={request}/>
            });

        return <div id={status + "-vacations"} className="col s12">{presentedRequests}</div>
    },

    render: function() {
        if (this.state.requests) {
            var requests = this.state.requests.vacation_requests,
                self = this,
                content = _.map(['pending', 'approved', 'declined'], function (status) {
                    return self.vacationRequestTab(status, requests[status])
                });

            return <div className="card z-depth-4">
                <div className="card-content">
                    <div className="row">
                        <div className="col s12">
                            <ul className="tabs">
                                <li className="tab col s4">
                                    <a className="active" href="#pending-vacations">Pending</a>
                                </li>
                                <li className="tab col s4"><a href="#approved-vacations">Approved</a></li>
                                <li className="tab col s4"><a href="#declined-vacations">Declined</a></li>
                            </ul>
                        </div>
                        {content}
                    </div>
                    <a className="absolute-btn-large right-align btn-floating btn-large waves-effect waves-light blue">
                        <i className="material-icons">add</i>
                    </a>
                </div>
            </div>
        } else {
            return <Loading/>;
        }
    }
});