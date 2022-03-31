package net.javaguides.springmvc.helloworld.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import net.javaguides.springmvc.helloworld.model.HelloWorld;

/**
 * @author Ramesh Fadatare
 */
@Controller
public class HelloWorldController {

	@RequestMapping("/rapid7")
	public void vulnerable(HelloWorld model) {
	}
}
