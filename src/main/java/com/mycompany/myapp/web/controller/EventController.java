package com.mycompany.myapp.web.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.myapp.domain.Event;
import com.mycompany.myapp.domain.EventAttendee;
import com.mycompany.myapp.domain.EventLevel;
import com.mycompany.myapp.service.CalendarService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/events")
public class EventController {
	@Autowired
	private CalendarService calendarService;	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView allEvent(@RequestParam(value = "id", required = false) String id, Locale locale, ModelAndView mav) {
		if (id != null) {
			System.out.println(id);
		}
		mav.addObject("allEvent",calendarService.getAllEvents());
		mav.setViewName("allEvent");
		return mav;
	}
	
	
	@RequestMapping(value = "/deleteEvent", method = RequestMethod.GET)
	public ModelAndView deleteEvent( @RequestParam(value = "a") int id, Locale locale, ModelAndView mav) {
		calendarService.deleteEvent(id);
		List<EventAttendee> deleteAttendee = new ArrayList<EventAttendee>();
		deleteAttendee = calendarService.getEventAttendeeByEventId(id);
		for(EventAttendee ea : deleteAttendee){
       	 calendarService.deleteEventAttendee(ea.getId());
        }
		mav.addObject("allEvent",calendarService.getAllEvents());
		mav.setViewName("allEvent");
		return mav;
	}
	
	
	@RequestMapping(value = "/joinEvent", method = RequestMethod.GET)
	public ModelAndView joinEvent( @RequestParam(value = "a") int id, Locale locale, ModelAndView mav) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			EventAttendee eventAttendee = new EventAttendee();
			eventAttendee.setEvent(calendarService.getEvent(id));
			eventAttendee.setAttendee(calendarService.getUserByEmail(userDetail.getUsername()));
	        calendarService.createEventAttendee(eventAttendee);
	        
	        List<Event> ownerEvent = new ArrayList<Event>();
	        List<Event> attendEvent = new ArrayList<Event>();
	        List<EventAttendee> tempAttendee = new ArrayList<EventAttendee>();
	        ownerEvent = calendarService.getEventForOwner(calendarService.getUserByEmail(userDetail.getUsername()).getId());
	        tempAttendee = calendarService.getEventAttendeeByAttendeeId(calendarService.getUserByEmail(userDetail.getUsername()).getId());
	        for(EventAttendee ea : tempAttendee){
	        	attendEvent.add(ea.getEvent());
	        }
	        mav.addObject("ownerEvent",ownerEvent);
	        mav.addObject("attendEvent",attendEvent);
		}

		mav.setViewName("myEvent");
		return mav;
	}
	
	@RequestMapping(value = "/my", method = RequestMethod.GET)
	public ModelAndView myEvent(Locale locale, ModelAndView mav) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if(!(auth instanceof AnonymousAuthenticationToken)) {
		         UserDetails userDetail = (UserDetails) auth.getPrincipal();
		         List<Event> ownerEvent = new ArrayList<Event>();
		         List<Event> attendEvent = new ArrayList<Event>();
		         List<EventAttendee> tempAttendee = new ArrayList<EventAttendee>();
		         ownerEvent = calendarService.getEventForOwner(calendarService.getUserByEmail(userDetail.getUsername()).getId());
		         tempAttendee = calendarService.getEventAttendeeByAttendeeId(calendarService.getUserByEmail(userDetail.getUsername()).getId());
		         for(EventAttendee ea : tempAttendee){
		        	 attendEvent.add(ea.getEvent());
		         }
		         mav.addObject("ownerEvent",ownerEvent);
		         mav.addObject("attendEvent",attendEvent);
			}

		mav.setViewName("myEvent");
		return mav;
	}
	
	@RequestMapping(value = "/my/dropAttendee", method = RequestMethod.GET)
	public ModelAndView dropAttendee( @RequestParam(value = "a") int id, Locale locale, ModelAndView mav) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			calendarService.deleteEventAttendee(calendarService.getEventAttendeeByEventIdAttendeeId(id, calendarService.getUserByEmail(userDetail.getUsername()).getId()).getId());
	        
	        List<Event> ownerEvent = new ArrayList<Event>();
	        List<Event> attendEvent = new ArrayList<Event>();
	        List<EventAttendee> tempAttendee = new ArrayList<EventAttendee>();
	        ownerEvent = calendarService.getEventForOwner(calendarService.getUserByEmail(userDetail.getUsername()).getId());
	        tempAttendee = calendarService.getEventAttendeeByAttendeeId(calendarService.getUserByEmail(userDetail.getUsername()).getId());
	        for(EventAttendee ea : tempAttendee){
	        	attendEvent.add(ea.getEvent());
	        }
	        mav.addObject("ownerEvent",ownerEvent);
	        mav.addObject("attendEvent",attendEvent);
		}
		mav.setViewName("myEvent");
		return mav;
	}
	
	@RequestMapping(value = "/createevent", method = RequestMethod.GET)
	public ModelAndView createEvent(Locale locale, ModelAndView mav) {
		
		Event eventForm = new Event();
		mav.addObject("eventForm",eventForm);
		mav.setViewName("createevent");
		
		return mav;
	}
	@RequestMapping(value = "/createevent", method = RequestMethod.POST)
    public String processCreate(@ModelAttribute("eventForm") Event event, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!(auth instanceof AnonymousAuthenticationToken)) {
	         UserDetails userDetail = (UserDetails) auth.getPrincipal();
	         event.setOwner(calendarService.getUserByEmail(userDetail.getUsername()));
		}
		event.setNumLikes(0);
		event.setEventLevel(EventLevel.NORMAL);
        this.calendarService.createEvent(event);
        
        model.addAttribute("allEvent",calendarService.getAllEvents());
        
        return "allEvent";
	}
	/*@RequestMapping(value = "/form", method = RequestMethod.POST)
    public String processCreate(@ModelAttribute("eventForm") Event event,@RequestParam(value = "when") String when, Model model) {
		Calendar calendar = Calendar.getInstance();
		StringTokenizer tokens = new StringTokenizer(when);
		int month = Integer.parseInt(tokens.nextToken("\\/")), date = Integer.parseInt(tokens.nextToken("\\/")), year = Integer.parseInt(tokens.nextToken(" ")),hourOfDay = Integer.parseInt(tokens.nextToken("\\:")), minute = Integer.parseInt(tokens.nextToken(" "));
		System.out.println(" " + month + date + year + hourOfDay + minute);
		calendar.set(year, month, date, hourOfDay, minute);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!(auth instanceof AnonymousAuthenticationToken)) {
	         UserDetails userDetail = (UserDetails) auth.getPrincipal();
	         event.setOwner(calendarService.getUserByEmail(userDetail.getUsername()));
		}
		event.setWhen(calendar);
		event.setNumLikes(0);
        this.calendarService.createEvent(event);
        
        return "eventcreatesuccess";
    }*/
}
