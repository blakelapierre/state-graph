{
  function makeGraph(graphs) {
    const result = {};

    graphs.forEach(graph => {
      const {name, data} = graph;

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
}

graphs
 = graphs:(graph*) { return makeGraph(graphs); }

id_first = [a-zA-Z\$]
id_rest  = [a-zA-Z\$0-9_\-]+

modifier = [\^]

ws "whitespace" = [ \r\n\t\v]*

graph_begin = ws "{" ws
graph_end   = ws "}" ws
list_begin  = ws "[" ws
list_end    = ws "]" ws

data_begin = ws "@" ws

properties_begin = ws ":" ws
transition_begin = ws "->" ws

graph
  = name:name
    graph_begin
    data:data?
    states:states
    graph_end
    { return {name, data: data || undefined, states}; }

name
  = id:identifier { return id; }

identifier
  = ws first:id_first rest:id_rest ws { return first + makeIdentifier(rest); }

identifier_list
  = list_begin identifiers:list_of_identifiers list_end { return identifiers; }

list_of_identifiers
  = id:identifier rest:(additional_identifier*) { return [id].concat(rest); }

additional_identifier
  = "," id:identifier { return id; }

data_list
  = list_begin data:list_of_data list_end { return data; }

list_of_data
  = modifier:modifier? id:identifier rest:("," list_of_data)* { return [{id, modifier: modifier || undefined}].concat(rest); }

states
  = state*

state
  = name:name ":" rules:rules { return makeState(name, rules); }

rules
  = rule*

rule
  = data
  / properties
  / transition

data
  = data_begin data:data_list { return {data}; }

properties
  = properties_begin properties:identifier_list { return {properties}; }

transition
  = transition_begin state:identifier { return {transition: state}; }