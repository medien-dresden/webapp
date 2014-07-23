module.exports = (grunt) ->

  #
  # load NPM tasks
  #
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  #
  # register custom tasks
  #
  grunt.registerTask 'scripts:debug', ['coffee:default', 'ngAnnotate', 'uglify:debug']
  grunt.registerTask 'scripts:release', ['coffee:default', 'ngAnnotate', 'uglify:release']
  grunt.registerTask 'styles:debug', ['compass:debug']
  grunt.registerTask 'styles:release', ['compass:release']
  grunt.registerTask 'html:debug', ['jade:debug']
  grunt.registerTask 'html:release', ['jade:release']

  grunt.registerTask 'release', ['clean', 'bowercopy', 'scripts:release', 'styles:release', 'html:release']
  grunt.registerTask 'debug', ['clean', 'bowercopy', 'scripts:debug', 'styles:debug', 'html:debug']

  grunt.registerTask 'default', ['release']

  #
  # grunt configuration
  #
  grunt.initConfig

    #
    # coffee files to javascript
    #
    coffee:
      default:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: '.build'
        ext: '.js'

    #
    # jade templates to HTML
    #
    jade:
      release:
        files: 'dist/index.html': ['src/app.jade']
      debug:
        options:
          pretty: true
          data: () -> isDebug: true
        files: 'dist/index.html': ['src/app.jade']

    #
    # SCSS to CSS
    #
    compass:
      options:
        sassDir: 'src/style'
        cssDir: 'dist/static'
      release:
        options:
          environment: 'production'
      debug:
        options:
          environment: 'development'
          outputStyle: 'expanded'

    #
    # combine javascript files
    #
    uglify:
      release:
        options: preserveComments: 'some'
        files:
          'dist/static/app.js': ['.build/app/**/*.annotated.js']
          'dist/static/vendor.js': ['.build/vendor/**/*.js']
      debug:
        options:
          mangle: false
          beautify: true
          sourceMap: true
          sourceMapName: 'dist/app.map'
        files:
          'dist/static/app.js': ['.build/app/**/*.annotated.js']
          'dist/static/vendor.js': ['.build/vendor/**/*.js']
    #
    # angular js injection preparation
    #
    ngAnnotate:
      options: singleQuotes: true
      files:
        expand: true,
        src: ['.build/app/**/*.js'],
        ext: '.annotated.js'

    #
    # clean workspace
    #
    clean: ['.sass-cache', '.build', 'dist']

    #
    # watch different aspects
    #
    watch:
      options: livereload: true

      scripts:
        files: 'src/app/**/*.coffee'
        tasks: ['scripts:debug']

      styles:
        files: 'src/style/**/*.{scss,sass}'
        tasks: ['styles:debug']

      html:
        files: 'src/**/*.jade',
        tasks: ['html:debug']

    #
    # copy dependencies
    #
    bowercopy:
      scripts:
        options: destPrefix: '.build/vendor'
        files: # ordering through number prefix
          '01_jquery.js': 'jquery/dist/jquery.js'
          '02_bootstrap.js': 'bootstrap-sass-official/assets/javascripts/bootstrap.js'
          '03_angular.js': 'angular/angular.js'

      assets:
        options: destPrefix: 'dist/static'
        files:
          'fonts': 'bootstrap-sass-official/assets/fonts/bootstrap/*'
