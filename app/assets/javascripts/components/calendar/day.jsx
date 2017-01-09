var CalendarDay = React.createClass({
    propTypes: {
        dayType: React.PropTypes.string,
        isActive: React.PropTypes.bool,
        index: React.PropTypes.number,
        onDayClicked: React.PropTypes.func
    },

    onDayClicked: function() {
        $('#calendar-modal').modal('close');
        this.props.onDayClicked(this.props.index);
    },

    render: function() {
        var self = this,
            classNames = '',
            isBlank = (self.props.index === 0);


        if (isBlank) {
            return <td></td>
        } else if (this.props.isActive) {
            classNames = "waves-effect waves-light z-depth-1 hoverable circle red valign";
        } else if (this.props.dayType == 'work') {
            classNames = "waves-effect waves-light z-depth-1 hoverable circle green valign has-event";
        } else if (this.props.dayType == 'vacation') {
            classNames = "waves-effect waves-light z-depth-1 hoverable circle yellow valign has-event";
        }

        return <td className="bold">
            <span className={classNames} onClick={self.onDayClicked}>{this.props.index}</span>
        </td>
    }
});