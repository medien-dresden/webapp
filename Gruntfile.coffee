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
  grunt.registerTask 'styles:debug', ['compass:debug', 'recess:debug']
  grunt.registerTask 'styles:release', ['compass:release', 'recess:release']

  grunt.registerTask 'release', ['clean', 'bowercopy', 'scripts:release', 'styles:release', 'jade:release']
  grunt.registerTask 'debug', ['clean', 'bowercopy', 'scripts:debug', 'styles:debug', 'jade:debug']

  grunt.registerTask 'default', ['debug']

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
      release:
        options:
          sassDir: 'src/style'
          cssDir: '.build/style'
          environment: 'production'
      debug:
        options:
          sassDir: 'src/style'
          cssDir: '.build/style'
          environment: 'development'
          outputStyle: 'expanded'

    #
    # combine CSS files
    #
    recess:
      release:
        options: compress: true
        files: 'dist/style.css': [ '.build/**/*.css' ]
      debug:
        options:
          compile: true
          noOverqualifying: false
          noUniversalSelectors: false
          strictPropertyOrder: false
          noIDs: false
          zeroUnits: false
        files: 'dist/style.css': [ '.build/**/*.css' ]

    #
    # combine javascript files
    #
    uglify:
      release:
        options: preserveComments: 'some'
        files:
          'dist/app.js': ['.build/app/**/*.annotated.js']
          'dist/vendor.js': ['.build/vendor/**/*.js']
      debug:
        options:
          mangle: false
          beautify: true
          sourceMap: true
          sourceMapName: 'dist/app.map'
        files:
          'dist/app.js': ['.build/app/**/*.annotated.js']
          'dist/vendor.js': ['.build/vendor/**/*.js']
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

      jade:
        files: 'src/**/*.jade',
        tasks: ['jade:debug']

    #
    # copy dependencies into build
    #
    bowercopy:
      options: destPrefix: '.build/vendor'
      default:
        files: 'angular.js': 'angular/angular.js'
