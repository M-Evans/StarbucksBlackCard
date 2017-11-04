# StarbucksBlackCard

This was a small hackathon project.
The goal is to get an easily scalable number of daily rewards from Starbucks.
It's a proof of concept for a potential abuse vulnerability in the birthday reward system.


## Disclaimer

I have never used this system, nor should anyone else.
This project is purely for demonstration of a proof of concept.
Actually performing this attack could be considered fraud, carrying heavy penalties.


## Description

As stated previously, this system involves Starbucks' birthday reward system.
Here are some mechanics of this system:

* Each account can set a birthday.
* On the account's listed birthday, a reward (one free drink / food item) is placed on the associated card.
* A caveat to the above mechanic is that a card needs to be associated with an account for at least 30 days before being elegible to receive a reward.
* This reward is available on the first of the month, and up to 15 days after the end of that month.

So naturally, if we want to get 1 free item every day, we just need to set up 365 accounts with 365 cards!

But that's a lot of work....
Let's break this down.


### Email Addresses

First, we'll tackle the email addresses for each of these accounts.
It is possible to create 365 of them,
but maintainance of all those accounts would serve to double our work.
We could host our own email server and setup custom aliases, but that takes a lot of effort to setup.
Instead, we'll take advantage of the fact that Gmail ignores periods in email address names.

This means we can easily create an exponential number of seemingly-different email accounts using just one account.
Starbucks doesn't account for periods when signing up for an account.
So: we can easily fake 365 unique email addresses with a single address.

What about those cards?

### Gift Cards

As it turns out, with just $5, you can get as many gift cards as you'd like!
An inductive proof:

1. Buy a Starbucks Gift Card for $5
1. Use the Starbucks Gift Card with a balance of $5 to purchase another gift card
1. Repeat step (2) until you have 365 cards

Now, the cashier may get angry at you for doing this.
And we even encountered one store that didn't allow us to buy gift cards with gift cards!
But all the others did allow this, in small quantities of 10 when they weren't busy.

But wait - is there a better way than getting 365 cards?
Could we do this with fewer?
If so, how?

Well, taking a look back to how the birthday reward system works,
we notice that we only *really* need a card on the account for the 30 days prior to the associated birthday.
In theory, with only 31 cards, you could keep the birthdays going for the whole year,
only putting a card on an account long enough in advance so that the birthday reward isn't missed.

### Putting That All Together

Let's take a step back and look at the big picture.
We have a way of tricking Starbucks into creating accounts for us using only a single email address.
We also have a way of getting an unlimited number of starbucks gift cards to use with each account.
If we want to use fewer cards, it is possible if we cycle them out in time for the reward to be applied.

This leaves two things that need to be done:

1. We need to sit there and create 365 accounts.
1. Every day, we need to cycle out a card between two accounts to make sure that we get the next reward.

That's where this project comes in.


## What's Included With This Project?

The script `createAccounts.sh` is used to create the initial 365 accounts that cards will be switched between.

The script `switchAccounts.sh` is used to log out of / into each account, add a card to an account, and remove a card from an account.

The source file `permute.cpp` is a small c++ program that accepts an email address via command line, permutes it with periods, and prints the result to `stdout`

The scripts rely heavily on `xdotool` to automate browser interactions.

The proper environment for these scripts is a 1600x900 screen using the Google Chrome web browser on Linux with the i3 window manager.

With a bit of configuration, you can get it to work on your system too!
Although you shouldn't.


## Todo

* Re-write the automation portion in Selenium
* Re-work switching interface to allow for multiple cards to be switched around
* Include example `cron` configuration for automated card rotation

If I'm being completely honest, though, none of this will get done.


## FAQ

* **Q**: Can a card with zero balance be used to redeem birthday rewards?<br>
**A**: Yes. I've tested this.

* **Q**: Can cards still get a reward after being used to redeem a reward on a separate account?<br>
**A**: Yes. I've tested this.

* **Q**: Are you sure Starbucks will allow you to create multiple accounts tied to the same email address, differing only by a single period?<br>
**A**: Yes, I've tested this.

* **Q**: Why use $5 to buy the initial card?<br>
**A**: That's the minimum balance that is allowed when you purchase a Starbucks Gift Card.

* **Q**: Can't Starbucks notice this suspicious activity?
The multiple accounts that are all named similarly?
You showing up every day for a free birthday item?<br>
**A**: Yeah, probably. Don't try it.

* **Q**: Did you win anything for this project?<br>
**A**: Nope

