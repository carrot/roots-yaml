# Roots-YAML
[![npm](http://img.shields.io/npm/v/roots-yaml.svg?style=flat)](https://badge.fury.io/js/roots-yaml) [![tests](http://img.shields.io/travis/carrot/roots-yaml/master.svg?style=flat)](https://travis-ci.org/carrot/roots-yaml)  [![dependencies](http://img.shields.io/gemnasium/carrot/roots-yaml.svg?style=flat)](https://gemnasium.com/carrot/roots-yaml) [![devDependencies](https://img.shields.io/david/dev/carrot/roots-yaml.svg)](https://gemnasium.com/carrot/roots-yaml)
[![Coverage Status](https://img.shields.io/coveralls/carrot/roots-yaml.svg)](https://coveralls.io/r/carrot/roots-yaml?branch=master)


Load YAML data files into your roots project.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why Should You Care?
It's important to maintain clean DRY code. Instead of writing messy and duplicated
markup, you can use the power of HTML precompilers and pass data into your
templates.

Roots-YAML lets you store your site data in [YAML](http://www.yaml.org/), a human
friendly data serialization format and then have that data exposed for you to
use in your roots view templates.

### Installation
- make sure you are in your roots project directory
- `npm install roots-yaml --save`
- modify your `app.coffee` file to include the extension, as such

```coffee
roots_yaml = require('roots-yaml')

module.exports =
  extensions:
    roots_yaml
      source: 'data'  # default value
```

### Usage
Roots-YAML will look in your source directory and load any `.yaml`
files into a `data` object for you to use in your views.

Each YAML file will be loaded using [js-yaml](https://github.com/nodeca/js-yaml)
and have the result set to `data.<file_name>`.

For example, if I have a directory `data` structured like this:

```
data/
  staff.yaml
  clients.yaml
  misc/
    doges.yaml
    manatoges.yaml
```

Inside my view templates I can use the following line to inspect the `data` object provided by roots-yaml:

```jade
pre=JSON.stringify(data, null, 2)
```

You will notice that, for example, `data.staff` contains the data in `data/staff.yaml` and `data.misc.manatoges` contains the data in `data/misc/manatoges`.

### View Helper
Roots-YAML also adds a handy view helper to your Roots templates. Inside your
views, add the following to insert a script tag setting a global `data`
variable in your JS to your YAML data. You can also pass a string into `yaml`
to change the name of the variable.

```jade
!= yaml()
!= yaml('manatoge')
```

results in:

```html
<script>var data = {"doge":{"wow":"such yaml"}};</script>
<script>var manatoge = {"doge":{"wow":"such yaml"}};</script>
```

### License & Contributing
- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
