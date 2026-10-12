# Class Sign-Up — Starter Code

## Development Scenario

Your teammate has been building sign-ups for the campus recreation center's fitness classes and just left for a two-week vacation. They finished two classes, `Session` and `Schedule`. The code runs, but there are no tests yet.

Your team lead wants tests before anyone changes it, so that is your job: **write tests for the code that already exists.**

> Professor's Note: This is a teaching tool, **not how a real booking system works.** A real one would store sessions in a database, handle time zones, and keep a waitlist. The design here is kept small on purpose.

## Classes

### Session

- One scheduled class, such as Spin at 6 p.m. on Monday
- Has a title, a capacity (how many people can book), and a start time
- Keeps a roster of the names booked into it
- Takes bookings until it is full, and stops taking them an hour before the start
- Lets a booked person cancel, which frees their spot
- Prints its roster

### Schedule

- Holds the center's sessions
- Adds a session
- Lists the sessions that have not started yet, soonest first
- Finds the next session to start

## Running It

```text
ruby main.rb
```
