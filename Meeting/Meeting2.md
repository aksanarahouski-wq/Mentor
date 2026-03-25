00:00 Hyun Masiello: It because it's not as major as the larger launches that we've done in the past. So what we're doing, so let's just go through the list in chronological order. So as we're going through pre-launch, we're meeting with you guys today to just finalize a launch date and plan. And so I think we have a few tasks, some recommendations that we have for you guys. So let's go through those and then towards the end, let's One of our goals of today's call is to get the date established. There are some out-of-office dates that we need to consider. I know you guys will be pretty much out all next week at the Mentor Summit, so that's definitely not an option. So, but then if there's any other outages for you guys, please let us know so we can account for that in our launch plan.

00:48 Aksana Rahouski: All right. Okay.

00:50 Hyun Masiello: The next thing that we're recommending is that you guys just do a quick run-through of the NQMS system on staging. Since we last— there was a fair bit of feedback, and so we made those updates, and I know you guys have UAT verified it, but it probably would help just to do one quick run-through one more time to make sure nothing else broke, you know, there's no regression issues that took place. We feel fairly confident about the system, but we need you to— you know, we would like for you guys to verify there.

01:17 Mike Garringer: Can I just ask a quick question? Yeah. How are we defining a run-through? Like, are there certain things I should be, you know, filling out a fresh assessment as if I'm a program, or is it just going back to the list of improvements and double-checking those?

01:37 Hyun Masiello: I think it's more, I think it's just we want to make sure the critical path works. So I think it would be creating the, like, approving as a global admin, approving a program to start the assessment, working through the assessment, being being able to go through the approvals, and some of those are already captured in a lot of the updates that we made and such. And then if you want to just spot-check to make sure the reports are looking good, like all the major things that we did also look good. I don't think at this point we need to really dig into it too deeply, you know, but yeah, just making sure the end-to-end experience of the NQMS system works well for user admins, Global affiliate, you know, so, yeah. Okay, we have some work that's done under support. So we're working on those footer updates for the emails that go out right now. It's showing the old address for Mentor National. So we're updating that. So that is going to be, we're going to make sure it's added to the branch that's going to go live. And then we wanted to talk through this one around the Mentor National affiliate really quick. So, As discussed, in order to resolve that permissions issue, our recommendation was let's go ahead and create the Mentor National Affiliate to make sure that every program has an affiliate. And so even the ones that are not part of a state that is an affiliate. So part of that is how, who wants to own that? I think, you know, does Mentor want to handle creating that affiliate and adding those zip codes, or do you want OASIS to handle that?

03:10 Aksana Rahouski: I would even start even step back. We know we have orphan programs, right? And when I say orphan, I mean programs that are not talked under any affiliate, right? So right now, today, affiliate has a zip code coverage program by having a zip code that match. That's how we tie them together, right? Is this mechanism that we use. So there are programs out there whose zip code is not under any affiliate where we call them orphans. So since we added this new capability with this round of enhancements where you can give an affiliate user scoped or limited access to a single program, it kind of excludes these individuals one because they're not tucked under any parent, right? So we agreed that we'll add this like a global affiliate and then after we have an affiliate, next question is how do we find all our orphan programs and add their zip codes to the affiliate coverage, which I realized from the system itself, the front end of it, there was no really easy way to answer question, give me all programs that are orphans, right? Because we could search by name, status, affiliate, but we can't search by give me all that are not in affiliate, right? So that's where we're asking, we could just create, write a script and just basically pull that and I'll give you like here are all the IDs You guys go and go through these programs, pull zip codes, go add them to the coverage. That on itself even could be scripted. We could just create SQL statements that give me all, update the zip codes to the new affiliate. So what we're just saying, instead of option A, you could go and figure it out. Option B, we could partner on this, we could help you. Because like, again, using kind of software to support us That's what he is asking, because I know we did talk about this is something that needs to be done as a task. We never specifically talked about how we're going to do that.

05:12 Mike Garringer: So.

