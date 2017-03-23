# electron-breakpad-sentry

This is a tiny app to forward Electron breakpad errors to Sentry. It's the easiest way to process and store Electron crashes data.

## Setup

1. [![Deploy it on Heroku!](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy).
2. Set the SENTRY_DSN environment variable to the value of the Sentry project you're using.
3. Set up your electron project to forward errors to this app. Usually something like this should be enough:
```
const { app, crashReporter } = require('electron');

app.on('ready', () => {
 crashReporter.start({
 productName: 'YourAppName',
 companyName: 'YourCompany',
 submitURL: '$YOUR_HEROKU_APP_URL/crashreport',
 autoSubmit: true
 });
```
4. Profit!

## Bug, remarks, questions?

If you've found any bug, please let me know by opening a new issue.
