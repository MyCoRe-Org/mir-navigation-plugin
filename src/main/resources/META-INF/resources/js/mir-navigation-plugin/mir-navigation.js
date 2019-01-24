$(document).ready(function () {
    /*
     * get the root navigation document
     */
    let currentUrl = window.location.href;

    let currentMyCoreObjectId = getCurrentMyCoreObjectId(currentUrl);

    function getCurrentMyCoreObjectId(currentUrl) {

        requestXSL(currentUrl).then((data) => {
            var mycoreObjectId = $('mycoreobject', data).attr('ID');

            if (!mycoreObjectId) {

                var currentUrlParts = currentUrl.split('/');

                currentUrl = currentUrl.replace(currentUrlParts[currentUrlParts.length - 1], '');

                getCurrentMyCoreObjectId(currentUrl);
            }
        });
    }


    function requestXSL(currentUrl) {

        return $.ajax({
            url: currentUrl + "?XSL.Style=xml",
            dataType: "xml",
            type: "GET",
        });
    }
});