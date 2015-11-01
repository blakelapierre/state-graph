import fs from 'fs';

import _ from 'lodash';
import {render} from 'mustache';

const paths = {
  template:   './src/template.mustache',
  grammar:    './src/grammar.pegjs',
  transforms: './src/transforms.js'
};

const {template, grammar, transforms} = _.mapValues(paths, fs.readFileSync),
      result = render(template, {grammar, transforms});

console.dir(result);