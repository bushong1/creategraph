## Prerequisites

* Ruby
* graph gem: `gem install graph`
* graphviz application: `apt-get install graphviz`

## Usage

`./creategraph.rb <data file, pipe separated>`

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