05:15 Tim Wills: That don't have an affiliate. So it's really around 26 states would be the easiest way to do the zip codes for those 26 states. So when Tiny thing I realized last week when I was playing around in the system. When an affiliate no longer exists, or like if we do this Mentor National affiliate and we need to take the zip codes off of Mentor National and assign it to a new affiliate, you literally have to uncheck every single county. You can't just delete an entire state of zip codes at once. That seems crazy because we have a couple affiliates that are no longer affiliates right now that still have the zip codes attached to them, and I literally have to go in and uncheck every single county in the zip code box.

06:07 Sandy Martins: There's not a deselect all. I thought there was a deselect button.

06:11 Tim Wills: I don't remember running into a deselect button.

06:14 Sandy Martins: But Oksana, my question was how many zip codes are we looking at?

06:20 Aksana Rahouski: I don't know yet. That's where like I'm saying like we could, I could go kind of do the database analysis and try to answer that question. One option is what Tim said. He roughly knows which states, which kind of roughly puts you to zip code. So he could go and search state by 20. It's just gonna take you hours to do that. You need our help.

06:45 Hyun Masiello: That's what we're saying.

06:46 Aksana Rahouski: Also, Tim's comment, I think there are quite a few areas like similar to that where you'll notice the system is again back to like the volume of data is growing, right? Yet there are no like kind of bulk operations. Similar issue what you guys reported. I mean, it's going to become an issue if it's not an issue yet, like an affiliate being inactive. Does it actually do anything, right? What should we do when affiliate becomes inactive? Do we just remove all this zip code? Do we kind of temporary put a status on it? So a few things, and all these things I just want to tell you, like, that all these things you will see on this, like, new slide deck that we're working for 2026 enhancements that we'll, at some point soon, we'll regroup and review it and see how many of these are high, medium, low priority, and we want to prioritize sooner versus later.

07:44 Tim Wills: Yeah, I think the thing is, like, you could run the script to assign all those programs to the international.

07:52 Aksana Rahouski: Thing.

07:52 Tim Wills: There'S still the issue of like if a new program in an unaffiliated state registers, we still need to have all the zip codes in those states assigned.

08:02 Aksana Rahouski: Correct.

08:03 Tim Wills: Right? So.

08:04 Aksana Rahouski: Yes, yes. It's not like the most sophisticated way how you kind of offload from one to the next. You have to go to one, uncheck, go to the next, check, right? 20 times, 50 times, it's time-consuming. Yes.

08:21 Tim Wills: Yeah, we can provide you a list of the states that are not affiliated. And then I think if there's a script we can run on the programs in there to assign them to Mentor National would be very helpful.

08:35 Aksana Rahouski: Yeah, first question is to find them, right? What Sandy asked, like, even we have, and again, we need to find all that are not assigned. I mean, assigned is a loose term here, right? We're not technically assigning. We're assigning by matching zip codes. And then we can like figure out how to— do you guys have— anybody has created that like global affiliate yet, or we don't have that yet? No, it's also not— I want to.

09:09 Tim Wills: A list of all on the last data report that Sandy pulled. You can see all the programs that are not associated with an affiliate.

09:16 Sandy Martins: Yeah, I have the file up now, but the thing is too, it's also only approved programs that we— are we saying that we're doing it for all programs or just approved ones that we are looking to do this Mentor National Global Awards?

09:31 Aksana Rahouski: I would recommend doing it for all. Oh yeah. And when you pull— so today when you pull list of all programs, since it has that associated affiliate, so you can kind of sort by— okay, so there's a way to at least get to the list.

09:49 Mike Garringer: Yeah. And do you need all of the zip codes for the non-affiliate states or can we just— we've got them listed out for the places where we have an affiliate and I would think if an existing or new program signs up, It could just say, well, if your zip code isn't on this list of known affiliates, then assign it to national. I'm trying to figure out if we need to get you a list of.

