#!/bin/bash

pegjs state-graph.pegjs
babel state-graph.js > state-graph.es5.js