var Day = React.createClass({
  render: function () {
    return (
      <div className="day">
        <p className="date waves-effect waves-light z-depth-1 hoverable circle blue valign has-event">
          {this.props.date}
        </p>
          <br />{this.props.work}
      </div>
      );
  }
});

var Calendar = React.createClass({
  render: function () {
    var dayNodes = this.props.days.map(function (day, index) {
      return (
        <Day date={day.date} work={day.work} key={index} />
        );
    });

    return (
      <div className="calendar">
        {dayNodes}
      </div>
      );
  }
});

var ready = function () {
  var fakeDays = [
    { date:1, work:'true' },
    { date:2, work:'false' },
    { date:3, work:'false' }
  ];

  React.render(
    <Calendar days={fakeDays} />,
    document.getElementById('calendar')
  );
};

$(document).ready(ready);



