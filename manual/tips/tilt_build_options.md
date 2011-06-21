title: Tilt build options
--
Add these to `Protonfile`.

Optional options for layout engines.
    
    tilt_options:
      haml:
        escape_html: true
      scss:
        load_paths: [ 'css' ]
        style: :compact
        line_numbers: true
   
To disable CSS compression on the output, add these to your `Protonfile`:

    tilt_build_options:
      scss:
        style: :compact
        line_numbers: false
