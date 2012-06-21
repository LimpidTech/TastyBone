from django.http import HttpResponse
from tastypie.exceptions import BadRequest
from tastypie.serializers import Serializer
from tastypie.utils import is_valid_jsonp_callback_value
from tastypie.utils.mime import determine_format, build_content_type
from tastypie.api import Api as OriginalApi
import json

class Api(OriginalApi):
    """ Extends the default TastyPie Api object to include schemas.
    
    Provides the ability for TastyBone to get validation information in a
    single request to the API top level instead of in multiple requests to
    each individual resource's schema URL.

    This is useful for applications that want to levearge automatic model
    validation, but don't want to see an extra request for every model in
    their API.

    Provides the exact same functionality that TastyPie provides, unless
    the 'schema' variable is passed in the GET request, in which case
    schema data is also included.

    """

    def top_level(self, request, api_name=None):
        serializer = Serializer()
        available_resources = {}

        if api_name is None:
            api_name = self.api_name

        for name in sorted(self._registry.keys()):
            available_resources[name] = {
                'list_endpoint': self._build_reverse_url('api_dispatch_list', kwargs={
                    'api_name': api_name,
                    'resource_name': name,
                }),
                'schema': self._build_reverse_url('api_get_schema', kwargs={
                    'api_name': api_name,
                    'resource_name': name,
                }),
            }

            if request.GET.get('include_schemas', False) is not False:
                available_resources[name]['schema_detailed'] = self._registry[name].build_schema()

        desired_format = determine_format(request, serializer)
        options = {}

        if 'text/javascript' in desired_format:
            callback = request.GET.get('callback', 'callback')
            
            if not is_valid_jsonp_callback_value(callback):
                raise BadRequest('JSONP callback name is invalid.')

            options['callback'] = callback

        serialized = serializer.serialize(available_resources, desired_format, options)
        return HttpResponse(content=serialized, content_type=build_content_type(desired_format))

