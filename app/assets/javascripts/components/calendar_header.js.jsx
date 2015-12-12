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
        self = this;

    return (
        React.DOM.thead(null,
            React.DOM.tr(null,
                React.DOM.th({className: "center", colSpan : 2}, null,
                    React.DOM.span({className:"waves-effect waves-light z-depth-1 hoverable circle blue valign", onClick: self.props.prevMonthHandler}, '<' )
                ),
                React.DOM.th({ className: "center", colSpan : 3}, null,
                    React.DOM.span(null, monthNames[self.props.month] + ', ' + self.props.year )
                ),
                React.DOM.th({ className: "center", colSpan : 2}, null,
                    React.DOM.span({className:"waves-effect waves-light z-depth-1 hoverable circle blue valign", onClick: self.props.nextMonthHandler}, '>' )
                )
            ),
            React.DOM.tr(null,
                dayNames.map(function (dayName) {
                    return React.DOM.td({key: dayName}, null, dayName);
                })
            )
        )
    );
  }
});



