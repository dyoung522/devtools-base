[![Build Status](https://travis-ci.org/dyoung522/devtools.svg?branch=master)](https://travis-ci.org/dyoung522/devtools)
[![Code Climate](https://codeclimate.com/github/dyoung522/devtools/badges/gpa.svg)](https://codeclimate.com/github/dyoung522/devtools)
[![Test Coverage](https://codeclimate.com/github/dyoung522/devtools/badges/coverage.svg)](https://codeclimate.com/github/dyoung522/devtools/coverage)

# DevTools

DevTools is a compilation of utilities created to make the development process easier.

## Installation

Install it from the command line

    $ gem install devtools

## Usage

Once installed, this gem provides several, mostly independent, utilities

- `runtest` : Runs test suites with an optional search pattern
- `jdiff`   t co: Compares two git branches and shows a diff of JIRA stories
- `prlist`  : Polls git repos and displays a queue of stories ready for QA

Future Development

- RunEnv  : Starts and manages a development environment

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dyoung522/devtools.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