10:14 Sandy Martins: Like— Yeah, that's why I was asking about the amount of records because we have a cleanup going on, which we're looking to kick that off soon. This could be a potential area that we can use folks to help us with filling in the zip codes. So right now, a file that I exported early January had about 750 programs with no assigned to it. And that's between approved, pending, and paused accounts. Delete is not in here. So I think it's probably like under 1,000 maybe.

10:49 Mike Garringer: Well, and I think the bigger issue is like the number of zip codes. It's like, you know, how many zip codes are in Kentucky? I'm sure there's a list we can find somewhere, but like, yeah.

11:01 Aksana Rahouski: You know, it's almost, you know, you guys, Mike, you just gave me an idea because so usually, right, so let me, and let me steal from for a second your screen, which is why.

11:17 Tim Wills: I was saying like if we just created an affiliate that's national and assign the zip codes, the system will automatically assign those programs in the system already to that affiliate.

11:27 Sandy Martins: Right.

11:29 Aksana Rahouski: So one way to go about this, so this is, okay, semi-affiliate, right? It serves these areas, right? That's how this program basically, system just pulls all programs that kind of match this list of the coverage, right? We could again, programmatically solve it as, let's say, but that would require some coding. For a global affiliate, which kind of we treat it as a unicorn and we don't really match it on the coverage, but we just pull whoever is not matched to that list. So that way you never have to deal with specifying service area. It's like a safety net, basically. Everybody who didn't get a home will land in the safety net. That way you don't ever have to go and like be so specific about which zip codes you add here, because if you miss one, you still miss the program. But with the other solution, it doesn't matter. It covers whoever is not covered out there. I don't need to worry about the coverage for this area.

12:41 Mike Garringer: Yeah, I think that would work if there's a way to describe that. It's like if you're in an affiliate state and one of those zip codes, you're automatically taken care of. Everyone else goes into the national bin, regardless of zip code.

12:57 Aksana Rahouski: Right. And that way you don't have to play this game that if something is coming, one affiliate, let's say, is being deactivated, so now your job is to add all his zip code, 100 of them, to this national temporarily just to then reassign a month later, right? Which is kind of, if you kind of forget about, it's not going to be geographical coverage. It's just going to be the default state of whoever is not covered geographically.

13:31 Mike Garringer: Yeah.

13:32 Sandy Martins: Something that's also— Sorry, go ahead.

13:35 Mike Garringer: Well, just two questions. One, I'm just trying to think of like edge case scenarios. Like, is this going to cause a problem for someone in Kansas City, Missouri that's also running a program across the border in Kansas where we do have an affiliate. Like, I'm just— are there programs in here that have zip codes that one would be in a state where we've got an affiliate and one would maybe get assigned? I'm thinking about those, you know, border cases.

14:05 Tim Wills: The system already does that. If a program has multiple zip codes in different states, multiple affiliates are assigned to that program.

14:14 Aksana Rahouski: Okay, so then, yes, which again, this still exists if for whatever reason program zip code is covered by two affiliates, it shows up in two affiliate buckets. This is just kind of catch whoever is falling off these plates, right? We're right now to have a catch in the net.

14:33 Mike Garringer: And then Tim, I'm assuming you're okay with like some of our more regional affiliates, right? Like, so the folks, well, they're not an affiliate, but the folks in Ohio are just really doing Columbus.

14:45 Sandy Martins: Right?

14:45 Mike Garringer: Are we— or, you know, Milwaukee, right? Or Memphis? I'm assuming we're just giving them all of Tennessee.

14:52 Tim Wills: They only get the zip codes in which their service market is.

14:55 Sandy Martins: Okay.

14:56 Mike Garringer: All right.

14:57 Aksana Rahouski: Okay, so let's do this then. Maybe for now, so we just— we will add that to the list of enhancements because like I said, that one you can kind of— I mean, Option A, we still have to go the Option A, which we talked— we just create an affiliate and then we go find all the zip codes and add them, right? Time-consuming for you to do, time-consuming for you to maintain. Or we'll just add it to our list of enhancements and we'll just build it in as a feature. And we can review it as soon as— I'm working on, like I said, a slide deck for you guys to kind of— because there are a lot of things there we kind of talked about as opportunities to go after. We'll just have to figure out what are the ones that are going to be like jumping on immediately versus later. Versus never.

