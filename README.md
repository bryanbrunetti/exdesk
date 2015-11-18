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

## Usage
  To configure the authorization globally:
  
    ExDesk.configure(
      site_name: "yoursite.desk.com",
      email: "your@email.com",
      password: "yourpassword"
      )
  Or scoped to the current process:
  
    ExDesk.configure(:process,
      site_name: "yoursite.desk.com",
      email: "your@email.com",
      password: "yourpassword"
      )  

  Fetching a list of the first ten cases:
  
	ExDesk.list("cases", [per_page: 10, sort_field: "created_at", sort_direction: "asc"])
	
This will return a `Map` of the JSON response described here: [http://dev.desk.com/API/cases/#list]( http://dev.desk.com/API/cases/#list )