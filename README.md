# Fastmail Delayed Rules

Fastmail filtering rules, and even advanced Sieve filtering, can only operate on emails as they arrive. In order to operate on emails after a delay, custom scripting must be used. For example, if you receive USPS's Daily Digest email, you probably only care about them for a few hours. This script allows those emails to show up in your inbox, and then automatically get archived a few hours later.

This script takes a custom config file, and performs the requested actions on a Fastmail email inbox. The config file allows you to specify actions on certain emails after a custom delay.

## Writing rules

Each object in the [config](./src/config.ts) list has 3 fields:

* `name` - Give your config item a name
* `search` - Options for finding emails
  * `in`: Either `inbox` or `archive`, specifying which inbox to look in
  * `before`: Number of hours in the past to start acting on emails. If you want to ignore emails that arrived in the last 6 hours, use `hoursBefore(6)`
  * `from`: Search for certain senders
  * `subject`: Search by subject
  * `isUnread`: Restrict to only unread messages
  * `allowPreventArchive`: If `true`, ignore messages with the Fastmail label of "Prevent Archive"
* `action`: Which actions to perform on found emails
  * `archive`: Archive the email(s)
  * `markRead`: Mark email(s) as read

## Running the script locally

### Authorization

⚠️ **WARNING**: _Never_ commit your authorization token to git!

Access must be granted to your Fastmail inbox in order for the script to work. To generate an Authorization token, run

    $ ./generateAuthorization.sh

Then set the `AUTHORIZATION` environment variable to the output string. Alternatively, add it to a `.env` file in the root of the project:

    AUTHORIZATION=Authorization: Basic <token>

### Building

The script is build with Typescript. After you update the `config.ts` file with your new rules, build the code by running:

    $ npm install
    $ npm run build

### Running

After building, run the script with

    $ npm run mail

## Get the script to run automatically

You can use your favorite CRON environment to run the script at regular intervals. To run it using Github Workflows, use the following instructions:

1. Fork this repository
2. Go to your fork repository's "Settings" page. Under the "Environments" tab, click "production". At the bottom of that page, click "Add secret". Set the name to "AUTHORIZATION", and set the value to the output of [generateAuthorization.sh](./generateAuthorization.sh).
3. Make your personalized edits to the [src/config.ts](./src/config.ts) file, and push them to your fork.
4. Go to your fork repository's "Actions" page. See if the "Process mail" job had a successful run. If it was successful, check your Fastmail inbox for the script's changes!

The job will run automatically every 3 hours. Edit [process_mail.yml](.github/workflows/process_mail.yml) to tweak the interval.
