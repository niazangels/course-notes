# Shape Up

- Author: Ryan Singer
- URL: https://basecamp.com/shapeup

# Chapter 1: Introduction

## Six week cycles
- long enough to build something meaningful  and short enough that everyone feels the deadline looming from the start

## Shaping the work
- Done before its handed over to the team
- A small senior group works in parallel to the cycle teams to define key elements of a solution
- Concrete enough that the teams know what to do, yet abstract enough that they can work out the details
- Instead of asking how much time it will take to do some work, we ask: How much time do we want to spend? How much is this idea worth? 

## Making teams responsible
- Give full responsibility to team of designers and programmers to their own tasks, **make adjustments to the scope**, and work together to build vertical slices of the product one at a time

## Targetting risk
- Risk of not shipping on time, not risk of building the wrong things (Read the book: [Competing against luck](https://www.amazon.com/Competing-Against-Luck-Innovation-Customer/dp/0062435612))
- Reduce risk by solving open questions before commiting to a project. Don't give something out that has gaping holes and tangled dependencies.
- If a project runs over 6 weeks, by default it doesn't get an extension. 
- Build one meaningful piece of the work end-to-end early on and then repeat
- Integrating as soon as possible, learn from feedback


# Part 1 - Shaping


# Chapter 2: Principles of Shaping

## Wireframes are too concrete

- wireframes or high-fidelity mockups define too much detail too early, leaving designers no room for creativity.
- > "I know you're looking at this, but that's not what I want you to design. I want you to re-think it!" It's hard to do that when you're giving them this concrete thing. - 
- @niazangels is guilty of the above :(

## Words are too abstract
- Opposite side of the spectrum 
- 
  - > "Perform a semantic search"
  - > "Add notifications"
  - > "Build a calendar view"
- **Under-specified projects naturally grow out of control** because there's no boundary to define what's out of scope.

> Past versions of Basecamp had calendars, and only about 10% of customers used them. That's why we didn't have the appetite for spending **six months** on a calendar. On the other hand, if we could do something to satisfy those customers who were writing us in one **six week cycle**, we were open to doing that.
>
> With only six weeks to work with, we could only build about a tenth of what people think of when they say "calendar." The question became: which tenth?

## Properties of Shaped Work
  1. It's rough
      - Everybody knows its unfinished
      - Leave room for designers and programmers to assess trade offs, apply their judgement
  
  2. It's solved
     - clear direction showing what to do, even if its rough
     - no known holes
  
  3. It's bounded
      - clearly indicates **what not to do**
      - fixed amount of time requires limiting the scope and leaving specific things out

## Who shapes?
 - Inferface + Technology for solving Business problems
 - Shaping is primarily design work
 - Questions:
   - What are we trying to solve? 
   - Why does it matter? 
   - What counts as success? 
   - Which customers are affected? 
   - What is the cost of doing this instead of something else?
 -  Closed door activity - private, rough, early work.
 -  Move fast, speak frankly and jump from one promising position to another
 -  No one outside the room should be able interpret


## Two tracks
- Unshaped work is risky. So keep two separate tasks:
  - **Shaping**
    - shapers are working on what the teams might potentially build in a future cycle
  - **Building**
    - building work that's been previously shaped 
    - 
> Work on the shaping track is **kept private and not shared with the wider team** until the commitment has been made to bet on it. That gives the shapers the option to put work-in-progress on the shelf or drop it when it's not working out.

## Steps to shaping
1. **Set boundaries**
   - define the problem
   - assess how much time the idea is worth
2. **Rough out the elements**
   - abstract sketches
   - output is an idea that solves the problem within time, finer details are left out
3. **Address risks**
   - find holes, unanswered questions
   - amend solution, cut out scope
   - prevent team from getting stuck
4. **Write pitch**
   - package it with a formal write-up called a pitch.
   - The pitch summarizes the **problem, constraints, solution, rabbit holes, and limitations**. 
   - The pitch goes to the betting table for consideration.


# Chapter 3 - Set boundaries
- A raw idea is an **unshaped** idea. eg. "customers are asking for group notifications"

## Setting the apetite
> Sometimes an idea gets us excited right away. In that case we need to temper the excitement by checking whether this is really something we're going to be able to invest time in or not. 
> 
> If we don't stop to think about **how valuable the idea is**, we can all jump too quickly to either committing resources or having long discussions about **potential solutions that go nowhere**.

- Apetite is set in 2 batches:
    - **Small Batch**: This is a project that a team of one designer and one or two programmers can build in one or two weeks. We batch these together into a six week cycle (more on that later).
    
    - **Big Batch**: This project takes the same-size team a full six-weeks.

## Fixed time, variable scope
> When you have a deadline, all of a sudden you have to make decisions. With one week left, I can choose between fixing typos or adding a new section to a chapter.

## "Good" is a relative term
- Without a time limit, there's always a better version
- The amount of time we set for our appetite is going to lead us to different solutions
- We can only judge what is a "good" solution in the context of how much time we want to spend and how important it is.

## Responding to "raw ideas"
- Default response should be a very soft "no" that leaves all our options open. We don't put it in a backlog.
- It's too early to say "yes" or "no" on first contact. Even if we're excited about it.
- We don't want to shut down an idea that we don't understand. New information might come in tomorrow that makes us see it differently. 
- Showing too much enthusiasm right away can set expectations that this thing is going to happen. 
- @niazangels - Step 3 infinite scroll idea from client

## Narrow down the problem

> We once had a customer ask us for more complex permission rules. It could easily have taken six weeks to build the change she wanted. Instead of taking the request at face value, we dug deeper. 
> 
> It turned out that someone had archived a file without knowing the file would disappear for everyone else using the system. 
> 
> Instead of creating a rule to prevent some people from archiving, we realized we could put a warning on the archive action itself that explains the impact. **That's a one-day change instead of a six-week project.**

- Ask "why they want it" and "when did they wish for it". Discover the underlying reason to cut scope and prevent working on the wrong things
- Compare against baseline: A baseline is what customers are doing without the thing they're asking for.
- If it's not critical, or problem is unclear, walk away from it. Maybe a future request will give us more insight.

## Watch out for "grab bags"
- worst requests are "redesigns" or "refactorings" that aren't driven by a single problem or use case
- "redesign the Files section," is a grab-bag, not a project.
- a more productive starting point: "We need to rethink the Files section **because sharing multiple files takes too many steps.**" Now we can start asking questions. 

## Boundaries in place

- If you have the following, you have enough to start building solutions
  - A raw idea
  - An appetite
  - A narrow problem definition


# Chapter 4: Finding the Solution

- There could be dozens of different ways to approach the solution for a problem. It's important to move fast and cover a lot of different ideas without getting dragged down.

## Move at the right speed
- First, we need to have the right people—or nobody—in the room. Either we're working alone or with a trusted partner who can keep pace with us.
- Second, we need to avoid the wrong level of detail in the drawings and sketches

- Key questions to ask yourself:
  - Where in the current system does the new thing fit?
  - How do you get to it?
  - What are the key components or interactions?
  - Where does it take you?

## Breadboarding
- To keep away from touching finer details: Use  breadboarding and fat marker sketches
![Breadboarding](https://basecamp.com/assets/books/shapeup/1.3/ee_breadboard-f576c579fcb3f3865a3004c9e9e53fd0c97fa14e65a7b81af3ec6fbfe7b31832.png) 

- There are three basic things to draw:
  - **Places** : These are things you can navigate to, like screens, dialogs, or menus that pop up.
  - **Affordances** : These are things the user can act on, like buttons and fields. **We consider interface copy to be an affordance, too**. Reading it is an act that gives the user information for subsequent actions.
  - **Connection lines**: These show how affordances from place to place.

### Example 1: Autopay
- 😍😍[Fantastic example of Autopay idea development](https://basecamp.com/shapeup/1.3-chapter-04#example)

- Write the name of the place where the activity starts
![1](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_1-25781b16ae10b5eaed1435083bcef365aaab2b85c456ad5ec09a71417a947afc.png)

- Add affordances underneath it
![2](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_2-84ee832bc6c16270aa01254fbf4f37440351618cf91ca179f26b864919ff5bf1.png)

- Draw connection lines to new places
![3](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_3-0a3eb32573d30903a36952d8b90a9fb284bd69c4be3d6f67e8b42a1001f7c55c.png)

- Show simple notification- that's a new place
![4](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_4-38a0b07e2598b2a428c6b8c8d5c4c7d6d2dcefc2f7a1d9e7ee6eb9f97f0c06b1.png)

- Question: Did we actually pay the original invoice or not? Now we have both functional and interface questions. And where do we explain this behavior? We could add an option to the Setup screen 
![5](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_5-b336abd287b752f0f38c15546d2d7a7981b9182733f1a0a9e8be4be4886a65be.png)

- But now we're complicating the responsibilities of the confirmation screen. We're going to need to show a receipt if you pay your balance now. Should the confirmation have a condition to sometimes show a receipt of the amount just paid?

- How about an entirely different approach. Instead of starting on an Invoice, we make Autopay an option when making a payment. This way there's no ambiguity about whether the current amount is being paid.
 ![6](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_6-728e11c77b57f3c4ee56c00187a7c760562090f3733a4aec43cc05a2f95bb003.png)

- What about after Autopay is enabled? How does the customer turn it off? Up to this point, many customers in the system didn't have usernames or passwords. They followed tokenized links to pay the invoices one by one.

- The team in this case decided that adding the username/password flows was too much scope for their appetite at the time.

- We could add a single option to disable Autopay in the customer detail page that we already offered to invoicers. (like unsubscribe in newsletters) ![7](https://basecamp.com/assets/books/shapeup/1.3/invoice_breadboard_7-c7e70620d06da7e00aac001f486d3cb0623bf08be7a5d11089b0bb40d9705d82.png)

- Illustrates the level of thinking and the speed of movement to aim for during the breadboarding phase

## Fat marker sketches
- Sometimes the idea we have in mind is a visual one. Breadboarding would just miss the point because the 2D arrangement of elements is the fundamental problem.

- Pen size set to a large diameter.

### Example 1: Dividers in TODO lists

- Loose concept 
![1](https://basecamp.com/assets/books/shapeup/1.3/fat_marker_1-0584765a210e4d2c130096bbc8e862c363328afb9f227ecbc89421fe6a2544ef.png)

- Some affordances ![2](https://basecamp.com/assets/books/shapeup/1.3/fat_marker_2-570c445ea82290154b6a06b625ee31fbe780c62ff653ada1be939366bf39c103.png)

- Were afraid it might break the flow of the lists

- Add affordance inside existing menu to the left ![3](https://basecamp.com/assets/books/shapeup/1.3/fat_marker_3-c2e60aa68225483109cc5ac60f069867b0b739c8c246f76816d10f49f783d58b.png)

## Elements are the output

- Autopay
  - A new "use this to Autopay?" checkbox on the existing "Pay an invoice" screen
  - A "disable Autopay" option on the invoicer's side

- Todo
  - Loose to-dos above the first group belong directly to the parent
  - Grouped to-dos appear below the loose to-dos
  - We'd like to try an add affordance within each section, but if that doesn't work visually, we're ok with relying on the action menu for inserting to-dos into position.

- @niazangels: Multiple solutions are acceptable at this stage
- Calendars ![Calendar](https://basecamp.com/assets/books/shapeup/1.3/calendar_dot_grid-7d1e375f646a32517d5d8d7ad444e45a09a54ac8f27e0abb059d71bd68650e55.png)
  - A 2-up monthly calendar grid
  - Dots for events, no spanned pills
  - Agenda-style list of events below that scrolls an event into view when you tap a dot

- **This list of elements is extremely narrow and specific compared to "monthly calendar".**


## Room for designers
- You don't want to have to say "I know I drew it like this but ignore that…"

## Not deliverable yet
- It's normal for the artifacts at this point to be indecipherable to anybody who wasn't there with you.

- We’ve gone from a cloudy idea, like “autopay” or “to-do groups,” to a specific approach and a handful of concrete elements. But the form we have is still very rough and mostly in outline.

- The next step is to do some stress-testing and de-risking. Then we wrap up with a pitch,

## No conveyor belt
- At this stage, we could walk away from the project. We haven’t bet on it.
- We added value to the raw idea by making it more actionable.


# Chapter 5 - Risks and Rabbit holes

- Shaped up work could be derailed off the 6 week timeline if there is even one major hole

- There will always be unknowns, as is tackled in part 3.

## Different categories of risk
- Well thought out work looks like this:
![Well thought out work](https://basecamp.com/assets/books/shapeup/1.4/thin_tailed-a2d3f4ecb256e5766db72e80cde6815c6fa42058d90063c3f4edd423f752905f.jpg)

- If there are unsolved technical challenges or design problems, or misunderstood interdependencies 
![Not well thought out](https://basecamp.com/assets/books/shapeup/1.4/fat_tailed-5fb8e1135bd81c8b8cee8bba29be34ec985a983698a65f9aaefdef79ab63b575.jpg)

## Lookiking for Rabbit Holes
- Fleshing out the elements of the solution was a fast-moving, exploratory process. It was more breadth than depth

-  Did we miss anything? Are we making technical assumptions that aren't fair?

- Questions to consider
  - Does this require new technical work we've never done before?
  - Are we making assumptions about how the parts fit together?
  - Are we assuming a design solution exists that we couldn't come up with ourselves?
  - Is there a hard decision we should settle in advance so it doesn't trip up the team?

## Case study: Patching a hole

- In the case of todo lists, what happens to the completed items? 
  - In the pre-existing design, the latest few completed items displayed below the list. 
  - Should we now render completed items at the bottom of each group instead of the list? 
  - Or should we continue to show completed items at the bottom, and repeat the same set of dividers within the completed items section? 
  - Should we reconsider how we handle completed items entirely?

- If we didn’t address it, we’d be pushing a deep design problem down to the team and unreasonably asking them to find a solution under deadline. 
- We would leave the completed items exactly as they worked previously. Instead of grouping or segmenting them, we would just append the name of the group to each completed item.![Messy](https://basecamp.com/assets/books/shapeup/1.4/completed_items-0140398be104a5ec897f74c0030812c13f7006cdb6b377b8ab5e3bebdbcece98.png)
- When writing the pitch point out this specific “patch” as part of the concept, so nobody down the line will get tripped up on it.

- @niazangels: I would never go for that solution!

## Declare out of bounds
- Team mates will of course look for all the use cases to cover and consider them necessary. 
- Scope hammering: Forcefully questioning a design, implementation, or use case to cut scope and finish inside the fixed time box.
- Explicitly mark off the other cases as “out of bounds” for the project and focus on the win we want

## Cut back
- There may be parts of the solution we got excited about during the sketching phase that aren’t really necessary.
- Mention the nice-to-haves, but everyone should start from the assumption that the feature is valuable without it.

## Present to technical experts
- Communicate that this is just an idea. It’s something you’re shaping as a potential bet
- “Here’s something I’m thinking about… but I’m not ready to show anybody yet… what do you think?”
- In software, everything is possible but nothing is free.
- Instead of asking “is it possible to do X?” ask “**is X possible in 6-weeks?**” That’s a very different question.
- You’re looking for risks that could blow up the project.
- Rather than writing up a document or creating a slideshow, invite them to a whiteboard and **redraw the elements as you worked them out earlier**, building up the concept from the beginning
- open it up and invite them to suggest revisions.

## De-risked and ready to write up

- we have the **elements** of the solution, **patches** for potential rabbit holes, and **fences** around areas we’ve declared out of bounds.

- **Betting table**: A meeting during cooldown when stakeholders decide what bets to make

- we write it up in a form that communicates the boundaries and spells out the solution so that people with less context will be able to understand and evaluate it

- This pitch will be the document that we use to 
  - lobby for resources, 
  - collect wider feedback if necessary
  - capture the idea for when the time is more ripe


# Chapter 6 - Writing the Pitch

- The purpose of the pitch is to present a good potential bet. 

- Put the concept into a form that other people will be able to understand, digest, and respond to.

- There are five ingredients that we always want to include in a pitch:
  - **Problem** — The raw idea, a use case, or something we’ve seen that motivates us to work on this
  - **Appetite** — How much time we want to spend and how that constrains the solution
  - **Solution** — The core elements we came up with, presented in a form that’s easy for people to immediately understand
  - **Rabbit holes** — Details about the solution worth calling out to avoid problems
  - **No-gos** — Anything specifically excluded from the concept: functionality or use cases we intentionally aren’t covering to fit the appetite or make the problem tractable

## Ingredient 1. Problem
- Always present a problem and a solution together.

- Without a specific problem, there’s no test of fitness to judge whether one solution is better than the other.

- The best problem definition consists of a single specific story that shows why the status quo doesn’t work. 

- What if the problem only happens to customers who are known to be a poor fit to the product? We could spend six weeks that only benefits a small percentage of customers known to have low retention.

## Ingredient 2. Appetite
- Six weeks, not three months, or—in the case of a small batch project—two weeks, not the whole six weeks.

- Stating the appetite in the pitch prevents unproductive conversations. There’s always a better solution given infinite time.

## Ingredient 3. Solution
- Problems with no shaped up solution is not ready to be bet upon and should be avoided

- Giving it to a team means pushing research and exploration down to the wrong level where resources are limited

- Slow down and prepare a proper presentation. Stay high level, but add a little more concreteness than in the finding elements phase.

- Don’t over-specify the design. They’ll box in the designers who do the work later.

- Instead of this: ![Sketch](https://basecamp.com/assets/books/shapeup/1.5/payment_form_breadboard-277e13785f0ce02963ecd00ed13178b8fa6d1694097bd240188f2f1126a1683b.png)

- Have this: ![Mock](https://basecamp.com/assets/books/shapeup/1.5/fat_marker_dashboard-8e3d19b9388470aea447a7d57d8aed50fe7c2a00952922a9b1d442a6ac38fec4.png)

- The downside is we’ve gotten into some layout decisions that would have been nice to avoid.

- selectively get into more visual detail because we need it to sell the concept.

### Annotated fat marker sketches
- ![Annotations](https://basecamp.com/assets/books/shapeup/1.5/fat_marker_todo_groups-904d6525a3daf8496c7d61bf20b4f04afc7868ddcf4ad174e2deefaf3038f9ea.png)

- Or use callouts ![Callouts](https://basecamp.com/assets/books/shapeup/1.5/annotated_fat_marker_sketch-674c176b4187fe19ff4d633282201928a983e3f9aa8e422c5952ce01e540c551.jpg)

## Ingredient 4. Rabbit holes
- Usually just requires a few lines of text.

## Ingredient 5. No Gos
- Anything we’re not doing in this concept
- eg. Decide up front that they wouldn’t allow any kind of WYSIWYG editing of the form.
- WYSIWYG might be better in some peoples’ eyes, but given the appetite it was important to mark this as a no-go.


## Example 1: Todo Groups
![Todo Groups](https://basecamp.com/assets/books/shapeup/1.5/to-do_groups_pitch-ac9465339dfffb0b9cf634064b51b4d9336fe6d5c7410f7ed80abd1c1fbe5305.png)

## Example 2: Dot Calendar
![Dot Calendar](https://basecamp.com/assets/books/shapeup/1.5/group_notifications_pitch-ba3f748fe757356b59d0c63560bddf4744efb49b0e4dbd874a2f6cdb2faa1c7f.png)

## Example 3: Sort messages
![Sort](https://basecamp.com/assets/books/shapeup/1.5/in_basecamp/sort_messages-45fcd7f0e22f160ca59e6900590f19968f54d9ae416865396062fd4b061df449.png)


## Ready to present
- Async communication by default and escalate to real-time only when necessary
-  This gives everyone the maximum amount of time under their own control for doing real work, keeps the betting table short and productive
- People comment on the pitch asynchronously. Not to say yes or no — that happens at the betting table — but to poke holes or contribute missing information.

# Chapter 7: Bets, not backlogs

## No backlogs
- Backlogs are a big weight we don’t need to carry.
- tasks pile up that we all know we’ll never have time for
- growing pile gives us a feeling like we’re always behind even though we’re not
- **Just because somebody thought some idea was important a quarter ago doesn’t mean we need to keep looking at it again and again.**
- Big time wasters too. Time is spent constantly reviewing, grooming and organizing old ideas.

## A few potential bets

- Before each six-week cycle, we hold a betting table where stakeholders decide what to do in the next cycle.

- At the betting table, they look at pitches from the last six weeks — or any pitches that somebody purposefully revived and lobbied for again.

- Nothing else is on the table. No backlog issues.

- If we decide to bet on a pitch, it goes into the next cycle to build. If we don’t, we let it go. There’s nothing we need to track or hold on to.

- What if the pitch was great, but the time just wasn’t right? Anyone who wants to advocate for it lobbies for it six weeks later.

## Decentralized lists

- Everyone can still track pitches, bugs, requests, or things they want to do independently without a central backlog.

- Support can keep a list of requests or issues that come up more often than others. Product tracks ideas they hope to be able to shape in a future cycle. Programmers maintain a list of bugs they’d like to fix when they have some time. There’s no one backlog or central list and none of these lists are direct inputs to the betting process.

- Regular but infrequent one-on-ones between departments help to cross-pollinate ideas for what to do next. Support can tell Product about top issues- which Product may shape up

- People from different departments can advocate for whatever they think is important and use whatever method works for them to track those things

- This way the conversation is always fresh. Anything brought back is brought back with a context, by a person, with a purpose. Everything is relevant, timely, and of the moment.

## Important ideas come back
- Ideas are cheap. They come up all the time and accumulate into big piles. Really important ideas will come back to you
- A bug that customers are running into from time to time—it’ll come back to your attention when a customer complains again or a new customer hits it.
- @niazangels Step 3 "Accept all", "Accept" from Step 2.

# Chapter 8 - The Betting Table

## Six week cycles
- Need to know who is available and for how long in case of overlapping projects
-  A cycle gives us a standard project size both for shaping and scheduling.
-  Two weeks is too short to get anything meaningful done and have high planning overhead. 
-  Cycles need to be long enough to do meaningful work but short enough to ensure that people feel the deadline looming from the start

## Cool Down
- Six week cycle + 2 week cool down
- Need time to breathe and think about what’s next
- The **end of a cycle is the worst time to meet** and plan because everybody is too busy finishing projects and making last-minute decisions in order to ship on time.
- During cool-down, programmers and designers on project teams are free to work on whatever they want.They use it to fix bugs, explore new ideas, or try out new technical possibilities.

## Teams and project sizes
- 1 designer + 2 programmers
- 1 QA does the integration testing later 
- Teams will either spend:
  - entire cycle working on one project (big batch)
  - work on multiple smaller projects during the cycle (small batch)
-  Small batch projects run one or two weeks, and are decided by the team how they can be scheduled


## The betting table
- Output of the call is a cycle plan. 
- CEO, CTO, a senior programmer, and a product strategist
- the call rarely goes longer than an hour or two
- There’s no “step two” to validate the plan or get approval. And nobody else can jump in afterward to interfere or interrupt the scheduled work.
- meeting is short, the options well-shaped, and the headcount low.

## The meaning of a bet
- “betting”, instead of planning, sets different expectations.
  - First, **bets have a payout**. We’re not just filling a time box with tasks until it’s full.
  - Second, **bets are commitments.**: we commit to giving the team the entire six weeks to work exclusively on that thing with no interruptions.
- Third, a smart bet has a cap on the downside. If we bet six weeks on something, the most we can lose is six weeks.
- @niazangels: `diffs` feature would have been better to be time boxed and discarded if we had made a bet for 2 weeks

## Uninterrupted time
- It’s not really a bet if we say we’re dedicating six weeks but then allow a team to get pulled away to work on something else. **When you make a bet, you honor it**.
- When you pull someone away for one day to fix a bug or help a different team, you don’t just lose a day. **You lose the momentum they built up and the time it will take to gain it back**. 
- What if something comes up during that six weeks? The maximum time we’d have to wait is six weeks. Do not interrupt the team.
- It’s very important to only bet one cycle ahead. This keeps our options open to respond to these new issues. 
- If it’s a real crisis, we can always hit the brakes. But true crises are very rare.

## The circuit breaker
- We combine this uninterrupted time with a tough but extremely powerful policy. 
- Teams have to ship the work within the amount of time that we bet. **If they don’t finish, by default the project doesn’t get an extension**.
- First, it eliminates the risk of runaway projects. If it was allowed 6 weeks, we prevent it from taking 2x-3x that time.
- Second, if a project doesn’t finish, it means we did something wrong in the shaping. Instead of investing more time in a bad approach, the circuit breaker pushes us to reframe the problem. 
- .Circuit breaker thus ensures one project doesn’t overload the system. 
- Finally, the circuit breaker motivates teams to take more ownership including making trade-offs about implementation
-  A hard deadline and the chance of not shipping motivates the team to regularly question their design and implementation wrt. scope

## What about bugs?
