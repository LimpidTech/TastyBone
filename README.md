TastyBone
=========

Expose TastyPie to your client. Nicely.

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

	bone = new TastyBone.Bone('/api/v1');

	bone.on('ready', function get_collections() {
		users = new bone.collections.UserCollection();

		.fetch({
			'success': function get_users(response) {
				// Hooray! We found our users.
				console.dir(response);
			},
			'error': function get_users_error(response) {
				console.log('Oh, no! An error!');
			}
		});
	};
