/*
 * Copyright 2012-2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cn.birdkeeper.mq.dashboard;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication
@ComponentScan("cn.birdkeeper")
@ImportResource(locations = { "classpath:dashboard.xml" })
@EnableAutoConfiguration
public class DashboardApplication {

	private static String profile = "dev";

	public static void main(String[] args) throws Exception {
		if (args.length > 0) {
			profile = args[0];
		}
		System.setProperty("profile",profile);
		SpringApplication.run(DashboardApplication.class, args).close();
	}
}