15:47 Sandy Martins: One thing I wanted to note, Hyun, is that we do a quarterly update of zip codes. So, to be aware that when that update is happening, that maintenance-wise on our side, we'll need to include those zip codes to the non-Mentor affiliate, to the Mentor National affiliate, in case it's not something that's captured right.

16:05 Aksana Rahouski: Yeah.

16:08 Hyun Masiello: And we currently provide a list of what was removed versus what was added or updated. So yeah.

16:17 Aksana Rahouski: Okay. So then really for today, I guess our goal is just to kind of— so we're code complete. I know you guys, UAT approved everything. I think it looks really good. I hope you guys are happy with it too. Like Hans said, just do another kind of run through and let's pick a date when we want to release it to production.

16:38 Tim Wills: Can we, one more thing on this zip code national affiliate thing for you to consider as we're thinking about this script? Because I think in the filter programs piece where you can search by state or by affiliate region, search by no affiliate region. And I say that because I think if somebody creates a new record and they put the zip code in wrong, where does that record go with that script, right? Like, we still need to figure out, we still need to think about that in this process. Because I think there's some records right now that have the zip codes incorrect, which is why they're not assigned to an affiliate.

17:24 Aksana Rahouski: Right. And that's where, again, ultimately that solution we're saying will still solve for that. If a program has a zip code and it was just accidentally put in wrong, it didn't match it to the affiliate it meant to match it to, it'll still collect it under that global affiliate. What you're asking, and on top of, as far as searching, right, like how do I find a list of 20 programs or whatever that are not under affiliate, or in this case under global affiliate, because now we're saying there is an affiliate for them all, we call it global.

18:00 Tim Wills: Well, like if an affiliate is if something is wrong in that zip code.

18:05 Hyun Masiello: Thing that— Do you mean like inputting like 4 numbers for the zip code.

18:11 Tim Wills: Or versus— 4 numbers or sometimes in the system I've noticed where like when you put in a full address with a zip code, it doesn't always work at assigning it to an affiliate.

18:22 Aksana Rahouski: So you're— I think you're like talking about slightly different. You're talking about like actual validation of a zip code at the moment of creating a program that if somebody punched in not valid zip code or they added address and zip code, we actually validate that this is correct information.

18:40 Hyun Masiello: We use Google.

18:41 Tim Wills: I'll find an example for you and.

18:43 Hyun Masiello: Send it to you because we use Google Places API. It's based on the zip codes are based on the community, like the service delivery. So community site-based. We have the Google API hooked up to it where it kind of auto-populates the location and such. So if, yeah, please Tim, send us like an example because I am curious if that, if there is an issue, that would be a bug.

19:08 Mike Garringer: So did we not have an issue where we were having to input basically fake zip codes in order to get another program to be able to say work with Mentor, Colorado, like we were giving them like a Colorado zip code even though they were not in Colorado. I want to say that was an issue that Nikki— That was the workaround.

19:30 Hyun Masiello: Nikki did to resolve the whole consulting, like, you know, affiliate from a different state being able to help out another state's NQMS review. Yeah, that was her workaround where she temporarily assigned those zip codes from the— I don't know if it was from the affiliate side or the program side zip code, but that way the Colorado— if the Colorado admin was reviewing California program, she either added a Colorado zip code to the program's location to officially make Colorado also an affiliate of that California program to work around it.

20:06 Mike Garringer: But would the API you just mentioned have caught that and prevented that at the time?

20:12 Hyun Masiello: No, because the API is just to validate the zip code or the location that it's at. It's not necessarily to block your program location is in California and therefore you can only type California. It's not like that.

20:26 Mike Garringer: So, okay, so I could say Boulder, Colorado, but have a California zip code or vice versa.

20:32 Hyun Masiello: You can add, you can put in Boulder, Colorado. It allows for multiple locations to be inputted. So you can put in Boulder, Colorado and then like California zip code or whatever.

