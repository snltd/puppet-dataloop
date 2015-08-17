# Dataloop Module

This module installs the Dataloop agent. It also provides, er, a
provider, which can be used by any other module to easily add and remove
tags.

DISCLAIMER: Dataloop is a moving target. This may or may not still
work. We don't use Dataloop any more, so I can't test it, and I make
it available publicly as it's surplus to our requirements now. I
know for a fact that the horrible `curl | sudo bash` installation
method has (thankfully) been replaced by proper packaging. The
provider should still be useful though.

## Installation

We only install the agent if it isn't there already. So, the module
presently provides no mechanism for upgrading.

## Configuration

We run the agent as the `dataloop` user, which is created by this
module. Logs go to `/var/log/dataloop`.

## Hieradata

Everything gets the `all` tag because we have the following in
`common.yaml`.

```yaml
dataloop::tags:
  - all
```

`common.yaml` also contains the Dataloop API key. This is encrypted.

## Adding and Removing Tags

Dataloop tags are simple strings: i.e. they do not have, say, a key and
a value. We can say a node has the `production` tag. We don't say, in
Dataloop terms, that its `enviroment = production`.

A node can have many tags.

### With Hiera

You can add tags by including them in your Hiera data, using the form
shown above. All tags are merged together and added by the `tag.pp`
manifest when the module runs.

For example, in `hieradata/production/role.myservice.yaml` you might
have:

```yaml
dataloop::tags:
  - mytag
```

This will add `mytag` to the box the next time Puppet runs, and the
entire run will not consume any more Dataloop API calls than it does
already.

### With the Provider

Alternatively, in any manifest you can add a tag by using the following
code:

```ruby
  dataloop_tag{ 'mytag':
    ensure => 'present',
    key    => $dataloop::api_key,
  }
```

or remove a couple like this:

```ruby
  dataloop_tag{ ['tag1', 'tag2']:
    ensure => 'absent',
    key    => dataloop::$api_key,
  }
```

The provider looks up the node's current tags on each Puppet run, and
will only call the Datloop API to add or remove tags when it is
necessary.

Using this method will add an extra API call to each Puppet run.
