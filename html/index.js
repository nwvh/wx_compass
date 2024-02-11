
$(function () {
    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case 'show':
                $('#main').show();
                break;
            case 'hide':
                $('#main').hide();
                break;
            case 'refresh':
                if (event.data.zone !== undefined) {
                    $('#zone').html(event.data.zone);
                }
                if (event.data.street !== undefined) {
                    $('#street').html(event.data.street);
                }
                if (event.data.heading !== undefined) {
                    $('#maindir').html(event.data.heading);
                }
                if (event.data.leftheading !== undefined) {
                    $('#leftdir').html(event.data.leftheading);
                }
                if (event.data.rightheading !== undefined) {
                    $('#rightdir').html(event.data.rightheading);
                }

                break;
            default:
                break;
        }
    }, false);
});
