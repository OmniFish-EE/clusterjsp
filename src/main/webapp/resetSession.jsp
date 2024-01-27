<%--
The MIT License

Copyright 2024 OmniFish OU. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--%>
<%@ page import="jakarta.servlet.http.Cookie" %>

<html>
    <head><title>Clustering Information</title></head>
    <body>

        <% String reset = request.getParameter("reset");
           if (reset != null) {
               out.println("HTTP session was reset");
                session.invalidate();
                String cookieName = request.getServletContext().getSessionCookieConfig().getName();
                Cookie cookie = new Cookie(cookieName, "deleted");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
           }
        %>
        <p>
        <ul>
            <li>Executed on GlassFish instance: <b><%= System.getProperty("com.sun.aas.instanceName") %></b></li>
            <li>
                Served From Server: <b><%= request.getServerName() %></b>
            </li>
        </ul>
        </p>
        <p>
            Click on "Start new session" to start a new HTTP session
        </p>
        <a href="cluster.jsp" name="start-session">Start new session</A>
</body>
</html>
