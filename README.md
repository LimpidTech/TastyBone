TastyBone
=========

Expose TastyPie to your client. Nicely.

Dependencies
------------

Before including this script, make sure that you have included the following
scripts in your document. Without them, this thing is going to misbehave like
you wouldn't believe!

- jQuery
- underscore.js
- backbone.js

Note that I did not introduce any of these dependencies (aside from the obvious
backbone.js dependency). These are all dependencies required by any site using
backbone.js to grab data over AJAX - which is exactly what we need for
TastyBone.

How does it work?
-----------------

TastyBone allows you to easily connect backbone.js to your Django TastyPie
APIs. It can understand all of your resources with a single line - which
looks like this:

    bone = new TastyBone.Bone('/api/v1/');

This will connect to the current origin at the URL /api/v1, and it will
use the root URL to find all endpoints which exist on your site. After
these endpoints are found, the bone object will fire a ready event.

So, if you had exposed a User resource at /api/v1/user/ - you could get a
collection of user models as such:

	bone = new TastyBone.Bone('/api/v1/');

	bone.on('ready', function get_collections() {
		users = new bone.collections.UserCollection();

		users.fetch({
			'success': function get_users(response) {
				// Hooray! We found our users.
				console.dir(response);
			},
			'error': function get_users_error(response) {
				console.log('Oh, no! An error!');
			}
		});
	};

Django support
--------------

TastyBone is already in pip, and provides a super simple app that will append
tastybone.js and tastybone.min.js to your static files. Simply install
tastybone from pypi with your favorite frontend. Here's how it looks with pip:

	pip install tastybone

After this is done installing, append the tastybone module to your
INSTALLED_APPS setting:

	INSTALLED_APPS = (
		# All of your other awesomely fancy apps here.
		'tastybone',
	)

Now, (after having run `manage.py collectstatic` if necessary) you should be
able to access *tastybone.js* or *tastybone.min.js* under your STATIC_URL. For
instance, if STATIC_URL is equal to '/static/' then you'd find the script here:

	<script src="/static/scripts/tastypie.min.js"></script>

Things that still need done
---------------------------

- Proper authentication/authorization support for TastyPie's built-in types.
