var Calendar = React.createClass({
    propTypes: {
        url: React.PropTypes.string,
        eventsUrl: React.PropTypes.string
    },

    getInitialState: function(){
        return { events: null };
    },

    loadDataFromServer: function(url) {
        $.ajax({
            url: url,
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState(this.mapData(data));
                $(document).trigger('react.date-changed', {date: data.current_date});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });

    },

    mapData: function(data) {
        if (data.current_date && typeof data.dates === 'object') {
            return {
                events: {
                    currentDate: new Date(data.current_date),
                    next: data.next,
                    previous: data.previous,
                    dates: data.dates
                }
            };
        } else {
            return { events: null };
        }
    },

    componentDidMount: function() {
        this.loadDataFromServer(this.props.url);
    },

    generateDataTable: function() {
        var dataTable = [],
            currentDate = this.state.events.currentDate,
            lastDay = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0),
            firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay(),
            row, column;

        dataTable[0] = [];
        for (var i = 0; i < firstDay; i++) { dataTable[0][i] = 0; }
        for (var d = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1); d <= lastDay; d.setDate(d.getDate() + 1)) {
            column = (d.getDate() - 1 + firstDay) % 7;
            row = ~~((d.getDate() - 1 + firstDay) / 7);
            dataTable[row] = dataTable[row] || [];
            dataTable[row][column] = d.getDate();
        }

        return dataTable;
    },

    prevMonth: function() {
        this.loadDataFromServer(this.state.events.previous);
    },

    nextMonth: function() {
        this.loadDataFromServer(this.state.events.next);
    },

    dayClicked: function(clickedDate) {
        var currentDate = this.state.events.currentDate,
            newSelectedDateUrl = "/?date="+currentDate.getFullYear()+'-'+(currentDate.getMonth()+1)+'-'+clickedDate;
        this.loadDataFromServer(newSelectedDateUrl);
    },

    render: function(){
        if (this.state.events) {
            var dataTable = this.generateDataTable(),
                currentDate = this.state.events.currentDate,
                currentMonth = currentDate.getMonth(),
                currentYear = currentDate.getFullYear(),
                hasWorkedAt = _.map(this.state.events.dates, function (k, _) {
                    return k;
                }),
                self = this;

            return (
                <div className="row s12 main-container">
                    <div id="calendar-modal" className="modal">
                        <div className="modal-content calendar-container">
                            <table className="centered">
                                <CalendarHeader
                                    key='calendar-header'
                                    month={currentMonth}
                                    year={currentYear}
                                    nextMonthHandler={self.nextMonth}
                                    prevMonthHandler={self.prevMonth}/>
                                <CalendarBody
                                    key='calendar-body'
                                    currentDate={currentDate}
                                    hasWorkedAt={hasWorkedAt}
                                    onDayClicked={self.dayClicked}
                                    dataTable={dataTable}/>
                            </table>
                        </div>
                    </div>
                    <div className="col s12">
                        <Day
                            date={this.state.events.currentDate}
                            eventsUrl={this.props.eventsUrl}/>
                    </div>
                </div>
            )
        } else {
            return <Loading/>;
        }
    }
});