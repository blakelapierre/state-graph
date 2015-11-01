import fs from 'fs';

import sg from '../state-graph.es5';

const file = 'fantasy.sg';

const graph = sg.parse(fs.readFileSync(file).toString()); // poor...why not just read from stdin and write to stdout?

console.log(JSON.stringify(graph, null, 2));
