function makeGraph(graphs) {
  var result = {};

  console.log('graphs', graphs);

  graphs.forEach(function(graph) {
    var name = graph.name;

    if (result[name]) throw Error('Duplicate graph ' + name);

    var states = {},
        ret = {name: name},
        data = graph.data;

    if (data) ret.data = data;

    graph.states.forEach(function(state) { states[state.name] = state.state; });

    if (graph.states.length > 0) ret.start = graph.states[0].name;
    console.log('ret', ret);
    ret.states = states; // I want "data" to appear before "states" in the output

    result[name] = ret;
  });

  return result;
}

function makeIdentifier(chars) {
  return chars.join('');
}

function makeState(name, rules) {
  console.log('rules', rules);
  var data,
      properties = [],
      transitions = [];

  rules.forEach(function(rule) {
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
    name: name,
    state: {
      data: data,
      properties: properties,
      transitions: transitions
    }
  };
}
