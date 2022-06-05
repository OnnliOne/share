<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="Description" content="{{SiteMetaInfo}}">
		<title>{{siteName}} &middot; {% block title %}Temporary File Hosting{% endblock %}</title>
		<link rel="icon" type="image/png" sizes="32x32" href="/img/favicon-32x32.png">
		<link rel="stylesheet" href="style.min.css">
		<script src="main.min.js"></script>
	</head>
	<body>
		<div class="container">
			{% block body %}Something went wrong. Try to reload the page.{% endblock %}
		</div>
	</body>
</html>
