Blocmetrics

Blocmetrics is a simple api that you can use to track events on your website.

Configuration

To use Blocmetrics you simply need to add the following snippet right above the </body> tag on every page that you want to monitor events on:

<!-- blocmetrics -->
  <script language="javascript" type="text/javascript">
var blocmetrics = {
    report: function(auth_token, event_type) {
        var _bm_event = {
            auth_token: auth_token,
            event_type: event_type
        }

        var _bm_request = new XMLHttpRequest();
        _bm_request.open("POST", "//kristingonzalez-blocmetrics.herokuapp.com/api/v1/events.json", true);
        _bm_request.setRequestHeader('Content-Type', 'application/json');
        _bm_request.onreadystatechange = function () {

        };


        _bm_request.send(JSON.stringify(_bm_event));
    }
}
  </script>
Once you've added the script, you're events will be tracked and you can view them on your dashboard.


You can add send custom attributes with each event by changing the properties sent on the _bm_event variable.

For example
```blocmetrics.report("your_auth_token", "event_type(i.e. "page_view" or "click")")```