20:43 Mike Garringer: So I'll try. I don't know the programs that that was done for, but I'll see if I can go in and find.

20:50 Hyun Masiello: Yeah, I can also try to find the example that she cited in that instance as well.

20:55 Mike Garringer: I don't think it was many.

20:58 Tim Wills: But she removed the zip code.

21:00 Aksana Rahouski: Yeah, she just talked about adding and then removing it. Remember, you mentioned it. I also want to call out, if we make validation more strict, like validating actually address against zip code, you will not be able to do those things anymore.

21:18 Tim Wills: Right. Yeah, that's why I was just looking for like a feature in the search to be able to still see a program that maybe was missed in the process.

21:29 Aksana Rahouski: And by— okay. And you mean— yeah, okay.

21:34 Tim Wills: I'll try to find an example of a program.

21:36 Aksana Rahouski: Yeah, just give me an example. Because like, again, there are ones that, let's say, I meant to assign my program to Minnesota, but instead of punching in the correct zip code, I added two zeros, right? It's a mistake that was made and now I created an orphan because it didn't attach it to Minnesota, which with the solution we're proposing, it will land on the national affiliate now because he grabs that affiliate, will grab whoever didn't find a home, right? Part 2 kind of of that, if do we want to actually prevent users from doing it, it's like put this guardrails around them so they cannot make these mistakes. But also it sounds like you guys intentionally sometimes do that because you do want to kind of give it affiliate access to another zip code.

22:26 Mike Garringer: Okay, so I just think there's no way to get around like transposing numbers where I flip the 7 and the 6 and now it's a different— I mean, that kind of human error is going to happen. I think as long as there's a way to just like say, show me all the nationally associated ones and like, oh, I see a Minnesota program. On this list, like, I know I need to fix that one. We can— that can't be that big of a number of programs that are— that have that kind of data error.

22:57 Aksana Rahouski: So do you like what— I guess I'm still kind of confused. Do we still kind of want to do both of these? Do we want to start with like mapping national affiliate zip codes to all the orphans that are out there today? Okay, and then part 2 programmatically would change the behavior of that affiliate to just despite the zip code, like in fact we will not be setting zip code, just grab whoever is left. Okay.

23:28 Mike Garringer: And Tim, I want to go back to what you raised around like an affiliate that had a bunch of programs assigned and now the affiliates like Florida, for example, like is it worth shifting all Florida to national or not, or leave it at Florida. I don't— I'm not sure the right.

23:46 Tim Wills: Answer there, but it's currently Independence Region and Ohio in the system that still have zip codes attached to their affiliate record. Those zip codes need to be removed before we run this script.

23:59 Aksana Rahouski: Okay. And again, we can run script, we can run it again. That's kind of the thing about patching data to reality, if we keep solving it that way, we have to always do that every month. There's some cadence that we want to follow. Whether if we build it into system default behavior is as soon as you make mistake, I catch it. A lot better investment for you.

24:33 Hyun Masiello: All right.

24:36 Sandy Martins: All right.

24:36 Hyun Masiello: So we'll work on the script and then there's going to just be some final testing if there's any, assuming, you know, based on your quick run-through, if there's anything else coming out of that, we would do any final testing on our side and hand it off to you to do any final testing on the feedback received. And then one of the things that we've done in the past that we always, we like to do is Brent wants to just take a snapshot of staging and then do just do a quick test run of the launch to make sure there's no issues. We are going to then go into a code freeze about 2 days prior to the actual go-live. So during that period, no code will be touched, we won't make any updates, etc. And then while this may— we don't expect any downtime. It should be a pretty quick and painless upgrade. But, you know, this is totally up to you about whether or not you want to notify any users. That might be highly unlikely, but I just wanted to put that out there. On launch day, I will reach out to just give you guys a heads up that we're starting the launch. We'll do a snapshot of the production as is, and then we'll do a code deployment. Then Daniel will give us a heads up to start testing. Oksana and I will just go around, go in and just poke around to make sure there's no issues, glaring issues, etc. Then we'll let you guys know that you guys can go in. Recommendation would be a critical path, just make sure that you can search for programs on the 3-step, apply to programs, get the emails, et cetera, on the NQMS. Make sure that you guys can.

