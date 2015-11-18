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
