module.exports = (grunt)->

    

    grunt.loadNpmTasks 'grunt-bower-concat'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.initConfig
        pkg: require('./bower.json')
        bower_concat:
            tests:
                dest: 'tests/libs.js'
                cssDest: 'tests/libs.css'

        coffee:
            tests:
                options:
                    join: false
                    sourceMap: false
                    bare: true

                expand: true
                cwd: 'src'
                src: [
                    '**/*.coffee'
                ]
                dest: 'tests/'
                ext: '.js'

            tmp:
                options:
                    join: false
                    sourceMap: false
                    bare: true

                expand: true
                cwd: 'src'
                src: [
                    '**/*.coffee'
                ]
                dest: 'tmp/'
                ext: '.js'

        concat:
            build:
                options:
                    banner: """
                        //     <%= pkg.name %>.js <%= pkg.version %>
                        //     <%= pkg.homepage %>
                        //     (c) 2015 Nick Iv (studio@nim579.ru)
                        //     <%= pkg.name %> may be freely distributed under the <% pkg.license %> license.

                    """

                files:
                    'lib/app.js': ['tmp/app.js']

        watch:
            coffee:
                files: ['src/*.coffee']
                tasks: ['coffee:tests']

    grunt.registerTask 'build', ['coffee:tmp', 'concat:build']
