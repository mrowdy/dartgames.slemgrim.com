module.exports = function(grunt) {
    'use strict';
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
     
        sass: {
            build: {
                options: {
                    loadPath: 'res/sass',
                    style: 'expanded',
                    cacheLocation: 'cache/sass'
                },
                files: {
                    'web/assets/css/main.css': 'scss/main.scss'
                }
            }
        },
        
        watch: {
		  scripts: {
		    files: '**/*.scss',
		    tasks: ['sass']
		  },
		},
    });

    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-watch');
    
    grunt.registerTask('default', ['sass']);
};