<h1><i class="fa fa-envelope-o"></i> Emailer (SparkPost)</h1>

<div class="row">
	<div class="col-lg-12">
		<blockquote>
			<p>
				SparkPost is the email delivery service based on the Momentum platform from Message Systems. Get the same deliverability, scalability and speed as we provide to the biggest senders in the world, in an easily integrated cloud service, while at the same time ensuring email best practices compliance.
			</p>
			<p>
				email_solved
			</p>
			<p>
				The future of email is here today.
				Spend less. Deliver more. Guaranteed.
			</p>
		</blockquote>
		<p>
			To get started:
		</p>
		<ol>
			<li>
				Register for an account on <a href="https://www.sparkpost.com/">https://www.sparkpost.com/</a>. Sparkpost offers a free tier with up to 100,000 free emails monthly.
			</li>
			<li>
				Paste your API key (not your public key) into the field below, hit save, and restart your NodeBB
			</li>
		</ol>
	</div>
</div>

<hr />

<form role="form" class="emailer-settings">
	<fieldset>
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
					<label for="apiKey">API Key</label>
					<input type="text" class="form-control" id="apiKey" name="apiKey" />
				</div>
			</div>
		</div>

		<button class="btn btn-lg btn-primary" id="save" type="button">Save</button>
	</fieldset>
</form>

<script type="text/javascript">
	require(['settings'], function(Settings) {
		Settings.load('sparkpost', $('.emailer-settings'));

		$('#save').on('click', function() {
			Settings.save('sparkpost', $('.emailer-settings'), function() {
				app.alert({
					type: 'success',
					alert_id: 'sparkpost-saved',
					title: 'Settings Saved',
					message: 'Click here to reload NodeBB',
					timeout: 2500,
					clickfn: function() {
						socket.emit('admin.reload');
					}
				});
			});
		});
	});
</script>
