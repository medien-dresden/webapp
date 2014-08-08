module.exports = (grunt) ->

  #
  # load NPM tasks
  #
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  #
  # register custom tasks
  #
  grunt.registerTask 'scripts:debug', ['coffee:default', 'ngAnnotate', 'uglify:debug']
  grunt.registerTask 'scripts:debugApp', ['coffee:default', 'ngAnnotate', 'uglify:debugApp']
  grunt.registerTask 'scripts:release', ['coffee:default', 'ngAnnotate', 'uglify:release', 'karma']
  grunt.registerTask 'styles:debug', ['compass:debug']
  grunt.registerTask 'styles:release', ['compass:release']
  grunt.registerTask 'html:debug', ['jade:debug']
  grunt.registerTask 'html:release', ['jade:release']

  grunt.registerTask 'release', ['clean', 'bowercopy', 'scripts:release', 'styles:release', 'html:release', 'protractor']
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
        dest: '.build'
        ext: '.js'
        src: ['src/**/*.coffee']

    #
    # jade templates to HTML
    #
    jade:
      release:
        options:
          data: -> isRelease: true
        files: 'dist/index.html': ['src/app.jade']
      debug:
        options:
          pretty: true
        files: 'dist/index.html': ['src/app.jade']

    #
    # SCSS to CSS
    #
    compass:
      options:
        sassDir: 'src/style'
        cssDir: 'dist/static'
        cacheDir: '.build/sass'
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
        options:
          preserveComments: 'some'
        files:
          'dist/static/app.js': ['.build/src/**/*.js']
          'dist/static/vendor.js': ['.build/vendor/**/*.js']
      debug:
        options:
          mangle: false
          beautify: true
          sourceMap: true
          sourceMapName: 'dist/app.map'
        files:
          'dist/static/app.js': ['.build/src/**/*.js']
          'dist/static/vendor.js': ['.build/vendor/**/*.js']
      debugApp:
        options:
          mangle: false
          beautify: true
          sourceMap: true
          sourceMapName: 'dist/app.map'
        files:
          'dist/static/app.js': ['.build/src/**/*.js']

    #
    # angular js injection preparation
    #
    ngAnnotate:
      options: singleQuotes: true
      files:
        expand: true,
        src: ['.build/src/**/*.js'],
        rename: (dest, src) -> src

    #
    # clean workspace
    #
    clean: ['.build', 'dist', 'reports']

    #
    # watch different aspects
    #
    watch:
      options: livereload: true

      scripts:
        files: [
          'src/app/**/*.coffee'
          'test/unit/**/*.coffee'
        ]

        tasks: ['scripts:debugApp', 'karma']

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
          '02_bootstrap.js': 'bootstrap/dist/js/bootstrap.js'
          '03_angular.js': 'angular/angular.js'
          '04_lodash': 'lodash/dist/lodash.js'

      assets:
        options: destPrefix: 'dist/static'
        files:
          'fonts': 'bootstrap/dist/fonts/*'

    #
    # karma unit testing
    #
    karma:
      default:
        configFile: 'test/karma.conf.coffee'

    #
    # protractor end-to-end testing
    #
    protractor:
      default:
        configFile: 'test/protractor.conf.coffee'
