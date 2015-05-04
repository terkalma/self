(function( $ ){
    $.fn.customDatepicker = function() {
        return this.datepicker({
            format: 'yyyy-mm-dd',
            'autoclose': true,
            'todayHighlight': true,
            'todayBtn': true,
            'disableTouchKeyboard': true
        });
    };
})( jQuery );