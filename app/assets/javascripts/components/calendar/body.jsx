var CalendarBody = React.createClass({
    propTypes: {
        dataTable: React.PropTypes.array,
        dayTypes: React.PropTypes.array,
        onDayClicked: React.PropTypes.func,
        currentDate: React.PropTypes.instanceOf(Date)
    },

    render: function() {
        var calendar_day_key = 0,
            self = this,
            currentDay = this.props.currentDate.getDate();

        return React.DOM.tbody(null,
            self.props.dataTable.map(function (row) {

                var row_key = row.join();

                return React.DOM.tr({key: row_key}, null,
                    row.map(function (cell) {

                        calendar_day_key += 1;

                        return <CalendarDay
                            key={calendar_day_key}
                            dayType={self.props.dayTypes[cell - 1]}
                            isActive={(cell == currentDay)}
                            onDayClicked={self.props.onDayClicked}
                            index={cell}/>
                    })
                );
            })
        )
    }
});