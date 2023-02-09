/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.filters;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

/**
 *
 * @author PhucPhan
 */
@WebFilter(filterName = "RedirectJSPFilter", urlPatterns = {"/*"})
public class RedirectJSPFilter implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public RedirectJSPFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("RedirectJSPFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("RedirectJSPFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("RedirectJSPFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        Throwable problem = null;
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;

            String requestPath = req.getRequestURI();
            if (requestPath.endsWith("admin.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_book.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_book_insert.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_book_update.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_borrow_borrowing.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_borrow_overdue.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_borrow_returned.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_borrowrequest.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_category.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_class.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_curriculum.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_send_message.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_subject.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_user.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_user_insert.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_user_update.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("admin_pages/admin_usermessage.jsp")) {
                res.sendRedirect("/admin");
            } else if (requestPath.endsWith("login.jsp")) {
                res.sendRedirect("/login");
            } else if (requestPath.endsWith("index.jsp")) {
                res.sendRedirect("/");
            } else if (requestPath.endsWith("signup.jsp")) {
                res.sendRedirect("/sign-up");
            } else if (requestPath.endsWith("book_list.jsp")) {
                res.sendRedirect("/book-list");
            } else if (requestPath.endsWith("detail.jsp")) {
                res.sendRedirect("/detail");
            }  else {
                chain.doFilter(req, res);
            }
        } catch (Throwable t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
            t.printStackTrace();
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("RedirectJSPFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("RedirectJSPFilter()");
        }
        StringBuffer sb = new StringBuffer("RedirectJSPFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
