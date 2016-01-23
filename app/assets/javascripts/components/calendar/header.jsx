var CalendarHeader = React.createClass({
    propTypes: {
        year: React.PropTypes.number,
        month: React.PropTypes.number,
        prevMonthHandler: React.PropTypes.func,
        nextMonthHandler: React.PropTypes.func
    },

    render: function() {

        var monthNames = ["January", "February", "March", "April", "May", "June", "July",
                "August", "September", "October", "November", "December"],
            dayNames = ['Sun', 'Mon','Tue','Wed','Thu','Fri','Sat'],
            self = this,
            dayNamesPresented = React.DOM.tr(null,
                dayNames.map(function (dayName) {
                    return React.DOM.td({key: dayName, className: 'bold'}, null, dayName);
                })
            );

        return <thead>
            <tr>
                <th colSpan="2">
                    <a className="btn-floating btn waves-effect waves-light blue" onClick={self.props.prevMonthHandler}>
                        <i className="material-icons">fast_rewind</i>
                    </a>
                </th>
                <th colSpan="3">
                    <h4>{monthNames[self.props.month]}, {self.props.year}</h4>
                </th>
                <th colSpan="2">
                    <a className="btn-floating btn waves-effect waves-light blue" onClick={self.props.nextMonthHandler}>
                        <i className="material-icons">fast_forward</i>
                    </a>
                </th>
            </tr>
            {dayNamesPresented}
        </thead>
    }
});