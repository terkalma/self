var Day = React.createClass({
    propTypes: {
        date: React.PropTypes.instanceOf(Date),
        eventsUrl: React.PropTypes.string,
        onChangeDay: React.PropTypes.func
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

    componentDidMount: function () {
        var self = this;
        $(document).on('react.event_added react.event_updated', function() {
            self.loadEventsFromServer(self.state.activity.date);
        });
    },

    componentWillMount: function() {
        this.loadEventsFromServer(this.formatDate(this.props.date));
    },

    componentWillReceiveProps: function(nextProps) {
        this.replaceState(this.getInitialState());
        this.loadEventsFromServer(this.formatDate(nextProps.date));
    },

    componentDidUpdate: function() {
        $('#day-card').animate({"opacity": "0"}, 0).delay(100).animate({"opacity": "1"}, 700);
    },

    loadNewDay: function(value) {
        var newDay = new Date(this.props.date);
        newDay.setDate(newDay.getDate() + value);
        this.props.onChangeDay(newDay);
    },

    render: function() {
        if (this.state.activity) {
            var projects = this.state.activity.projects,
                dayNames = ['Sunday', 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
                hasWorkedThatDay = _.any(projects, function (project) { return project.length > 0 }),
                content,
                currentDay = new Date(moment(this.state.activity.date)).getDay();

            if (hasWorkedThatDay) {
                content = _.compact(_.map(projects, function(project, projectName) {
                    if (project.length > 0) {
                        return <Project key={projectName} projectName={projectName} project={project} />
                    }
                }));
            } else {
                content = <p className="flow-text center bold">Taking it easy today!</p>
            }

            return <div className="card z-depth-4" id="day-card">
                <div className="card-content">
                    <div className="row">
                        <a className="btn-floating btn waves-effect waves-light blue" onClick={()=>this.loadNewDay(-1)}>
                            <i className="material-icons">fast_rewind</i>
                        </a>
                        <a className="btn-floating btn waves-effect waves-light blue right" onClick={()=>this.loadNewDay(+1)}>
                            <i className="material-icons">fast_forward</i>
                        </a>
                    </div>
                    <div className="row">
                        <h4 className="center">{this.state.activity.date}</h4>
                        <h4 className="center">{dayNames[currentDay]}</h4>
                        {content}
                    </div>
                    <a className="absolute-btn-large event-modal btn-floating btn-large waves-effect waves-light blue" href="#new-event-form-container">
                        <i className="material-icons">add</i>
                    </a>
                </div>
            </div>
        }
        else {
            return <Loading/>;
        }
    }
});
