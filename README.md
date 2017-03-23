# heroku-breakpad-sentry

This is a tiny app to forward Electron breakpad errors to Sentry. It uses Heroku because it's great for low-key services like this one which run in the background.

## Setup

1. Deploy this app to Heroku.
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
