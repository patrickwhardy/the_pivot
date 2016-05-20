## Tiny Stay: an AirBnB clone for Tiny Homes
[Hosted live on heroku here!](http://tinystay.herokuapp.com/)

![](app/assets/images/demo.gif)


This site was built by Ashwin Rao, Josh Washke and Patrick Hardy in the first week of module 3 at the Turing School of Software and Design. We adapted an existing tool-rental application to handle multitenancy and significantly extend features implemented. It was undertaken to solidify our understanding of Ruby on Rails, writing and implementing user stories, SQL design, search functionality, and hosting production-quality web apps on heroku. The site successfully integrates geocoder, gmaps4rails, jquery UI elements, bootstrap and AWS with paperclip.

## Project Description(per Turing School)
Your Little Shop of Orders application was *almost* great, but it turns out that we need to *pivot* the business model.

In this project, you'll build upon an existing implementation of Little Shop. You will transform your restaurant ordering site into a platform that handles multiple, simultaneous businesses. Each business will have their own name, unique URL pattern, items, orders, and administrators.

The project requirements are listed below:

* [Learning Goals](#learning-goals)
* [Teams](#teams)
* [Setup](#setup)
* [Workflow](#workflow)
* [Technical Expectations](#technical-expectations)
* [Pivots](#pivots)
* [Base Data](#base-data)
* [Evaluation](#evaluation)

## <a name="learning-goals"></a> Learning Goals

During this project, you'll learn about:

* Working with Multitenancy
* Implementing JavaScript
* Securing a Rails App
* Sending Email
* Creating Seed files

## <a name="teams"></a> Teams

The project will be completed by teams of three to four developers over the span of two weeks.

You will name a team leader that will:

* Transform business requirements into user stories.
* Work with the customer to establish team priorities.
* Seek clarification from the customer when a user story is not clear.
* Make sure that all the team members are on track and collaborating following a professional workflow.

Like all projects, individual team members are expected to:

* Seek out features and responsibilities that are uncomfortable.
* Support your teammates so that everyone can collaborate and contribute.
* Follow a professional workflow when developing a feature.

## <a name="setup"></a> Setup

### Project Starting Point

You'll build upon an existing code base assigned by the instructors. You need to work on adapting and improving this codebase, not building your own thing from scratch. This is sometimes called "brownfield" development, and you'll soon know why.

### Exploring the Little Shop App

As a group, dig into the code base and pay particular attention to:

* Test coverage and quality
* Architectural concerns
* Components that are particularly strong or weak
* General strengths and weaknesses

### Beginning The Pivot

Once you've explored the base project, the team leader will:

* Create a new, blank repository on GitHub named `the_pivot`
* Clone the Little Shop project that you'll be working with to your local machine
* Go into that project directory and `git remote rm origin`
* Add the new repository as a remote `git remote add origin git://new_repo_url`
* Push the code `git push origin master`
* Add the other team members as collaborators in Github

Once the team leader has done this, the other team members can fork the new repo.

### Tagging the Start Point

We want to be able to easily compare the change between the start of the project and the end. For that purpose, create a tag in the repo and push it to GitHub:

* $ git tag -a little_shop_v1
* $ git push --tags

### Restrictions & Outside Code

Your project should evolve, refactor, and clean up the code you inherit. This includes deleting redundant, broken, or obsolete code. However, you should **not** throw out the previous work wholesale.

Furthermore, there should be *no reduction in functionality* except when explicitly called for by new requirements.

### Project Management Tool

There are many popular project management tools out there. For this project we'll use a lightweight tool that wraps GitHub issues: [Waffle.io](https://waffle.io/)

Setup a Waffle project for your new repo. Your team members and instructors should be added to the project so they can create, edit, and comment on issues.

## <a name="workflow"></a> Workflow

### Client Interaction

You will meet with the client frequently to obtain his/her business needs and correct course. You will transform these requirements into user stories.

A feature will not be considered complete until it is working on production. You must assume that your client doesn't have any programming experience. You will have to learn how to manage expectations.

The stories as written and prioritized in your project management tool will be the authoritative project requirements. They may go against and likely go beyond the general requirements in this project description.

As the stories clearly define the customer's expectations, your application needs to **exactly** follow the stories as they've been developed with your customer. A 95% implementation is wrong.