26:09 Sandy Martins: Start.

26:10 Hyun Masiello: An NQMS, that the reporting is showing up correctly based on where it was last left in production, et cetera. We will also, if there's anything critical, meaning like system is down, multiple users will be affected, etc., like please let us know as soon as possible. Any other bug tickets we can go ahead and move over, we can use Trello for just things that we can put in the pipeline for support next. Yes, Sandy?

26:41 Sandy Martins: If we're going to add to the pre-launch, I know that there's cleanup or data cleanup we're expecting folks to be doing soon. Okay. Training is kicking off tomorrow. And we imagine that they'll begin cleanup next week. However, based on the date we select here for launch, we need to be careful about that so that way we're not running into any issues with folks accessing the system, updating stuff while we're doing this at the same time. So if we need to have a leeway for them to not access the system and maybe just update stuff on the spreadsheet while this is being done, I just want to make sure I give them a date that they can be able to log in and begin those changes.

27:19 Aksana Rahouski: Yeah, and I would say, yeah, and that's why again, we just, you guys pick a date. I mean, we could go anytime, we're ready to go. That's what we kind of want to do, like click through one more time, give us a date. And then yeah, I agree, if you have, if you're expecting kind of the high traffic days due to cleanup or whatever, like just kind of let those people know that whatever that day, and once we have a window, let's say 8 to 10, maybe to kind of like expect turbulence. And honestly, this is not a big release. Like, I don't expect anything major other than maybe I'll like log you out, or you shouldn't be able to like— it shouldn't be disruptive even if people are in the system.

28:07 Mike Garringer: So I think my— I talked with Sarah last week and We wanted to make sure that programs that are in the middle of filling out an assessment are not going to be impacted here because some of what they do in there is going to change, like how you do it. So if I'm a third of the way through my assessment and how I upload documents into this system change and section goals go away. Like, you know, there's just all these, like, the actual, like, it'll change in the middle of me doing it. And that sounds like if I'm live in the middle of doing it, like, right then and there, I may get logged out and that's, you know, I may lose some data. But I'm also thinking about folks that are just, like, halfway through that assessment and the next time they log in, it, like, looks different. And there may be no avoiding that, but I think we were just because we're ramming a lot of programs through NQMS right now. And so the odds that there'd be some program out there in America kind of in the middle of answering questions. So I was wondering about like timing of this. Could we, you know, do this, you know, in the middle of the night or late on a Friday or, you know, at a time when it's less likely that there'd be someone in there actively dragging documents into, you know, 'Cause I guess they'd lose some stuff if they were in there at that exact moment.

29:34 Aksana Rahouski: Yeah, and I will say so to that, I mean, definitely possibility, right? If somebody is like answering questions and not hitting save, right? Yes, and we push at that moment, it logs them out, they lose everything they did before the last save and the next save, right? But documents though, I'll tell you the way documents work technically it's as soon as you drag it saves. It looks like you have to save, but under the hood it actually saves as soon as you drag it. In terms of your user reacting to the change, that's going to be there whether it's immediate or when they wake up in the morning. I would say maybe you guys need to send an email with like, hey, we're doing a system upgrade, these are things to expect. So at least they expect things to change, you know, some new buttons show up, new data being displayed. So rather than kind of doing it while they're not online, because either way they might have questions, right? So if you try to avoid this like bombarding, it's like, why is this different? Maybe we write some kind of executive summary and just blast that email.

