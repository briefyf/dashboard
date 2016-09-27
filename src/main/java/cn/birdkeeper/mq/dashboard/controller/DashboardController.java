package cn.birdkeeper.mq.dashboard.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * project: schedule
 *
 * @description:
 * @date: 2016-08-15 11:32
 * @author: wangshengyue@zaozuo.com
 * @since: v1.0
 * <p>
 * <p>
 * Copyright ©  2016-08-15~  All rights reserved.
 */
@RestController
@RequestMapping("/schedule/dashboard")
public class DashboardController {

	@RequestMapping({ "" })
	public ModelAndView dashboard() {
		return new ModelAndView("dashboard");
	}

}