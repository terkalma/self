var Calendar = React.createClass({

    propTypes: {

        url: React.PropTypes.string

    },

    getInitialState: function(){

        return {events: null};

    },

    loadEventsFromServer: function(url) {
        $.ajax({
            url: url,
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({events:data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });

    },

    componentDidMount: function() {

       this.loadEventsFromServer(this.props.url); 

    },

    generateDataTable: function() {
       
        var x = new Date(this.state.events.current_date);
        var firstD = new Date(x.setDate(1)).getDay();
        var arr = new Array([]);
        var x = 0;
        for (var i = 0; i < 6; i++) { 
            arr[i] = [];
            for (var j = 0; j < 7; j++) { 
                if (x == 0) {
                    if (((j+1) == firstD) || (firstD == 0 && j == 6)) {
                        x++;
                    }
                }            
                arr[i][j] = x;
                if (x!=0 && x < 32){
                    x++;
                }
            }
        }
        return (arr);

    },

    prevMonth: function() {

        this.loadEventsFromServer(this.state.events.previous);

    },

    nextMonth: function() {

        this.loadEventsFromServer(this.state.events.next); 

    },

    render: function(){ 

        if (this.state.events) {
            var dayNames = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
            var monthNames = ["January", "February", "March", "April", "May", "June",
                                "July", "August", "September", "October", "November", "December"];
            var dataTable = this.generateDataTable();
            var x = new Date(this.state.events.current_date);
            var currentDay = x.getDate();
            var currentMonth = x.getMonth();
            var currentYear = x.getFullYear();
            var trueFalse = [];
            var i = 1;
            var self = this;

            for(var y in this.state.events.dates){
                trueFalse[i] = this.state.events.dates[y];
                i++;
            }

            return (
                React.DOM.table({className: "calendar-container"}, null, 
                    React.DOM.thead(null,
                        React.DOM.tr(null, 
                            React.DOM.td({ className: "left-align", colSpan : 2, onClick: self.prevMonth}, '<' ),
                            React.DOM.td({ colSpan : 3}, monthNames[currentMonth] + ', ' + currentYear ),
                            React.DOM.td({ className: "right-align", colSpan : 2, onClick: self.nextMonth}, '>' )
                        ),    
                        React.DOM.tr(null, 
                            dayNames.map(function (cell) {
                                return React.DOM.td(null, cell);
                            })
                        )    
                    ),

                    React.DOM.tbody(null,
                        dataTable.map(function (row) {
                            return (
                                React.DOM.tr(null, 
                                    row.map(function (cell) {
                                        if (cell == 0 || typeof trueFalse[cell] === 'undefined') {
                                            return React.DOM.td({ className: 'normal-day' }, null, '');
                                        }
                                        else if (cell == currentDay) {
                                            return React.DOM.td({ className: ' current-day' }, null, cell);
                                        }
                                        else {
                                            if (trueFalse[cell]){
                                                return React.DOM.td({ className: ' worked-day' }, null, cell);
                                            }
                                            else {
                                                return React.DOM.td({ className: ' normal-day' }, null, cell);
                                            }
                                        }
                                    })
                                )
                            );
                        })
                    )
                )
            )
        }
        else {   
            return <div>Loading...</div>;
        }  
    },

});


