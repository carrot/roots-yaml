Roots-yaml
=============================

[![npm](https://badge.fury.io/js/roots-yaml.png)](http://badge.fury.io/js/roots-yaml) [![tests](https://travis-ci.org/carrot/roots-yaml.png?branch=master)](https://travis-ci.org/carrot/roots-yaml) [![dependencies](https://david-dm.org/carrot/roots-yaml.png?theme=shields.io)](https://david-dm.org/carrot/roots-yaml) [![Coverage Status](https://img.shields.io/coveralls/carrot/roots-netlify.svg)](https://coveralls.io/r/carrot/roots-yaml?branch=master)

Load YAML data files into your roots project.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Installation

- make sure you are in your roots project directory
- `npm install roots-yaml --save`
- modify your `app.coffee` file to include the extension, as such

  ```coffee
  roots_yaml = require('roots-yaml')

  module.exports =
    extensions: [roots_yaml()]
  ```

### Usage


### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