30:50 Mike Garringer: Yeah, my thinking was once we set the date, we can let all of our reviewers know, like, hey, this is the date we're going to be making some upgrades. And frankly, I don't think it would be a bad idea to have them contact the programs they're working with and say, hey, you know, you might want to tell your folks we're making some upgrades. Maybe don't input data on February 15th or whatever date we pick. You know, that's kind of transition day. You may want to give folks a heads up that it'll look a little different maybe when they log in next time. But I agree, we're going to have some issues there no matter what. I just wanted to make sure, like, if it would be helpful to tell folks, like, don't be futzing around in there on this day, we can send out that kind of messaging. I just want some lead time so that folks can hear that message and maybe pass it on to the programs they're working with.

31:44 Aksana Rahouski: Yeah, and you guys, that's why, like I said, we want you guys to set that date to give whatever that buffer you need to be comfortable with that.

31:55 Sandy Martins: Was there ever a timeframe that was discussed about going live, or is this the first time we're having that conversation?

32:02 Hyun Masiello: Yes, it's the first time we're having this conversation. I know typically with past launches, we usually do something in the morning as well as earlier in the week, so that way, because we want to avoid Friday launches in case something does come up that's critical, then it would go right into the weekend. So something at the start of the week, at the start of the workday for the team would be ideal.

32:25 Sandy Martins: So it seems like we have at least 3 things we need to be aware of. One, what Mike mentioned, the data cleanup that we're expecting people to get going on. And then of course the summit, which I believe we were told the week coming back, people have comp time. So we imagine folks will be taking that Monday off. So keeping those 3 things in mind to help try to figure out a nice week, usually a Monday, to go live with us.

32:53 Hyun Masiello: Yeah, and ORISIS is closed for President's Day on 2/16. Okay, that's another consideration to make. We can consider the 17th as well if, you know, Tuesdays are also okay too.

33:08 Mike Garringer: So I would be fine with either the 17th or the 23rd. I would like to get this done in February, kind of sooner rather than better. When I was talking with Sarah about it, it's like, well, we've got new features, things like the ability to set a date on a goal, you know, and like, I'd hate to have 20 assessments go in right before these improvements take place. So I think Yeah, that the 17th sounds okay to me. I don't know, Sandy, where you're thinking.

33:39 Sandy Martins: But I know that the 13th. So we have milestone dates that we're asking the data cleanup folks to report back to us on where they are. So the 13th, 27th, 13th, and 20th are the 4 milestone dates. It's a Friday, every other Friday starting in February. So you said 17th or the 23rd will be the 2 options.

34:02 Mike Garringer: I'd be fine with either of those. The 17th is probably my preference.

34:08 Aksana Rahouski: Yeah, I'm with Mike on that because I mean, these improvements that we're launching, like you'd want to ship them to users sooner than later to start benefiting from them, right? So like I would encourage not to sit on it for too long because there's value in these things, right?

34:27 Sandy Martins: Yeah, I agree. I think yeah, the week of the 16th. As long as that gives us time to also communicate or send out communications as well as prepare ourselves for that launch date.

34:41 Mike Garringer: And Sandy, if your folks are giving you kind of a report on where they're at on Friday the 13th, easy for you to be like, thanks for letting me know where you're at. Like, maybe pause for a couple of days.

34:55 Sandy Martins: That Monday we don't have it off, right? Because you said that's President's Day. You guys are cool?

34:59 Hyun Masiello: Yeah, that's President's Day.

35:01 Sandy Martins: Okay, so I imagine that's a holiday for other folks too. So yeah, okay. Yeah, okay.

35:15 Mike Garringer: So that then does give us some time that week after the summit to do some of this testing, I guess, and make sure everything's looking good.

35:26 Hyun Masiello: All right, cool. Then we're set for the 17th. So I think internally what's next for us is Oksana and I will get with Brent and Daniel to establish that date, time frame, etc., and then schedule out like Brent's test run, etc. And then yes, please, while, you know, as soon as possible, just do another quick pass through of staging and make sure everything looks good. Let us know if there's any issues there, and then we'll also talk about the script internally as well.

35:54 Aksana Rahouski: All right, sounds good.

35:57 Hyun Masiello: All right, well, thank you guys so much.

35:59 Mike Garringer: Yeah, thank you.

36:03 Hyun Masiello: Yeah, stay warm. All right, bye.