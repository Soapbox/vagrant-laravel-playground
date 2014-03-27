<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Vagrant/Laravel Playground</title>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<div class="container">
		<br>
		<div class="jumbotron">
			<h1>Its live!</h1>
			<p>
				You are now running <a href="http://laravel.com/">Laravel</a>
				on <a href="http://www.vagrantup.com/">Vagrant</a>!
			</p>
			<button id="thanks-btn" class="btn btn-primary btn-lg" type="button">
				Thanks!
			</button>
		</div>
		<div>
			<h2>Your server configuration</h2>
			<pre>{{ print_r(Config::get('database', true)) }}</pre>
			<h2>Your database configuration</h2>
			<pre>{{ print_r($_SERVER, true) }}</p>
		</div>
	</div>

	<div id="youre-welcome-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<h2 class="text-center">
					You're Welcome!
				</h2>
			</div>
		</div>
	</div>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="/vendor/jquery/dist/jquery.js"><\/script>')</script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<script src="/js/main.js"></script>
</body>
</html>
