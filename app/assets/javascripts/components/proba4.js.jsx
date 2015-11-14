
var proba4 = React.createClass({

    propTypes: {
        url: React.PropTypes.string
    },

    getInitialState: function(){
       return {events: []};
    },

    loadEventsFromServer: function() {
        $.ajax({
            url: this.props.url,
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({events:data});
            }.bind(this),
            error: function(xhr, status, err) {
                alert('error');
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
    },

    componentDidMount: function() {
        this.loadEventsFromServer();
        
    },

    render: function(){
      for(var x in this.state.events.dates){
        console.log(this.state.events.dates[x],x);
      }
       alert('itt'); 
       return (
          <div>

            {JSON.stringify(this.state.events.dates)}
          </div>);            
   }
});