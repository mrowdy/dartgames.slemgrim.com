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
    		  }
		    },
		    
		    'sftp-deploy': {
          build: {
            auth: {
              host: '10.10.10.5',
              port: 22,
              authKey: 'key1'
            },
            src: 'web',
            dest: '/media/datastore/dartgames',
            server_sep: '/'
          }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-sftp-deploy');
    
    grunt.registerTask('default', ['sass']);
    grunt.registerTask('deploy', ['sass', 'sftp-deploy']);
};