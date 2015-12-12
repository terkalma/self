var CalendarDay = React.createClass({
  propTypes: {
    hasWorkedAt: React.PropTypes.bool,
    isActive: React.PropTypes.bool,
    index: React.PropTypes.number,
    onDayClicked: React.PropTypes.func
  },

  onDayClicked: function() {
      this.props.onDayClicked(this.props.index)
  },

  render: function() {
    var self = this,
        classNames = '',
        isBlank = (self.props.index === 0);


    if (isBlank) {
      return React.DOM.td({ className: '' }, null, '');
    } else if (this.props.isActive) {
      classNames = "waves-effect waves-light z-depth-1 hoverable circle red valign";
    } else if (this.props.hasWorkedAt) {
      classNames = "waves-effect waves-light z-depth-1 hoverable circle green valign has-event";
    }

    return React.DOM.td({className: "center"}, null,
        React.DOM.span({ className: classNames, onClick: self.onDayClicked}, null, this.props.index));
  }
});
