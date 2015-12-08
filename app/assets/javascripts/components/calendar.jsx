var Calendar = React.createClass({
    propTypes: {
        url: React.PropTypes.string,
        eventsUrl: React.PropTypes.string
    },

    getInitialState: function(){
        return { events: null };
    },

    loadDataFromServer: function(url) {
        $.ajax({
            url: url,
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState(this.mapData(data));
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });

    },

    mapData: function(data) {
        if (data.current_date && typeof data.dates === 'object') {
            return {
                events: {
                    currentDate: new Date(data.current_date),
                    next: data.next,
                    previous: data.previous,
                    dates: data.dates
                }
            };
        } else {
            return { events: null };
        }
    },

    componentDidMount: function() {
       this.loadDataFromServer(this.props.url);
    },

    generateDataTable: function() {
        var dataTable = [],
            currentDate = this.state.events.currentDate,
            lastDay = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0),
            firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay(),
            row, column;

        dataTable[0] = [];
        for (var i = 0; i < firstDay; i++) { dataTable[0][i] = 0; }
        for (var d = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1); d <= lastDay; d.setDate(d.getDate() + 1)) {
            column = (d.getDate() - 1 + firstDay) % 7;
            row = ~~((d.getDate() - 1 + firstDay) / 7);
            dataTable[row] = dataTable[row] || [];
            dataTable[row][column] = d.getDate();
        }

        return dataTable;
    },

    prevMonth: function() {
        this.loadDataFromServer(this.state.events.previous);
    },

    nextMonth: function() {
        this.loadDataFromServer(this.state.events.next);
    },

    dayClicked: function(clickedDate) {
        var currentDate = this.state.events.currentDate,
            newSelectedDateUrl = "/?date="+currentDate.getFullYear()+'-'+(currentDate.getMonth()+1)+'-'+clickedDate;;   
            this.loadDataFromServer(newSelectedDateUrl);
    },

    render: function(){ 
        if (this.state.events) {
            var dayNames = ['Sun', 'Mon','Tue','Wed','Thu','Fri','Sat'],
                monthNames = ["January", "February", "March", "April", "May", "June",
                                "July", "August", "September", "October", "November", "December"],
                dataTable = this.generateDataTable(),
                currentDate = this.state.events.currentDate,
                currentDay = currentDate.getDate(),
                currentMonth = currentDate.getMonth(),
                currentYear = currentDate.getFullYear(),
                hasWorkedAt = _.map(this.state.events.dates, function (k, _) { return k; }),
                self = this;
            return ( 
                React.DOM.div(null,
                    React.DOM.div({className: "calendar-container"}, null, 
                        React.DOM.table(null, 
                            React.DOM.thead(null,
                                React.DOM.tr(null, 
                                    React.DOM.th({className: "center", colSpan : 2}, null,
                                        React.DOM.span({className:"waves-effect waves-light z-depth-1 hoverable circle blue valign has-event", onClick: self.prevMonth}, '<' )
                                    ),
                                    React.DOM.th({ className: "center", colSpan : 3}, null, 
                                        React.DOM.span(null, monthNames[currentMonth] + ', ' + currentYear )
                                    ),
                                    React.DOM.th({ className: "center", colSpan : 2}, null,
                                        React.DOM.span({className:"waves-effect waves-light z-depth-1 hoverable circle blue valign has-event", onClick: self.nextMonth}, '>' )
                                    )
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
                                                if (cell == 0) {
                                                    return React.DOM.td({ className: '' }, null, '');
                                                } else if (cell == currentDay) {
                                                    return ( 
                                                        React.DOM.td({className: "center"}, null,
                                                            React.DOM.span({ className: "waves-effect waves-light z-depth-1 hoverable circle red valign has-event", onClick: function() {self.dayClicked(cell)}}, null, cell)
                                                        )
                                                    )
                                                } else {
                                                    if (hasWorkedAt[cell - 1]){
                                                        return (
                                                            React.DOM.td({className: "center"}, null,
                                                                React.DOM.span({className:"waves-effect waves-light z-depth-1 hoverable circle green valign has-event", onClick: function() {self.dayClicked(cell)}}, null, cell)
                                                            )
                                                        )
                                                    }
                                                    else {
                                                        return (
                                                            React.DOM.td({ className: "center" }, null,
                                                                React.DOM.span({onClick: function() {self.dayClicked(cell)}}, null, cell)
                                                            )
                                                        )
                                                    }
                                                }
                                            })
                                        )
                                    );
                                })
                            )
                        )
                    ),
                    <Day date = {this.state.events.currentDate} eventsUrl = {this.props.eventsUrl}/>
                )
            )
        }
        else {   
            return <div>Loading...</div>;
        }  
    }
});
