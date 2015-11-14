var Proba = React.createClass({
  render: function() {
    var greeting;
    if (this.props.name == "John") {
        greeting = <div>Hello {this.props.name}</div>;}
    else {
    greeting = <div>Hello stranger</div>;}

    return greeting;
  }
});
