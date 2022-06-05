<form id="upload-form" enctype="multipart/form-data" method="post" action="upload.php?output=html">
	<div class="d-grid gap-2">
		<button type="button" id="upload-btn" class="btn btn-primary btn-lg"><i class="fa-solid fa-upload"></i> Click Here or Drag or Drop</button>
	</div>
	<input type="file" id="upload-input" class="form-control" name="files[]" multiple
		data-max-size="{{max_upload_size}}MiB">
	<input type="submit" value="Submit">
</form>
<div class="d-flex justify-content-center">
	<div class="form-check">
		<input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked disabled>
		<label class="form-check-label text-white-50" for="flexCheckChecked">
			By uploading you agree with our <a href="#" data-bs-toggle="modal" data-bs-target="#modal-terms-and-conditions">terms and conditions of use</a>.
		</label>
	</div>
</div>
<ul id="upload-filelist" class="d-flex justify-content-between list-group list-group-flush"></ul>