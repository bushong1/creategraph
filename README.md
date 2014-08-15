This project will assist in creating a graph.  Right now, it's tuned for horizontal tree and 3 rows wide.

## Prerequisites

* Step 1: Install Ruby
* Step 2: Install graph gem: `gem install graph`
* Step 3: Install graphviz: `sudo apt-get install graphviz` OR `brew install graphviz`

## Usage

`./creategraph.rb <data file, pipe separated>`

## Spreading out the tree

Allow 3 deep spreading out (l3) and concentrate some nodes
`unflatten -l3 sample.csv.dot | dot -Tpng -osample.csv.png -Gconcentrate=true`

## Data file example

```
1|Do this, that, and the other
1.1|Develop 'this'
1.1.1|Code 'this'
1.1.2|Test 'this'
1.2|Develop 'that'
1.2.2|Get customer input for 'that'
1.2.2|Code 'that'
1.2.3|Test 'that'
1.3|Develop 'the other'
1.3.1|Plan 'the other'
1.3.2|Code 'the other'
1.3.3|Get user feedback on 'the other'
```

## Documentation

* Ruby Graph: http://rubydoc.info/gems/graph/2.7.0/frames
* GraphViz: http://www.graphviz.org/Documentation.php
