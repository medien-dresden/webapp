module.exports = (grunt) ->

  #
  # load NPM tasks
  #
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  #
  # register custom tasks
  #
  grunt.registerTask 'scripts:debug', ['coffee:default', 'uglify:debug']
  grunt.registerTask 'scripts:release', ['coffee:default', 'uglify:release']
  grunt.registerTask 'styles:debug', ['compass:debug', 'recess:debug']
  grunt.registerTask 'styles:release', ['compass:release', 'recess:release']

  grunt.registerTask 'release', ['clean', 'scripts:release', 'styles:release', 'jade:release']
  grunt.registerTask 'debug', ['clean', 'scripts:debug', 'styles:debug', 'jade:debug']

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
        files:
          'dist/index.html': ['src/app.jade']
      debug:
        options:
          pretty: true
          data: () -> isDebug: true
        files:
          'dist/index.html': ['src/app.jade']

    #
    # SCSS to CSS
    #
    compass:
      release:
        options:
          sassDir: 'src/style'
          cssDir: '.build'
          environment: 'production'
      debug:
        options:
          sassDir: 'src/style'
          cssDir: '.build'
          environment: 'development'
          outputStyle: 'expanded'

    #
    # combine CSS files
    #
    recess:
      release:
        options:
          compress: true
        files:
          'dist/app.css': [ '.build/*.css' ]
      debug:
        options:
          compile: true
          noOverqualifying: false
          noUniversalSelectors: false
          strictPropertyOrder: false
          noIDs: false
          zeroUnits: false
        files:
          'dist/app.css': [ '.build/*.css' ]

    #
    # combine javascript files
    #
    uglify:
      release:
        files:
          'dist/app.js': ['.build/**/*.js']
      debug:
        options:
          beautify: true
          sourceMap: true,
          sourceMapName: 'dist/app.map'
        files:
          'dist/app.js': ['.build/**/*.js']

    #
    # clean workspace
    #
    clean: ['.sass-cache', '.build', 'dist']

    #
    # watch different aspects
    #
    watch:
      options:
        livereload: true
      scripts:
        files: 'src/app/**/*.coffee'
        tasks: ['scripts:debug']

      styles:
        options:
          livereload: true
        files: 'src/style/**/*.{scss,sass}'
        tasks: ['styles:debug']

      jade:
        options:
          livereload: true
        files: 'src/**/*.jade',
        tasks: ['jade:debug']
