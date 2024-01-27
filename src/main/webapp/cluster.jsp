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

<%@page contentType="text/html"%>

<html>
    <head><title>Clustering Information</title></head>
    <body bgcolor="white">
        <h1>Clustering Information</h1>

        <p>
        <ul>
            <li>Executed on GlassFish instance: <b><%= System.getProperty("com.sun.aas.instanceName") %></b></li>
            <li>Sent originally to "server:port":   <b><%= request.getServerName() %>:<%= request.getServerPort() %></b></li>
            <li>Session ID:    <b><%= session.getId() %></b></li>
        </ul>
    </p>
    <h3>Data in the HTTP session: </h3>
    <%
        String dataname = request.getParameter("dataName");
        String datavalue = request.getParameter("dataValue");
        String dataRandom = request.getParameter("dataRandom");
        String message = "";
        if (dataname != null && datavalue != null && !dataname.equals("")) {
            message = "<p>Attribute added to the HTTP session: " + dataname + " = " + datavalue + "</p>";
            session.setAttribute(dataname,datavalue);
        } else if ("true".equals(dataRandom)) {
            byte[] array = new byte[10];
            new java.util.Random().nextBytes(array);
            byte[] encodedBytes = java.util.Base64.getEncoder().encode(array);
            String generatedString = new String(encodedBytes,  java.nio.charset.Charset.forName("UTF-8"));
            String name = "Random attribute";
            String value = generatedString.substring(0,5);
            message = "<p>Attribute added to the HTTP session: " + name + " = " + value + "</p>";
            session.setAttribute(name, value);
        }

        java.util.Enumeration valueNames = session.getAttributeNames();
        if (!valueNames.hasMoreElements()) {
            out.println("HTTP session is empty");
        } else {
            out.println("HTTP session contains the following attributes");
            out.println("<ul>");
            while (valueNames.hasMoreElements()) {
                String param = (String) valueNames.nextElement();
                String value = session.getAttribute(param).toString();
                out.println("<li>" + param + " = " + value + "</li>");
            }
            out.println("</ul>");
        }
    %>
    <h3> Enter session attribute: </h3>
    <form action="cluster.jsp" method="POST" name="FormRandom">
        <input type="hidden" name="dataRandom" value="true">
        <input type="submit" name="add-random" value="Add random attribute">
    </form>
    <form action="cluster.jsp" method="POST" name="Form1">
        <p>
            Attribute name:
            <input type="text" size="20" name="dataName">
            Attribute value:
            <input type="text" size="20" name="dataValue">
            <input type="submit" name="add" value="Add attribute">
        </p>
    </form>
    <form action="cluster.jsp" method="POST" name="FormReload">
        <input type="submit" name="reload" value="Reload page">
    </form>
    <form action="resetSession.jsp" method="POST" name="FormReset" >
        <input type="submit" name="reset" value="Reset session">
    </form>

    <p>
        <%= message %>
    </p>

    <hr><br>
    <h3>HTTP request information:</h3>
    <ul>
        <li>Executed on GlassFish instance: <b><%= System.getProperty("com.sun.aas.instanceName") %></b></li>
        <li>Executed on server name: <b><%= java.net.InetAddress.getLocalHost().getHostName() %></b></li>
        <li>Executed on IP Address: <b><%= java.net.InetAddress.getLocalHost().getHostAddress() %></b></li>
        <li>Sent originally to "server:port":   <b><%= request.getServerName() %>:<%= request.getServerPort() %></b></li>
    </ul>
    <h3>HTTP session information:</h3>
    <ul>
        <li>Session ID:    <b><%= session.getId() %></b></li>
        <li>Session created at:  <%= new java.util.Date(session.getCreationTime())%></li>
        <li>Last accessed at:    <%= new java.util.Date(session.getLastAccessedTime())%></li>
        <li>Session will expire in  <b><%= session.getMaxInactiveInterval() %> seconds</b></li>
    </ul>
    <hr>
    <h2>Instructions</h2>

    This application shows which internal cluster instance served the request and information about the current session. If clustering is set up correcly, requests served by different cluster instances will by attached to the same session ID and the session will contain the same data.

    <ul>
        <li>Add session attribute using the form. After you press "Add attribute, the current session data will contain this new attribute</li>
        <li>Click on "Reload page" to display the current session data without adding new data.</li>
        <li>Click on "Reload page" several times, until you see responses from all cluster instances. The value of "Executed on GlassFish instance" can change for every request, but the session data should remaing the same.</li>
        <li>Click on "Reset session" to invalidate the current session. This will create a new empty session</li>
    </ul>

</body>
</html>
