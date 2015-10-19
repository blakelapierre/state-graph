function makeGraph(graphs) {
  const result = {};

  graphs.forEach(({name, data}) => {
    if (result[name]) throw Error('Duplicate graph ' + name);

    const states = {},
          ret = {name};

    if (data) ret.data = data;

    graph.states.forEach(({name, state}) => states[name] = state);

    if (graph.states.length > 0) ret.start = graph.states[0].name;

    ret.states = states; // I want "data" to appear before "states" in the output

    result[name] = ret;
  });

  return result;
}

function makeIdentifier(chars) {
  return chars.join('');
}

function makeState(name, rules) {
  let data,
      properties = [];

  const transitions = [];

  rules.forEach(rule => {
    if (rule.data) {
      data = rule.data;
    }
    else if (rule.properties) {
      properties = properties.concat(rule.properties);
    }
    else if (rule.transition) {
      transitions.push(rule.transition);
    }
  });

  return {
    name,
    state: {
      data,
      properties,
      transitions
    }
  };
}
