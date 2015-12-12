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
                currentDay = currentDate.getDate(),
                currentMonth = currentDate.getMonth(),
                currentYear = currentDate.getFullYear(),
                hasWorkedAt = _.map(this.state.events.dates, function (k, _) {
                    return k;
                }),
                self = this,
                calendar_day_key = 0;

            return (
                React.DOM.div({className: 'row s12 main-container'}, null,
                    React.DOM.div({className: "calendar-container col s12 l5"}, null,
                        React.DOM.table(null,
                            <CalendarHeader
                                key='calendar-header'
                                month={currentMonth}
                                year={currentYear}
                                nextMonthHandler={self.nextMonth}
                                prevMonthHandler={self.prevMonth}/>,
                            React.DOM.tbody(null,
                                dataTable.map(function (row) {

                                    var row_key = row.join();

                                    return (
                                        React.DOM.tr({key: row_key}, null,
                                            row.map(function (cell) {
                                                calendar_day_key += 1;
                                                return <CalendarDay
                                                    key={calendar_day_key}
                                                    hasWorkedAt={hasWorkedAt[cell - 1]}
                                                    isActive={(cell == currentDay)}
                                                    onDayClicked={self.dayClicked}
                                                    index={cell}/>
                                            })
                                        )
                                    );
                                })
                            )
                        )
                    ),
                    React.DOM.div({className: "s12 l7 col"}, null, <Day date = {this.state.events.currentDate} eventsUrl = {this.props.eventsUrl}/>)
                )
            )
        } else {
            return <div>Loading...</div>;
        }
    }
});