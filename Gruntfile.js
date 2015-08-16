module.exports = function(grunt) {

    grunt.loadNpmTasks('grunt-screeps');

    grunt.initConfig({
        screeps: {
            options: {
                email: 'bigforcegun@gmail.com',
                password: '@ZV3wGy@PSUB',
                branch: 'default'
            },
            dist: {
                src: ['app/**/*.js']
            }
        }
    });
}