## Review-O-Matic

Web page and tools to assist migration of a website. In conjuction with the Migratorator (https://github.com/alphagov/migratorator) it shows the old URL and new URL in a side-by-side browser view and enables reviewing of the mappings (Looks Good/I'm not sure/Seems Wrong).

To create a user for development run: 

```sh
	$ bundle exec rake db:setup
	$ bundle exec rake db:seed
```

To login to Review-O-Matic with this user, go to the path:

http://reviewomatic.dev.gov.uk/__/sign_in?access_token=password

To create actual users:

Copy a list of their emails to somewhere on the production box and then run the rake task

```sh
	$ bundle exec rake db:create_users[/path/to/your/file/of/users]
```

In preview and production you need to prefix this with RAILS_ENV=production (NB. production for both).

This task creates users for the email addresses given if they do not already exist, then emails all users (whether created by script or already existing) with their login details.

Keep an eye on the rake task as when it has finished it will print out a list of ones that failed, e.g. invalid email addresses.

NOTE:

The application currently does not include additional assets for compilation as standard. In order to compile these assets they will have to be added to the array in config/production.rb



