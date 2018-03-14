# ExDesk

A library for accessing [The Desk.com API](http://dev.desk.com). 

I used this as a project to help with learning Elixir and is very much a work in progress. Feel free to comment and or contribute :)

## Installation

The package can be installed via:

  1. Add `exdesk` to your list of dependencies in `mix.exs`:

        def deps do
          [{:exdesk, "~> 0.1.0"}]
        end

  2. Ensure exdesk is started before your application:

        def application do
          [applications: [:exdesk]]
        end

## Usage and examples
  To configure the authorization globally, you can either call `ExDesk.configure`:
  
    ExDesk.configure(
      site_name: "yoursite.desk.com",
      email: "your@email.com",
      password: "yourpassword"
      )
  Or set a `EXDESK_CONFIG` environment variable with site_name, email and password separated by commas.
  * this environment variable will override all config calls from within the application.
  
    $ EXDESK_CONFIG=test.desk.com,your@email.com,yourpassword iex -S mix
  Or you can scope to config to the current process:
  
    ExDesk.configure(:process,
      site_name: "yoursite.desk.com",
      email: "your@email.com",
      password: "yourpassword"
      )  

All responses will be a `Map` of the response from This will return a `Map` of the JSON response described here:
[http://dev.desk.com/API/using-the-api]( http://dev.desk.com/API/using-the-api )

  Fetching a list of the first ten cases:
  
	ExDesk.list("cases", [per_page: 10, sort_field: "created_at", sort_direction: "asc"])
	
Creating a new resource:

    ExDesk.create("labels", [name: "A Label", description: "a description", types: ["case"], enabled: true, color: "purple"])

Fetching a single resource:

    ExDesk.show("cases/12345")
    
Searching for a resource:

    ExDesk.list("labels/search", [name: "Feedback"])
    
Updating a resource:

    ExDesk.update("labels/12345", [color: "red"])
   
Deleting a resource:

    ExDesk.delete("labels/12345")
