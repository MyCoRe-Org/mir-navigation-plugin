$(document).ready(function () {
    const restSearch = '/api/v1/search';
    /*
     * get the root navigation document
     */
    let currentUrl = window.location.href;

    let currentMyCoreObjectId = getCurrentMyCoreObjectId(currentUrl);

    function getCurrentMyCoreObjectId(currentUrl) {

        requestXSL(currentUrl).then((data) => {
            var mycoreObjectId = $('mycoreobject', data).attr('ID');

            if (!mycoreObjectId) {

                if (currentUrl)

                    var currentUrlParts = currentUrl.split('/');
                currentUrl = currentUrl.replace(currentUrlParts[currentUrlParts.length - 1], '');

                currentUrl = currentUrl.replace(/\/$/, '');

                getCurrentMyCoreObjectId(currentUrl);
            } else {

                /*
                 * get the root document
                 */
                getRootDocument(mycoreObjectId);
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

    function getRootDocument(mycoreObjectId) {
        requestSolrDocument(mycoreObjectId, 'id:' + mycoreObjectId).then((data) => {

            console.log(data);
            var mycoreSolrDocumentObj = jQuery.parseJSON(data);

            console.log(mycoreSolrDocumentObj);
        });


    }

    function requestSolrDocument(mycoreObjectId, query) {
        return $.ajax({
            url: window.location.origin + restSearch + '?q=' + query + '&wt=json&json.wrf=?',
            type: "GET",
            dataType : "jsonp"
        });
    }
});