# filter_plugins/url_encode.py

import urllib.parse

class FilterModule(object):
    def filters(self):
        return {
            'url_encode': self.url_encode
        }

    def url_encode(self, value):
        if not isinstance(value, str):
            value = str(value)
        return urllib.parse.quote(value)
