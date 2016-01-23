var DateInput = React.createClass({
  propTypes: {
    date: React.PropTypes.string
  },

  getInitialState: function() {
    return {date: this.props.date}
  },

  componentDidMount: function() {
    var self = this;

    $(document).on('react.date-changed', function (e, data) {
      self.setState({
        date: data.date
      });
    });
  },

  render: function() {
    return (
      <input type="hidden" value={this.state.date} name="event[worked_at]"></input>
    );
  }
});
