[![Gem Version](https://badge.fury.io/rb/tfdsl.svg)](http://badge.fury.io/rb/tfdsl)
[![Build Status](https://travis-ci.org/tlopo-ruby/tfdsl.svg?branch=master)](https://travis-ci.org/tlopo-ruby/tfdsl)
[![Code Climate](https://codeclimate.com/github/tlopo-ruby/tfdsl/badges/gpa.svg)](https://codeclimate.com/github/tlopo-ruby/tfdsl)
[![Coverage Status](https://coveralls.io/repos/github/tlopo-ruby/tfdsl/badge.svg?branch=master)](https://coveralls.io/github/tlopo-ruby/tfdsl?branch=master)

# TFDSL

A Chef like DSL for Terraform.

Terraform uses HCL for its configuration, which is better than json or yaml in my opinion, but still not quite as flexible as Chef DSL, so here it's a chef like DSL for terraform.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tfdsl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install terraform_dsl

## Usage

A quick usage example 
```ruby
require 'tfdsl'
  
stack = TFDSL.stack do
  resource 'aws_vpc', 'main' do
    cidr_block '10.0.0.0/16'
    instance_tenancy 'dedicated'
    tags do
      Name 'main'
    end
  end
end

puts stack
```
The code above will produce the output below: 
```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = "main"
  }
}
```

## Ruby Reserved Words

Since some terraform object names use Ruby reserved words, we had to do some slight modifications on how resources are named. 
We use `datasource` for `data` and `tfmodule` for `module`

Example:

In ruby
```ruby
datasource 'aws_ami', 'web' do
...
end
```
In HCL
```hcl
data 'aws_ami' 'web' {
...
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/terraform_dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TerraformDsl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/terraform_dsl/blob/master/CODE_OF_CONDUCT.md).
