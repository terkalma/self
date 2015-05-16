(function( $ ){
    $.fn.customDatepicker = function(options) {
        return this.datepicker($({
            format: 'yyyy-mm-dd',
            'autoclose': true,
            'todayHighlight': true,
            'disableTouchKeyboard': true,
            'orientation': "top auto"
        }).extend(options || {}));
    };
})( jQuery );