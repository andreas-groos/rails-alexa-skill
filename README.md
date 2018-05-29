# Introduction

Recipes (Repeat My Recipes) is a simple rails implementation of an Alexa skill.

It provides a web interface for user's to sign up and input and edit recipes.  

User's can than interact with Alexa which hits an "ask" action in the alexa controller.


# Getting Started

### Dependencies

```
bundle install
yarn install
```

### Database configuration

This application relies on postgresql trigram indexes to resolve approximate language to recipes.  For example, "lobster thermos" would lookup "lobster thermidor."  So you'll need to setup a postgresql database and an appropriate database.yml file.


# Alexa Endpoint

Most of the action happens in **app/controllers/alexa_controller.rb**

There is a single action "ask" which is the main entry point for all intents.  This has a big case statement for resolving the intents.  Future work could involve a DAG like routing mechanism for more complex workflows.

For more information on developing a skill, checkout the documentation at https://developer.amazon.com/alexa-skills-kit


### Thanks

This application is so simple thanks to the helpful work of https://github.com/damianFC/alexa-rubykit
