var blocmetrics = function (tracked_domain, event_type) {
    var _bm_event = {
        event : {
        tracked_domain: tracked_domain,
        event_type: event_type
        }
    }

    var _bm_request = new XMLHttpRequest();
    _bm_request.open("POST", "//kristingonzalez-blocmetrics.herokuapp.com/api/v1/events.json", true);
    _bm_request.setRequestHeader('Content-Type', 'application/json');
    _bm_request.onreadystatechange = function () {

    };


    _bm_request.send(JSON.stringify(_bm_event));
};

blocmetrics('tracked_domain', 'event_type')

// = javascript_include_tag "http://kristingonzalez-blocmetrics.herokuapp.com/api/v1/agent.js"
