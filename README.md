# Volunteer Tracker

#### Track volunteers on a project using PostgreSQL

#### Ralph Perdomo. December 7, 2018

## Description
Add projects and volunteers to a list. Assign volunteers to a project and start making a difference, together, today. A webapp using Ruby, Sinatra, and PostgreSQL

## Setup/Installation Requirements

SPECIAL NOTE: This project requires PostgreSQL be installed on your computer

* clone this repository using `git clone https://github.com/pseudoralph/volunteer_tracker`
* navigate to the downloaded repo
* create postgress database using: `createdb volunteer_tracker`
* load templates from this repo using: `psql volunteer_tracker < my_database.sql`
* run the ruby gem `bundle` to install necessary gems
  * NOTE: install `bundle` using `gem install bundle` if not installed
* type `rspec` to see test's results


## Technologies Used

Ruby, Sinatra, PostgreSQL

## Objectives
- [x] Tests are 100% passing. You may not significantly alter the included tests but you may add additional tests as necessary.

- [x] Database is set up correctly.

- [x] Correct set up of a one-to-many relationship.

- [x] Sinatra has required CRUD functionality.

- [x] Project has strong commit history history.

- [x] Project has detailed README with all necessary setup instructions and a description of the project.

- [x] Required functionality was in place by the Friday deadline.

- [x] Student can demonstrate understanding of Ruby concepts if asked.
---

### License

MIT License

Copyright (c) 2018, Ralph Perdomo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
