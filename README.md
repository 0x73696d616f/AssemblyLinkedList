## Description
Linked list implementation in assembly.

## Benchmark results
|        | This Linked List [gas] | Mapping Linked List [gas] |
|:------:|:----------------------:|:-------------------------:|
| Deploy |         195241         |           200431          |
| Insert |         110560         |           112723          |
| Remove |          25328         |           25297           |

## Run tests
`make tests` 
## Run benchmark vs regular mapping linked list
`make benchmark` \
**Note**: The output is printed as receipts in the console.