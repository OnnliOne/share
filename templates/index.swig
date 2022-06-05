{% extends "layout.swig" %}
{% block body %}
<div class="cover-container d-flex w-100 h-100 p-3 text-white mx-auto flex-column">
	{% include "nav.swig" %}
	<main class="px-3">
		<img src="img/onnli-share.png" />
		<h1>Temporary File Sharing</h1>
		<p class="lead">Max upload size is {{max_upload_size}}&nbsp;MiB & files expire after 24H</p>
		{% include "banners.swig" %}
		{% include "upload_form.swig" %}
	</main>
	{% include "footer.swig" %}
</div>
{% endblock %}
