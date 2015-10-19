// graphs
//   = graphs:(
//       first:graph
//       rest:(g:graph { return g; })*
//       {
//         return makeGraph([first].concat(rest));
//       }
//    )

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
    { return {name: name, data: data || undefined, states: states}; }

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
  = modifier:modifier? id:identifier rest:("," list_of_data)* { return [{id: id, modifier: modifier}].concat(rest); }

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
  = data_begin data:data_list { return {data: data}; }

properties
  = properties_begin properties:identifier_list { return {properties: properties}; }

transition
  = transition_begin state:identifier { return {transition: state}; }