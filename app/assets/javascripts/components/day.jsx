var Day = React.createClass({
    propTypes: {
        date: React.PropTypes.instanceOf(Date),
        eventsUrl: React.PropTypes.string
    },

    getInitialState: function(){
        return { activity: null };
    },

    loadEventsFromServer: function(date) {
        $.ajax({
            url: this.props.eventsUrl,
            data: {date: date},
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

    formatDate: function(date) {
        return (date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate())
    },

    componentWillMount: function() {
        this.loadEventsFromServer(this.formatDate(this.props.date));
    },

    componentWillReceiveProps: function(nextProps){
        this.setState({activity: null});
        this.loadEventsFromServer(this.formatDate(nextProps.date));
    },

    shouldComponentUpdate: function() {
        return !this.state.activity;
    },

    render: function() {
        if (this.state.activity) {
            var projects = this.state.activity.projects,
                noActivity = true;

            _.map(projects, function (project, _) {
                if (project.length > 0) {
                    noActivity = false;
                }
            });

            if (noActivity) {
                return (React.DOM.div ({className:"daily-events-container"}, null,
                    React.DOM.p({className:"date"} ,null, this.formatDate(this.props.date)),
                    React.DOM.p({className:"project-name"}, null, 'You have nothing logged for this date.')
                )
                )
            }
            else {
                return (
                    React.DOM.div ( {className:"daily-events-container"}, null,
                        React.DOM.table(null,
                            React.DOM.thead(null,
                                React.DOM.tr(null,
                                    React.DOM.th({className:"date", colSpan : 3}, null, this.formatDate(this.props.date))
                                )
                            ),
                            React.DOM.tbody(null,
                                React.DOM.tr(null,
                                    React.DOM.td(null, 
                                        _.map(projects, function (project, projectName) {
                                            if (project.length > 0) {
                                                return (
                                                    <Project key={projectName} projectName={projectName} project={project} />
                                                )
                                            }
                                        })
                                    )
                                )  
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
