#! /usr/bin/env ruby

puts "Setting up dependencies"
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'sinatra', require: 'sinatra'
  gem 'puma'
end

puts "Starting server"
set :app_file, $PROGRAM_NAME

get '/' do
  return <<~EODOC
    <html>
    <head>
      <script src="https://unpkg.com/htmx.org@1.9.6"></script>

      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">

      <style>
        html {
          font-family: 'Montserrat', sans-serif;
          background: #222222;
          color: #dddddd;
          width: 37rem;
          margin: auto;
          text-align: center;
        }

        #praiseArea {
          transition: all 0.2s ease-out;
          border-radius: 5px;
          background: #333333;
          min-height: 9rem;
          display: flex;
          justify-content: center;
        }

        p.praise {
          font-size: 3em;
          font-weight: bold;
        }
      </style>
    </head>

    <body>
      <h1>Praiseinator</h1>
      <button hx-post="/clicked" hx-swap="innerHtml" hx-target="#praiseArea">
        Praise me 🙏
      </button>
      <div id="praiseArea"></div>
    </body>
    </html>
  EODOC
end

post '/clicked' do
  praise = [
    "Good work!",
    "Nice one!",
    "Looking good!",
    "You're amazing",
    "You are an inspiration!",
    "Well done!",
    "You make things look easy!"
  ].sample
  "<p class='praise'>#{praise}</p>"
end
