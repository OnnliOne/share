<!DOCTYPE html>
<html lang="en" class="h-100">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<!-- Web App Config -->
		<title>{{siteName}} &middot; {% block title %}Temporary File Hosting{% endblock %}</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="theme-color" content="#3367d6">
		<meta name="color-scheme" content="dark light">
		<meta name="apple-mobile-web-app-capable" content="no">
		<meta name="apple-mobile-web-app-title" content="Onn.li Drop">
		<link rel="icon" type="image/png" sizes="32x32" href="/img/favicon-32x32.png">
		<!-- Descriptions -->
		<meta name="description" content="{{SiteMetaInfo}}">
		<meta name="keywords" content="File, Transfer, Share, Peer2Peer">
		<meta name="author" content="Onnli Team">
		<meta property="og:title" content="Onn.li Drop">
		<meta property="og:type" content="article">
		<meta property="og:url" content="https://drop.onn.li/">
		<meta property="og:author" content="https://facebook.com/RobinLinus">
		<meta name="twitter:author" content="@RobinLinus">
		<meta name="twitter:card" content="summary_large_image">
		<meta name="twitter:description" content="Instantly share images, videos, PDFs, and links with people nearby. Peer2Peer and Open Source. No Setup, No Signup.">
		<meta name="og:description" content="Instantly share images, videos, PDFs, and links with people nearby. Peer2Peer and Open Source. No Setup, No Signup.">
		<!-- Icons -->
		<link rel="icon" sizes="96x96" href="images/favicon-96x96.png">
		<link rel="shortcut icon" href="images/favicon-96x96.png">
		<link rel="apple-touch-icon" href="images/apple-touch-icon.png">
		<meta name="msapplication-TileImage" content="images/mstile-150x150.png">
		<link rel="fluid-icon" type="image/png" href="images/android-chrome-192x192.png">
		<meta name="twitter:image" content="https://drop.onn.li/images/twitter-stream.jpg">
		<meta property="og:image" content="https://drop.onn.li/images/twitter-stream.jpg">
		<!-- Resources -->
		<link rel="manifest" href="manifest.json">
		<link rel="stylesheet" href="style.min.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-dark-5@1.1.3/dist/css/bootstrap-nightshade.min.css" integrity="sha256-o4/KvOMbqkanQIhEKRG5j11aFGYHpgfB8Zy8mInEzSU=" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	</head>
	<body class="d-flex h-100 text-center">
		{% block body %}Something went wrong. Try to reload the page.{% endblock %}
		{% include "modals.swig" %}
		<script src="main.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap-dark-5@1.1.3/dist/js/darkmode.min.js" integrity="sha256-TJFCDUJIlHldAZoOahUGxmotcxJRiV2ZwL2ztw/0sZY=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js" integrity="sha512-6PM0qYu5KExuNcKt5bURAoT6KCThUmHRewN3zUFNaoI6Di7XJPTMoT6K0nsagZKk2OB4L7E3q1uQKHNHd4stIQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	</body>
</html>
