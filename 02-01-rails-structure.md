# Rails directory structure

The `survey_app` directory will have a number of generated files and folders that make up the structure of a Rails application. Most of the work in this tutorial will happen in the `app` folder, but here's a basic rundown on the function of each of the files and folders that Rails creates by default:

| File/Folder | Purpose |
| ----------- | ------- |
|app/|Contains the controllers, models, views, helpers, mailers, channels, jobs, and assets for your application. You'll focus on this folder for the remainder of this guide.|
|bin/|Contains the `rails` script that starts your app and can contain other scripts you use to set up, update, deploy, or run your application.|
|config/|Contains configuration for your application's routes, database, and more.|
|config.ru|Rack configuration for Rack-based servers used to start the application. For more information about Rack, see the [Rack website](https://rack.github.io/).|
|db/|Contains your current database schema, as well as the database migrations.|
|Gemfile<br>Gemfile.lock|These files allow you to specify what gem dependencies are needed for your Rails application. These files are used by the Bundler gem. For more information about Bundler, see the [Bundler website](https://bundler.io).|
|lib/|Extended modules for your application.|
|log/|Application log files.|
|public/|Contains static files and compiled assets. When your app is running, this directory will be exposed as-is.|
|Rakefile|This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing `Rakefile`, you should add your own tasks by adding files to the `lib/tasks` directory of your application.|
|README.md|This is a brief instruction manual for your application. You should edit this file to tell others what your application does, how to set it up, and so on.|
|storage/|Active Storage files for Disk Service. This is covered in [Active Storage Overview](active_storage_overview.html).|
|test/ or spec/|Unit tests, fixtures, and other test apparatus. These are covered in [Testing Rails Applications](testing.html).|
|tmp/|Temporary files (like cache and pid files).|
|vendor/|A place for all third-party code. In a typical Rails application this includes vendored gems.|
|.gitignore|This file tells git which files (or patterns) it should ignore. See [GitHub - Ignoring files](https://help.github.com/questions/ignoring-files) for more information about ignoring files.|
|.ruby-version|This file contains the default Ruby version.|