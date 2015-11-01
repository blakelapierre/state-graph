import fs from 'fs';

import {render} from 'mustache';
import _ from 'lodash';

const paths = {
  template:   './src/template.mustache',
  grammar:    './src/grammar.pegjs',
  transforms: './src/transforms.js'
};

const {template, grammar, transforms} = _.mapValues(paths, fs.readFileSync),
      result = render(template, {grammar, transforms});

console.dir(result);