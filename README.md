# Community web application

This is a [Community web application](https://rails-community-app.herokuapp.com/)
to meet needs of small communities like sport clubs and non-governmental
organisations.

This application is based on the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).
Thank you for this great Rails tutorial!

## License

All source code in the [Community web application](https://rails-community-app.herokuapp.com/)
and in the [Ruby on Rails Tutorial](http://railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and copy .env file:

```bash
cat config/templates/.env.sample > .env
```

### Using Rails credentials

This application uses Rails credentials. New credentials should be stored
in the file config/credentials.yml.enc,
as [described in this tutorial](https://medium.com/cedarcode/rails-5-2-credentials-9b3324851336).

Use the Heroku config command to
[setup config vars](https://devcenter.heroku.com/articles/config-vars) and
set the `RAILS_MASTER_KEY` variable:

```bash
heroku config:set RAILS_MASTER_KEY=<your-master-key>
```

## Set up project with Docker

Docker is a full development platform for creating containerized applications.
Docker Desktop is the best way to get started with Docker.

### System requirements

- MacOS command line developer tools:
  - `sudo xcode-select --install`
- [homebrew](http://brew.sh) - package manager for OSX
  - `brew install git watch jq`
- Install [Docker Desktop](https://docs.docker.com/docker-for-mac/install/)
  - `brew cask install docker`

### Run the app

- Now you are ready to start the services for this app, start the web server
and do your work.

```bash
make up
```

- You can access the logs by:

```bash
make logs-web
```

## Testing

Run the test suite to verify that everything is working correctly:

```bash
make test
```

If the test suite passes, you'll be ready to run the app in a local server.

### Automated tests with Guard

Use Guard to automate the running of the tests and code styles with
[Rubocop](https://rubocop.readthedocs.io/en/latest/).

```bash
make guard
```

## Production webserver

This app uses Puma webserver that is suitable for production applications on
Heroku platform (cloud platform as a service).
See [Heroku Puma documentation](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server).

### Heroku application setup

You have to create and configure a new Heroku account.
The first step is to [sign up for Heroku](http://signup.heroku.com/).
Then check to see if your system already has the
[Heroku command-line client installed](https://devcenter.heroku.com/articles/heroku-cli):

```bash
heroku version
```

Use the Heroku command to log in and
[add your SSH key](https://help.github.com/articles/connecting-to-github-with-ssh/):

```bash
heroku login
heroku keys:add
```

Finally, use the Heroku create command to create a place on the Heroku servers
for the community app to live:

```bash
heroku create
```

Rename the application as follows:

```bash
heroku rename <your-heroku-app>
```

You can change your Heroku git remote any time:

```bash
heroku git:remote -a <your-heroku-app>
```

#### MemCachier

[MemCachier](https://www.memcachier.com/) is an implementation of the Memcache
in-memory key/value store used for
[caching data](https://devcenter.heroku.com/articles/memcachier#rails).

Installing the add-on:

```bash
heroku addons:create memcachier:dev
```

#### Custom domain

In addition to supporting subdomains, Heroku also supports custom domains.
See the [Heroku documentation](http://devcenter.heroku.com/)
for more information about custom domains.

#### SSL

If you want to run SSL on a custom domain, such as www.example.com, refer to
[Heroku’s documentation on SSL](http://devcenter.heroku.com/articles/ssl).

### Application mailer

This app uses the Action Mailer library in account activation step to verify that
the user controls the email address they used to sign up.

#### Add SendGrid add-on to Heroku

To send email, this app uses SendGrid, which is available as an add-on at Heroku
for verified accounts. The “starter” tier, which as of this writing is limited
to 400 emails a day but costs nothing, is the best fit.

Add it to community app as follows:

```bash
heroku addons:create sendgrid:starter
```

#### Define a host variable

You will also have to define a **host** variable with the address of your
production website. Use the Heroku config command to
[setup config vars](https://devcenter.heroku.com/articles/config-vars) and
set the `host` variable:

```bash
heroku config:set APP_MAILER_HOST=<your-app-name.heroku.com>
```

If you use custom domain, please change it too your custom host:

```bash
heroku config:set APP_MAILER_HOST=<your-domain.com>
```

### Change community (provider) identification

Add default address of your organization in Heroku:

```bash
heroku config:set ADDRESS_OF_THE_ORGANIZATION=<'</br>address 1</br>address 2</br>zip code city'>
```

You can add official register or sales tax identification number or commercial
register number

```bash
heroku config:set IDENTIFICATION_NUMBER=<'<b>District Court Charlottenburg:</b> XY ##### Z'>
```

Add a phone number of your organization:

```bash
heroku config:set PHONE_NUMBER_OF_THE_ORGANIZATION=<'010 20 345 6789'>
```

And finally, add a membership application url:

```bash
heroku config:set MEMBERSHIP_APPLICATION_URL=<'membership application url'>

```

### Contact mailer

#### Default TO address

Change default **TO** email address for contact mailer

```bash
heroku config:set CONTACT_MAIL_TO=<your-contact@email-adress.de>
```

#### Contact mailer templates (optional)

Change two view templates (if needed) for each mailer,
one for plain-text email and one for HTML email, found in
**app/views/contact_mailer/contact.text.slim** and
**app/views/contact_mailer/contact.html.slim**

### Account activation and password reset mailer

#### Default from address

Change default **from** address, which is common to all mailers in the
application, can be found in **app/mailers/application_mailer.rb**

#### Mailer layout (optional)

Change mailer layout corresponding to the email format,
which is common to all mailers in the application.
The HTML and plain-text mailer layouts can be found under **app/views/layouts**

#### Account activation and password reset mailer templates (optional)

Change two view templates (if needed) for each mailer,
one for plain-text email and one for HTML email, found in
**app/views/user_mailer/account_activation.text.slim**,
**app/views/user_mailer/account_activation.html.slim**,
**app/views/user_mailer/password_reset.html.slim** and
**app/views/user_mailer/password_reset.text.slim**

### Picture uploader to Google Cloud Storage

This app needs Google Cloud Storage service to store images separately
from application.
To store images, this app uses [fog-google](https://github.com/fog/fog-google/blob/master/README.md)
and google-api-client gems.

#### Google Cloud Platform setup

You have to create a new Google account for this app or use existing account.
The first step is to [sign up for Google Cloud Platform](https://console.cloud.google.com).

[Add a new project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
to your Google Cloud Platform entering a name of your
choice, e.g. '**your-heroku-app**'.

Then, [enable billing for your project](https://support.google.com/cloud/answer/6293499#enable-billing)
and link this billing account to your new project.

#### Google Cloud Storage setup

This app needs a bucket inside your Google Cloud Storage.
Open the [Cloud Storage browser](https://console.cloud.google.com/storage/)
in the Google Cloud Platform Console and click **CREATE BUCKET**.

Setup your bucket as [described](https://cloud.google.com/storage/docs/quickstart-console),
e.g. with the name **communityapp**.

Turn on [Interoperability API](https://cloud.google.com/storage/docs/migrating#keys)
for your Google Cloud Platform project and click **Create a new Key**
to get an **Access Key** and a **Secret**.

#### Heroku config vars setup

Setup Rails credentials as described in chapter [Using Rails credentials](#using-rails-credentials) for
[Google Cloud Storage](https://github.com/carrierwaveuploader/carrierwave#using-google-storage-for-developers)
using Google's interoperability `keys` to access it:

```bash
  g_storage:
    access_key: <your-access-key>
    secret_key: <your-secret>
```

Finally, use the Heroku config command to
[setup config vars](https://devcenter.heroku.com/articles/config-vars) and
set Google Storage `picture upload directory`:

```bash
heroku config:set G_STORAGE_PICTURE_UPLOAD_DIRECTORY=<your-bucket-name, e.g. 'communityapp'>
```

Hint: In order to use these [vars in development environment](http://www.rubydoc.info/gems/dotenv-rails/2.2.1),
you should add them with right values to **.env** file in the root of
your project.

### Google reCAPTCHA

This App adds [reCAPTCHA API (V2)](https://www.google.com/recaptcha) in order to
use state of the art spam and abuse protection.
Obtain a [reCAPTCHA API key](https://www.google.com/recaptcha/admin) and make
sure to set up appropriate Rails credentials:

```bash
  g_recaptcha:
    site_key: <your-site-key>
    secret_key: <your-secret-key>
```

### Google Maps

The Community App uses [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript) in
order to show directions map on e.g. contact page. Similar to picture upload to
Google Cloud Storage, obtain a Google Maps **API Key** from
Google Cloud Platform, [APIs and Services Credentials](https://console.cloud.google.com/apis/credentials)
and make sure to set up in Heroku your position to show in the map:

```bash
heroku config:set G_MAPS_LAT=<your-position-latitude>
heroku config:set G_MAPS_LNG=<your-position-longitude>
```

and `api_key` in Rails credentials:

```bash
  g_maps:
    api_key: <your-apis-key>
```

Finally, go to [Dashboard](https://console.cloud.google.com/apis/dashboard) and enable
[Google Maps Embaded API](https://console.cloud.google.com/apis/api/maps-embed-backend.googleapis.com/overview) and
[Google Maps JavaScript API](https://console.cloud.google.com/apis/api/maps-backend.googleapis.com/overview).

### Google G Suite Admin (optional)

You can use Google G Suite in order to use emails, shared calendars and more in
your community. One of set up steps is to **Verify your domain and set up email**.
In this step you will get a `google-site-verification` token, which you have to
set up in Rails credentials:

```bash
  g_site:
    verification: <your-tag-content>
```

### Facebook page posts (optional)

You can use Facebook App to get public posts from some certain public pages
(e.g. facebook page of your community).
After that, the most recent posts will be displayed under news feed of your
community app.

#### Facebook App setup

Login to [Facebook for Developers](https://developers.facebook.com/apps/) and click
"Add a New App" in order to create new Facebook App.
Go to Facebook App Settings > Advanced > Security and
switch "Require App Secret" to "Yes".

#### Facebook App config vars setup

Finally, use the Heroku config command
to [setup config vars](https://devcenter.heroku.com/articles/config-vars)
for Facebook page.

```bash
heroku config:set FB_PAGE_ID=<your-fb-page-id>
```

Also, setup `app_id` and `app_secret` for development, test and production
environment in Rails credentials:

```bash
  fb:
    app_id: <your-fb-app-id>
    app_secret: <your-fb-app-secret>
```

You will find the Facebook App ID and Facebook App SECRET on
your Facebook App Dashboard.
Use [https://findmyfbid.com/](https://findmyfbid.com/) in order to find
facebook page ID of your community.

### Change logo (brand) and generate favicon

Replace **assets/images/logo.png** with a logo of your community.
Make sure this logo has a **transparent background** and a size of
approximately **260x260**.
In order to create a logo you can use [ImageMagick](http://www.imagemagick.org),
for example with convert command:

```bash
convert big-logo.png -resize 260x260 logo.png
convert logo.png -transparent '#ffffff' logo.png
```

You can setup your favicon in your Ruby on Rails project
with **rails_real_favicon** gem and/or using
[Favicon Generator for Ruby on Rails](https://realfavicongenerator.net/favicon/ruby_on_rails).

Your picture should be 260x260 or more for optimal results.

### Change images for introduction carousel

Replace images for carousel items with images of your community
can be found under **assets/images/introduction/**.

Make sure these images have size of **1170x312**, depth of **8 bit** and
do **not exceed 200 kb**.
In order to create these images you can
use [ImageMagick](https://www.imagemagick.org/Usage/resize/#fill),
for example with convert command:

```bash
convert item-0.png -resize 1170x312^ -gravity center -extent 1170x312+0-50 item-0.png
convert item-0.png -depth 8 item-0.png
convert item-0.png -trim -flatten item-0.jpg
```

You can change gravity in any direction, like South or East, and use an
offset (e.g. x: +0, y: -50).

### Deploying to Heroku

Before deploying to Heroku, it’s a good idea to turn maintenance mode on
before making the changes:

```bash
heroku maintenance:on
```

Use the Heroku config command to set first admin user data:

```bash
heroku config:set ADMIN_NAME=<your-admin-first-and-last-name>
heroku config:set ADMIN_EMAIL=<your-admin-email>
```

And setup the default admin `password` in Rails credentials:

```bash
  admin:
    password: <your-admin-password>
```

Commit the file changes and push to git and then to Heroku:

```bash
git commit -a -m "Change defaults for admin"
git push
git push heroku
```

Migrate or reset the production database:

```bash
heroku run rails db:migrate
```

To reset the production database use:

```bash
heroku pg:reset DATABASE
```

After the production database reset, seed the database with start users and
admin (Rails uses the standard file **db/seeds.rb**):

```bash
heroku run rails db:seed
```

In case you added or changed gems or gem version, please do not forget to
restart Heroku:

```bash
heroku restart
```

And finally, turn maintenance mode off:

```bash
heroku maintenance:off
```

## Spring processes

Whether something isn’t behaving as expected, or a process appears to be frozen,
it’s a good idea to run

```bash
ps aux | grep spring
```

to see what’s going on, and then run

```bash
spring stop
```

To kill all the spring processes gunking up your system.

Sometimes this doesn’t work, though, and you can kill all the processes with
name spring using the pkill command as follows:

```bash
pkill -15 -f spring
```

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).

## RuboCop static code analyzer

Check code with [RuboCop](https://rubocop.readthedocs.io) before committing to
Git repository. Run in the project directory:

```bash
rubocop -FREa -C true
```

## Brakeman security scanner

Check security with [Brakeman](https://brakemanscanner.org/docs/introduction/)
before committing to Git repository. Run in the project directory:

```bash
brakeman -AI
```

## Manage license dependencies

Check dependencies with [license_finder](http://www.rubydoc.info/gems/license_finder),
detect the licenses and compare those licenses against a whitelist.
Run in the project directory:

```bash
license_finder
```

**license_finder** will inform you whenever you have an unapproved dependency.
To approve the dependency for all gems with MIT license run e.g.:

```bash
license_finder whitelist add 'MIT' --who '...' --why 'free to use'
```

or for one gem only run:

```bash
license_finder approval add awesome_gpl_gem --who '...' --why 'free to use'
```
