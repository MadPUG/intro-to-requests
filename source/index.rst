
.. Introduction to Requests slides file, created by
   hieroglyph-quickstart on Sat Feb 28 14:34:07 2015.


========================
Introduction to Requests
========================

A short presentation about HTTP for humans by Ian Cordasco

.. slide:: What is requests?

        HTTP for Humans

.. slide:: What is requests?

    Simple API for making HTTP requests

.. slide:: What is requests?

    - Provides security by default

      - HTTPS hostname verification

      - SNI available as an extra if your python does not support it natively

      - Handles redirects securely

.. slide:: Installing Requests

    .. code-block:: shell-session

        $ pip install requests

    Yes, it is that easy. If you don't have pip installed though, see me
    afterwards for help.

.. slide:: A simple game of fetch

    Now that we have requests installed, let's do something with it.

.. slide:: GETing some data

    .. code-block:: pycon

        >>> import requests
        >>> response = requests.get('https://httpbin.org/get')

.. slide:: GETing some data

    .. code-block:: pycon

        >>> response.status_code
        200
        >>> response.reason
        'OK'
        >>> response.headers
        {'access-control-allow-credentials': 'true',
         'access-control-allow-origin': '*',
         'connection': 'keep-alive',
         'content-length': '266',
         'content-type': 'application/json',
         'date': 'Sat, 28 Feb 2015 21:03:45 GMT',
         'server': 'nginx'}

.. slide:: GETing some data

    .. code-block:: pycon

        >>> response.content
        b'{\n  "args": {}, \n  "headers": {\n    "Accept": "*/*", \n    
        "Accept-Encoding": "gzip, deflate", \n    "Host": "httpbin.org", \n    
        "User-Agent": "python-requests/2.5.3 CPython/3.4.2 Darwin/14.0.0"\n  
        }, \n  "origin": "69.29.227.116", \n  "url": 
        "https://httpbin.org/get"\n}\n'

    The content of the response is a bytearray

.. slide:: So what does all this mean?
        
    We used the HTTP verb ``GET`` defined in :rfc:`7230` to request data from
    ``https://httpbin.org/get``. We received a ``200 OK`` response that had a 
    content with ``JSON`` serialized data in it.
