# OmniToken

## Introduction
OmniToken is a handy tool for getting OAuth tokens from multiple providers. It brings up a web page interface which lists the popular "Login with XXX" social buttons and displays the token and other basic information after user finishes the authentication flow.

It is a tiny Sinatra-based web application.

It heavily relies on [OmniAuth](https://github.com/intridea/omniauth) and its strategies. Theoretically, any OAuth provider can be supported as long as there is a OmniAuth strategy for it. It can be easily achieved by installing the startegy gem and adding a config file.

## Get Started
To install the latest stable version, run:

`gem install omnitoken`

After the gem and its dependencies are installed, run:

`omnitoken -s`

A web server is started. Visit `http://localhost:4567` in the web browser and you will see a page with the "No OAuth providers are configured." message.

Follow next section to add some providers. You need to restart the web server after adding new providers.

## Add Providers
To get the token from a provider, a tiny configuration file is required. OmniToken has been tested with following providers and a configuration template is shipped for each of them:
* Twitter
* Facebook

### Twitter
First, install the twitter strategy gem:

`gem install omniauth-twitter`

Copy the twitter template by running:

`omnitoken -a twitter`

A `twitter.yml` file will be created in `providers` folder in your working directory. Open it using your favorite editor and fill the fileds. The values can be found on your twitter application page you registered beforehand.

### Facebook
First, install the facebook strategy gem:

`gem install omniauth-facebook`

Copy the facebook template by running:

`omnitoken -a facebook`

A `facebook.yml` file will be created in `providers` folder in your working directory. Open it using your favorite editor and fill the fileds. The values can be found on your facebook application page you registered beforehand.

### Others
Theoretically, OmniToken can be support any provider as long as there is a OmniAuth strategy for it. Please follow these steps to add a provider which doesn't have a shipped template.

First, find and install the strategy gem for your provider. Assume it is `omniauth-example`.

`gem install omniauth-example`

Create a file named `example.ym` and put it in `providers` folder under your working directory. **NOTE: all providers configuration file should be put in `providers`.**

Refer to startegies' documentation and get the required argumements. Add a corresponding value to each argument. For example, the arguments are `foo` and `bar`. The `example.yml` should look like this:

```yaml
foo: "xxx"
bar: "xxx"
```

## Supported Ruby Versions
OmniToken is tested under 2.0.0.

## License
Copyright (c) 2013-2014 Minjie Zha. See [LICENSE](https://github.com/magic003/omnitoken/blob/master/LICENSE-MIT) for details.
