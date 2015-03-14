##Blocmetrics

Blocmetrics is a simple api that you can use to track events on your website.

Comprised of the following:
- Client-side Javascript snippet that allows a user track events on their website.

- Server-side API that captures and saves those events to a database.

- Rails application that displays the captured event data for a user.

##Configuration

- Sign Up and add your domain to your Tracked Domain list.
- Add a link to our Javascript file in your site. Copy and paste the below script tag to your application file. 
```
//kristingonzalez-blocmetrics.herokuapp.com/agent.js
```
- Watch your site's activity get tracked in your Events log. Use your authentication token to submit custom events like this. 
```
blocmetrics.report("your_auth_token", "event_type(i.e. "page_view" or "click")")
```
- Once you've added the script, your events will be tracked and you can view them on your dashboard.


View the live app [here](http://kristingonzalez-blocmetrics.herokuapp.com/).

Built using:
- Rails 4
- Flatly Bootswatch Theme
- HAML
- HTTParty
- Nokogiri

![alt text](/public/Blocmetrics Home.png "Blocmetrics Home")

