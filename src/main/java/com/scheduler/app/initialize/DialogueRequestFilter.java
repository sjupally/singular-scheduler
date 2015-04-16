package com.scheduler.app.initialize;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static com.scheduler.app.common.DConstants.*;


public class DialogueRequestFilter  extends HandlerInterceptorAdapter{

  private final String LOGOUT_URL = "logout";
  private final String SIGN_IN_URL = "signIn";
  private final String LOGIN_URL = "login";


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        boolean returnVal = true;
        String uri = request.getRequestURI();
        //Allow only login, singIn and log out urls, not to check for existing session and its keys.
        if (null != uri && !uri.endsWith(LOGIN_URL) && !uri.endsWith(SIGN_IN_URL) && !uri.endsWith(LOGOUT_URL)) {
            returnVal = isValidSession(request, response);
        }
        return returnVal;
    }

    private boolean isValidSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean returnVal = true;
        //Get existing session object from request scope.
        HttpSession session = request.getSession(false);
        if (null != session) {
            String isValidSession = (String) session.getAttribute(VALID_SESSION_KEY);
            //If VALID_SESSION_KEY is not in session, redirect page to login.
            if (null == isValidSession || !TRUE.equals(isValidSession)) {
                response.sendRedirect(LOGIN_URL);
                returnVal = false;
            }
        } else {   //If session is null.
            response.sendRedirect(LOGIN_URL);
            returnVal = false;
        }
        return returnVal;
    }


    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object o, ModelAndView modelAndView) throws Exception {
        String uri = request.getRequestURI();
        //If it is logout, invalidate the session.
        if (null != uri && (uri.endsWith(LOGOUT_URI))) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
        }
    }
}
