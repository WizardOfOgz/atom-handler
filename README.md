# Atom Handler

A handler to open atm:// URLs in Atom editor on OSX. Inspired by [subl](https://github.com/dhoulb/subl).

Atom Handler registers itself to handler links with the `atm://` protocol, similar to the protocol TextMate handles (txmt://) or the which can be used for Sublime Text (subl:// or sublime://). The protocol can then be used to open files in your Atom editor. Read on to learn how to use Atom Handler.

Note: We would have liked to have used `atom://` as a protocol, but that is already taken and used for other purposes by Atom itself.

## Prerequisites

- Install Atom Shell Commands. Within Atom select from the menu: `Atom > Install Shell Commands`

## Installation

- Download the latest release [(atom-handler.app.zip)](https://github.com/WizardOfOgz/atom-handler/releases/download/v1.1.3/atom-handler.app.zip) and unzip it.
- Move atom-handler.app into your `/Applications` directory.
- Open the application which will register the handler and exit immediately.

Opening the application in the last step may be prevented by OS security. If that happens go to `System Preferences > Security & Privacy`. You should see a message about "atom-txmt-url-handler" being blocked. Click the button which says "Open Anyway".

Note: Nothing appears on the screen when you open the application. Also, opening the application does not have any effect after the first time, opening it multiple times will do no harm.

### Testing the Installation

You can quickly test the installation from the command line. These commands should create a file and open it in Atom:

```
echo "Hello, world" >> /tmp/test.txt
open "atm://open?url=file:///tmp/test.txt"
```

## Usage

Atom Handler will handle URLs which match the [TextMate URL scheme](http://blog.macromates.com/2007/the-textmate-url-scheme/) and take the following format:

`atm://open?url=file://<file_path>[&line=<line>[&column=<column>]]`

Opening a URL with this format will open the given file in the Atom editor and place the cursor at the beginning of the line number (if given). Note that the column option does not seem to be supported by the Atom command line utility. If a column is given then Atom simply ignores it. The option is supported for compatibility with TextMate and Sublime Text URLs.

### Examples:
- `atm://open?url=file:///path/to/other`
- `atm://open?url=file:///path/to/other&line=42`
- `atm://open?url=file:///path/to/file&line=42&column=7`
- `atm://open?url=file://%2Fpath%2Fto%2Fother  # URL-encoded slashes (/)`

These URLs may be opened from a browser or from the command line using the system `open` command. See the [Integrations](#Integrations) section below for use with popular platforms and frameworks.

## URL Encoding

Note that The file path may contain the following URL-encoded values.

|name|character|URL encoding|
|---|---|---|
|slash|`/`|`%2F`|
|space|` `|`%20` OR `+`|
|plus|`+`|`%2B`|
|at|`@`|`%40`|

Plus-signs are legal characters in file names and _must_ be escaped as `%2B` since an unescaped `+` will be transformed into a space character. We highly discourage using plus-signs in file names since support for it varies across systems.

Spaces in file names must likewise be escaped. These are also discouraged since many scripts and applications do not handle them properly.

## Known Limitations

Currently this application relies on the `atom` CLI utility being accessible at `/usr/local/bin/atom` in order to open the files. If there is a better way of finding the CLI utility, please let me know or open a pull request.

## Integrations

### BetterErrors (Ruby on Rails)

Install [Better Errors](https://github.com/charliesome/better_errors) in your Rails application and add the following code to an initializer (or any other location where it will be executed when your application is loaded.)

```ruby
if defined? BetterErrors
  BetterErrors.editor = "atm://open?url=file://%{file}&line=%{line}"
end
```

### PHP Xdebug

Install [Xdebug](http://xdebug.org) for PHP, add the following to your php.ini, and restart your webserver.

```
xdebug.file_link_format="atm://open?url=file://%f&line=%l"
```

## License

Atom Handler is released under the [BSD 3-Clause license](https://github.com/WizardOfOgz/atom-handler/blob/master/LICENSE).
