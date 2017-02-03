[![Build Status](https://travis-ci.org/dyoung522/devtools-base.svg?branch=master)](https://travis-ci.org/dyoung522/devtools-base)
[![Code Climate](https://codeclimate.com/github/dyoung522/devtools-base/badges/gpa.svg)](https://codeclimate.com/github/dyoung522/devtools-base)
[![Test Coverage](https://codeclimate.com/github/dyoung522/devtools-base/badges/coverage.svg)](https://codeclimate.com/github/dyoung522/devtools-base/coverage)

# DevTools (Base)

DevTools is a compilation of utilities created to make the development process easier.

## Installation

The base class is intended to be required in other tools via

    require "devtools-base"

## Usage

Once installed, this gem provides a base for several, mostly independent, utilities.

It gives you command line support, which includes the following options:

- `--help    | -h` : Command line help
- `--config  | -c <FILE>` : Include tools-specific options from config FILE
- `--version | -v` : Print version information and exit

Additionally, the base will look for and load (if found) tool specific
configuration items from one of the following files:
 
- `~/.toolname`
- `./.toolname`
- `./toolname.rc`
- `./toolname.conf`

Where `toolname` is the name of the executable using this base.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on [our GitHub page](https://github.com/dyoung522/devtools-base)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

