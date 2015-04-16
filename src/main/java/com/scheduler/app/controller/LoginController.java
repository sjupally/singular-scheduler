package com.scheduler.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.scheduler.app.common.DConstants;
import com.scheduler.app.form.LoginForm;
import com.scheduler.app.service.LoginService;

@Controller
public class LoginController implements DConstants {

	@Autowired
	private LoginService loginService;

	@Value("${mail.id.from.admin}")
	private String adminEmailId;

	// logger
	private static Logger logger = LoggerFactory.getLogger(LoginController.class);

	/**
	 * This method displays the welcome page to the user
	 *
	 * @return mav object {@link ModelAndView}
	 */

	@RequestMapping(value = LOGIN_URL, method = RequestMethod.GET)
	public ModelAndView preLoginGET() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(VIEW_LOGIN);
		mav.addObject(MODEL_LOGIN_FORM, new LoginForm());
		return mav;
	}

	@RequestMapping(value = LOGIN_URL, method = RequestMethod.POST)
	public ModelAndView preLogin(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		if (mav == null) {
			mav = new ModelAndView();
		}
		mav.setViewName(VIEW_LOGIN);
		mav.addObject(MODEL_LOGIN_FORM, new LoginForm());
		HttpSession session = request.getSession(false);
		if (null == session) {
			session = request.getSession(true);
		}
		String sessionid = request.getSession().getId();
		response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionid + "; secure ; HttpOnly");
		return mav;
	}

	@RequestMapping(value = SIGNIN_URI)
	public ModelAndView performLogin(@ModelAttribute(MODEL_LOGIN_FORM) @Valid LoginForm loginForm, BindingResult result, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject(MODEL_LOGIN_FORM, loginForm);
		mav.setViewName(VIEW_LOGIN);
		if (!result.hasErrors()) {
			mav.addObject(MODEL_LOGIN_FORM, new LoginForm());
			if (loginService.validateLogin(loginForm)) {
				// Put some key in the session, it would be used in
				// DialogueRequestFilter for later pages.
				HttpSession session = request.getSession(false);
				if (null == session) {
					session = request.getSession(true);
				}
				session.setAttribute(VALID_SESSION_KEY, TRUE);
				// mav.setViewName("/welcome");
				List<String> jobsList = null;// httpParamService.getJobsList();
				mav.addObject("jobsList", jobsList);
				mav.setViewName("redirect:list");

			} else {
				mav.addObject(DISPLAY_DEFAULT_LAYOUT, "true");
				mav.addObject(ERROR_MESSAGE_KEY, "error.loginForm.invalid.credentials");
			}
		} else {
			mav.addObject(DISPLAY_DEFAULT_LAYOUT, "true");
		}
		return mav;
	}

	/**
	 * This method called when user clicks on the logout button
	 *
	 * @param request
	 * @return <code>ModelAndView</code> object
	 */
	@RequestMapping(value = LOGOUT_URI)
	public ModelAndView logout(HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		mav.addObject(SUCCESS_MSG_KEY, LOGOUT);
		mav.addObject(MODEL_LOGIN_FORM, new LoginForm());

		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute(VALID_SESSION_KEY);
			session.invalidate();
		}
		mav.setViewName(VIEW_LOGIN);
		return mav;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView welcome() {
		logger.info("*** invoking welcome page ***");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(VIEW_LOGIN);
		mav.addObject(MODEL_LOGIN_FORM, new LoginForm());
		return mav;
	}

	/**
	 * This method displays the welcome page to the user when clicks on the
	 * cancel button
	 *
	 * @return mav object {@link ModelAndView}
	 */
	@RequestMapping(value = "/cancel", method = RequestMethod.GET)
	public ModelAndView cancel() {
		logger.info("*** invoking welcome page when click on the cancel button ***");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/welcome");
		return mav;
	}
}
