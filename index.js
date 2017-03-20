var	winston = module.parent.require('winston'),
	Meta = module.parent.require('./meta'),

	Emailer = {},
	Sparkpost = require('sparkpost'),
	client;

Emailer.init = function(params, callback) {
	function render(req, res, next) {
		res.render('admin/plugins/emailer-sparkpost', {});
	}

	Meta.settings.get('sparkpost', function(err, settings) {
		if (!err && settings && settings.apiKey) {
			client = new Sparkpost(settings.apiKey);
		} else {
			winston.error('[emailer.sparkpost] API key not set!');
		}
	});

	params.router.get('/admin/plugins/emailer-sparkpost', params.middleware.admin.buildHeader, render);
	params.router.get('/api/admin/plugins/emailer-sparkpost', render);

	callback();
};

Emailer.send = function(data, callback) {
	if (!client) {
		winston.error('[emailer.sparkpost] Sparkpost is not set up properly!')
		return callback(null, data);
	}

    client.transmissions.send({
        content: {
            from: {
		name: data.from_name,
		email: data.from
	    },
            subject: data.subject,
            html: data.html,
            text: data.plaintext
        },
        recipients: [
            {address: data.to}
        ]
    }, function (err, res) {
		if (!err) {
			winston.verbose('[emailer.sparkpost] Sent `' + data.template + '` email to uid ' + data.uid);
		} else {
			winston.warn('[emailer.sparkpost] Unable to send `' + data.template + '` email to uid ' + data.uid + '!!');
			winston.error('[emailer.sparkpost] (' + err.message + ')');
		}

		return callback(err, data);
	});
};

Emailer.admin = {
	menu: function(custom_header, callback) {
		custom_header.plugins.push({
			"route": '/plugins/emailer-sparkpost',
			"icon": 'fa-envelope-o',
			"name": 'Emailer (Sparkpost)'
		});

		callback(null, custom_header);
	}
};

module.exports = Emailer;
