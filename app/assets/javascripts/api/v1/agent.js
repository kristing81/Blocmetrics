var trackableEvent = function (tracked_domain_id, event_type) {
    var _bm_event = {
        tracked_domain_id: tracked_domain_id,
        event_type: event_type
}

    var _bm_request = new XMLHttpRequest();
    _bm_request.open("POST", "http://localhost:4000.com/events.json", true);
    _bm_request.setRequestHeader('Content-Type', 'application/json');
    _bm_request.onreadystatechange = function () {

    }

  $(document).ready(function(){
    trackableEvent("your-tracked_domain-id", "page view", window.location.origin)
})

_bm_request.send(JSON.stringify(_bm_event));




// = javascript_include_tag "http://kristingonzalez-blocmetrics.herokuapp.com/api/v1/agent.js"

