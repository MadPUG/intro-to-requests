
.. Introduction to Requests slides file, created by
   hieroglyph-quickstart on Sat Feb 28 14:34:07 2015.


========================
Introduction to Requests
========================

A short presentation about HTTP for humans by Ian Cordasco

.. nextslide::

Well, actually, just HTTP/1.* for Humans.

We don't yet support HTTP/2

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

    - 3xx: This is not the URL you're looking for

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

    .. note::

        You'll notice that this as parsed as form data but what did we
        actually send?

.. slide:: Inspecting the Request

    .. code-block:: pycon

        >>> response.request
        <PreparedRequest [POST]>
        >>> response.request.body
        'some=data&other=data'
        >>> response.request.headers['Content-Type']
        'application/x-www-form-urlencoded'

    .. note::

        Here, we're sending urlencoded form data. It's one of the most common
        ways of browsers submitting forms to a server. (Actually it's almost
        always the way that browsers submit simple form responses to a
        server.)

.. slide:: HTTPS and Security

    requests verifies the certificate presented for a website is valid

    - Hostname matches the hostnames the certificate is valid for

    - The issuer chain is valid

    .. note::

        I mentioned this earlier. And you may have noticed at this point that
        we keep talking to HTTPbin over HTTPS, what happens if we talk to a
        service that doesn't support HTTPS over HTTPS?

.. slide:: HTTPS and Security

    .. code-block:: pycon

        >>> requests.get('https://wondermark.com/1k62/')
        # <snip>
        requests.exceptions.SSLError: hostname 'wondermark.com' doesn't match
        either of '*.gridserver.com', 'gridserver.com'

    requests prevents* us from completing the request

    .. note::

        This only prevents us by raising an exception. We can tell requests to
        ignore the problem but unless we are certain we're visiting a
        trustworthy site (or one that has a self-signed certificate).

.. slide:: Speed and connection reuse

    If we just always used the ``requests.*`` API, our code will be elegant,
    but not nearly as fast as it could be.

    .. note::

        Like browsers, requests allows a user to create a Session and reuse
        connections to an existing server. This only happens when using a
        Session though. By reusing connections, we're skipping the most
        expensive part of talking to a server: creating a socket.

.. slide:: Sessions

    .. code-block:: pycon

        >>> session = requests.Session()
        >>> response = session.get('https://httpbin.org/get')

.. slide:: Cookies

    .. code-block:: pycon

        >>> response = session.get('https://httpbin.org/cookies/set',
        ... params={'a-cookie': 'a-cookie-value',
        ... 'b-cookie': 'b-cookie-value'})
        >>> response.cookies
        <RequestsCookieJar[]>
        >>> session.cookies
        <RequestsCookieJar[Cookie(name='a-cookie', value='a-cookie-value'),
        Cookie(name='b-cookie', value='b-cookie-value')]>

    .. note::

        Isn't that interesting. The response we have doesn't have cookies on
        it but the session does store the cookies. The reason is that the
        cookies are set while performing a redirect. So let's look at the
        history of that response.

        params here will construct a query string for your URL, so we don't
        have to hand write it or escape the characters that are reserved in a
        URL

.. slide:: History

    .. code-block:: pycon

        >>> response.history
        [<Response [302]>]
        >>> response.history[0].cookies
        <RequestsCookieJar[Cookie(name='a-cookie', value='a-cookie-value'),
        Cookie(name='b-cookie', value='b-cookie-value')]>
        >>> response.json()['cookies']
        {'b-cookie': 'b-cookie-value', 'a-cookie': 'a-cookie-value'}

    .. note::

        Yep, the cookies are present on the original response because that's
        the response where the server actually set them. Further, requests
        knows to send those cookies to httpbin on our behalf. The URL we're
        redirected to returns the cookies we send back to the server in the
        JSON body.

.. slide:: Authentication

    .. code-block:: pycon

        >>> url = 'https://httpbin.org/basic-auth/MadPUG/password'
        >>> response = session.get(url, auth=('MadPUG', 'password'))
        >>> resopnse.status_code, response.reason
        (200, 'OK')
        >>> response.json()
        {'authenticated': True, 'user': 'MadPUG'}
        >>> response.request.headers['Authorization']
        'Basic TWFkUFVHOnBhc3N3b3Jk'

    .. note::

        As you can guess from the URL and the header sent, we're using basic
        authentication. requests also supports Digest Authentication and there
        are other libraries that provide different authentication mechanisms
        like ntlm, kerberos, and oauth.

.. slide:: Questions?
