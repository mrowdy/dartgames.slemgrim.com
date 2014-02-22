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
    		    files: ['**/*.scss'],
    		    tasks: ['sass']
    		  }
		    },

		'sftp-deploy': {
          build: {
            auth: {
              host: '188.226.135.234',
              port: 22,
              authKey: 'key1'
            },
            src: 'web',
            dest: '/var/www/dartgames.slemgrim.com/wordpress/wp-content/themes/dartgames',
            server_sep: '/'
          }
        },

        copy: {
            main: {
                files: [
                    {expand: true, src: ['packages/**'], dest: '/web/packages'},
                ]
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-sftp-deploy');
    grunt.loadNpmTasks('grunt-contrib-copy');

    
    grunt.registerTask('default', ['sass']);
    grunt.registerTask('deploy', ['sass', 'sftp-deploy']);
};