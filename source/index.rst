
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
        }, \n  "url": "https://httpbin.org/get"\n}\n'

    The content of the response is a bytearray

.. slide:: So what does all this mean?

    We used the HTTP verb ``GET`` defined in :rfc:`7230` to request data from
    ``https://httpbin.org/get``. We received a ``200 OK`` response that had a
    content with ``JSON`` serialized data in it.

.. slide:: Woah woah slow down

    Everything our browsers (and requests) does on the internet is
    standardized by a group of people who associate with the Internet
    Engineering Task Force (IETF). They write Requests for Comments (RFCs) to
    codify the standards.

.. slide:: HTTP & RFCs

    HTTP is defined by a set of RFCs that define verbs that mimic actions.

.. slide:: HTTP Verbs

    ``GET``, ``POST``, ``PUT``, ``HEAD``, ``OPTIONS``, ``DELETE``, ``PATCH``

.. slide:: Response Types

    There are a bunch. The most common is ``200 OK`` and they are generally
    classified by the first number.

.. slide:: Response Classes

    - 2xx: Success

    - 3xx: Your content is elsewhere

    - 4xx: You messed up

    - 5xx: We messed up

.. slide:: Response Headers

    These precede the actual body (content) of the response.

    .. note::

        The include information about the length of the content, what type of
        content is in the response, and other critical information.

.. slide:: JavaScript Object Notation

    a.k.a, JSON, :rfc:`7159`, ... Wait I thought we were talking about Python.

    .. note::

        So JSON is another standard that arose from needing to send data from
        the server to the browser in a stateful way while performing real-time
        communication. It's the JavaScript Object Notation but it is usable by
        pretty much any programming language, including Python.

.. slide:: So what does all this mean?

    We used the HTTP verb ``GET`` defined in :rfc:`7230` to request data from
    ``https://httpbin.org/get``. We received a ``200 OK`` response that had a
    content with ``JSON`` serialized data in it.

.. slide:: This is JSON

    .. code-block:: json

        {"args": {}, "headers: {"Accept": "*/*", "Accept-Encoding": "gzip,
        deflate", "Host": "httpbin.org"}, "url": "https://httpbin.org/get"}

    .. note:: Looks a lot like python, doesn't it?

.. slide:: Access a response's JSON

    .. code-block:: pycon

        >>> response.json()
        {"args": {},
         "headers: {"Accept": "*/*",
                    "Accept-Encoding": "gzip, deflate",
                    "Host": "httpbin.org"},
         "url": "https://httpbin.org/get"}
        >>> response.json()["headers"]
        {"Accept": "*/*",
         "Accept-Encoding": "gzip, deflate",
         "Host": "httpbin.org"},

    .. note::

        These headers are not the ones we get, but the ones that requests
        sends. HTTPBin will just return to you the data from your request in
        JSON.

.. slide:: How to send JSON?

    .. code-block:: pycon

        >>> response = requests.post('https://httpbin.org/post',
        ... json={'foo': 'bar'})
        >>> response.json()
        {'data': '{"foo": "bar"}',
         'headers': {'Content-Length': '14',
                     'Content-Type': 'application/json'},
         'json': {'foo': 'bar'},
         'url': 'https://httpbin.org/post'}

    .. note::

        We see here that HTTPbin returns the data we sent as both a string and
        interpreted as JSON, as we expect it. Also, the json parameter was
        only recently added to requests. requests takes responsibility for
        calculating the length of the data your sending to the server and puts
        it in the ``Content-Length`` header as well as sets the right
        ``Content-Type`` header.

.. slide:: What about other data?

    .. code-block:: pycon

        >>> response = requests.post('https://httpbin.org/post',
        ... data={'some': 'data', 'other': 'data'})
        >>> response.json()
        {'data': '',
         'form': {'other': 'data', 'some': 'data'},
         'headers': {'Content-Length': '20',
                     'Content-Type': 'application/x-www-form-urlencoded'},
         'json': None}
