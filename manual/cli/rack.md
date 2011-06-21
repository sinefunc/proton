title: proton rack
--
Makes a Proton project Rack-compatible.

##  Usage

    $ proton rack

## Description

   The current project will be Rack compatible by creating a config.ru and 
   Gemfiles.

##  Example

  Create a project:

    ~$ proton create my_project

    ~$ cd my_project

  Now, make it Rack compatible:

    ~/my_project$ proton rack

    create   Gemfile
    create   Gemfile.lock
    create   config.ru

  Now try running it as a Rack application.

    ~/my_project$ thin start
    
    >> Using rack adapter
    >> Thin web server (v1.2.7 codename No Hup)
    >> Maximum connections set to 1024
    >> Listening on 0.0.0.0:9393, press Ctrl+C to stop
