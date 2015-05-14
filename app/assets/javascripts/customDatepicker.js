(function( $ ){
    $.fn.customDatepicker = function() {
        return this.datepicker({
            format: 'yyyy-mm-dd',
            'autoclose': true,
            'todayHighlight': true,
            'disableTouchKeyboard': true,
            'orientation': "top auto"
        });
    };
})( jQuery );