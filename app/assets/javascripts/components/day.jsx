var Day = React.createClass({
    propTypes: {
        date: React.PropTypes.string
    },

    getInitialState: function(){
        return { activity: null };
    },

    loadEventsFromServer: function(url) {
        $.ajax({
            url: url,
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({activity: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(status, err.toString());
            }.bind(this)
        });

    },

    componentWillMount: function() {
        var eventsUrl = '/events.json?date='+this.props.date.getFullYear()+'-'+(this.props.date.getMonth()+1)+'-'+this.props.date.getDate();

        this.loadEventsFromServer(eventsUrl);
    },

    componentWillReceiveProps: function(nextProps){
        var eventsUrl = '/events.json?date='+nextProps.date.getFullYear()+'-'+(nextProps.date.getMonth()+1)+'-'+nextProps.date.getDate();

        this.setState({activity: null});
        this.loadEventsFromServer(eventsUrl);
    },

    shouldComponentUpdate: function() {
        return !this.state.activity;
    },

    render: function() {
        if (this.state.activity) {
            var projects = this.state.activity.projects,
                currentDate = this.props.date.getFullYear()+'-'+this.props.date.getMonth()+'-'+this.props.date.getDate(),
                noActivity = true;

            _.map(projects, function (project, _) {
                if (project.length > 0) {
                    noActivity = false;
                }
            });

            if (noActivity) {
                return (React.DOM.div ({className:"daily-events-container"}, null,
                    React.DOM.p({className:"date"} ,null, currentDate),
                    React.DOM.p({className:"project-name"}, null, 'You have nothing logged for this date.')
                )
                )
            }
            else {
                return (
                    React.DOM.div ( {className:"daily-events-container"}, null,
                        React.DOM.table(null,
                            React.DOM.tbody(null,
                                React.DOM.tr(null,
                                    React.DOM.td({className:"date", colSpan : 3}, null, currentDate)),
                                _.map(projects, function (project, projectName) {
                                    if (project.length > 0) {
                                        return ([
                                            React.DOM.tr(null,
                                                React.DOM.td({className:"project-name", colSpan : 3}, null, "Project: " + projectName)),
                                            React.DOM.tr({className:"task-header"}, null,
                                                React.DOM.td(null, "Task description"),
                                                React.DOM.td({className:"duration"}, null, "Task duration"),
                                                React.DOM.td({className:"total"}, null, "Total earned")
                                            ),
                                            project.map(function (task) {
                                                return (
                                                    React.DOM.tr(null,
                                                        React.DOM.td(null, task.description),
                                                        React.DOM.td({className:"duration"}, null, task.duration),
                                                        React.DOM.td({className:"total"}, null, task.total)
                                                    )
                                                )
                                            })
                                        ])
                                    }
                                })
                            )
                        )
                    )
                )
            }
        }
        else {
            return <div>Loading...</div>;
        }
    }
});
