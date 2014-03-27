module.exports = function (grunt) {

	"use strict";

	// Project configuration.
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		jshint: {
			options: {
				jshintrc: ".jshintrc"
			},
			all: [
				'Gruntfile.js',
				'public/js/*.js'
			]
		},

		watch: {
			files:  [
				'Gruntfile.js',
				'public/js/*.js'
			],
			tasks: 'jshint'
		}
	});

	// Load the plugins
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-watch');

	// Default task(s).
	grunt.registerTask('default', ['jshint']);

};
