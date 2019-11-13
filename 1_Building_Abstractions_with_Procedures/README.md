# Building abstractions with procedures

## Computational processes manipulate data.
- Process is an abstraction. 
	- Representing **active** manipulator.
	- Descriptions of rules for manipulating data.
- Data are abstraction as well. 
	- Representing **passive** subject to manipulation
- Process manipulates data.

- Evolution of process is directed by a **program**
- Program is a *pattern of rules*
- Program is created to direct process

- **Programming language** is a set of symbolic expressions from which a program is composed.

Programming language is  a *set of symbolic expressions* used to create programms. Program is a *pattern of rules* used to diret processes. Process is an abstraction, that manipulates data.

**A computational process executes program**

## LISP
- A programming language with many dialects.
- Used as language of choice for OS shell languages.

- Description of processes are called **procedures**
- Procedures themselves can be represented and manipulated as LISP data.
	- Some powerful program-design techniques rely on ability to blure the distinction between active procedures and passive data.
	- It makes LISP an excellent language for writing **interpreters** and **compilers** _(programs that manipulates other programs)_.

## Elements of Programming
- Languge should serve as platform, within wich one can organise _thoughts and ideas about processes_.

Every language has three mechanisms to combine simple indeas into complex ones:
1. **Primitive expressions**: The simplest entities language is concerned with.
2. **Means of combination**: Means to combine simpler entities into compoud ones.
3. **Means of abstraction**: Means to name and manipulate with compoud entities as units.

_Entity is a procedure or data_

## Expressions
- Typing an expression into terminal trigger its _evaluation_  and display result.
- **REPL** - read-eval-print-loop - Terminal reads expression. Evaluates it. Prints the result.

```scheme
485  ; Primitive expression - numerals representing a number in base 10
;Value: 485
```

```scheme
; COMBINATOR
(+ 1 2)  ; A combination of a primitive procedure with primitive data 
;Value: 3
```

- **Combinator** is delimited list of expressions within paranthes in order to to denote procedure application.
	- **Operator** is a leftmost entity (_prefix notation_). Other entities are **operands**.
	- Value of _Combinator expression_  is obtained by aplying _operator_ to the **arguments**
	- Argument is a value of an operand.
	- **Prefix notation**
		- Can accomodate procedures that take an arbitrary number of elements.
		- Straightforward nesting 
			- Deep nesting should be formatted by _pretty-printing_.
			- **pretty-print** operands are align vertically

## Naming and Environment
- Means to refer to computational object.
- The name _identifies a variable whose value is the object_

```scheme
(define size 2)
;Value: size

size
2
```

- `define` is the simplest mean of abstraction. It allows us to refere to the results of compoud operations.
	- Cave: `define` **is not a combination**.
	- It does not apply operator to two operands.
	- It _associates name with computational object_.

Means of abstractions that are not combinations are called **special forms**. Special forms have their own evaluation rules (_associated evaluation rule_).

**Complex programs are cunstructed by by building computational objects of increasing complexity.**

- **Global environment** - memory that keeps track of **name-object** pairs.

## Evaluating combinations
- evalution rule is _recursive_ :
	1. Evaluating of subexpression of combination.
	2. Application of the operator to the arguments that are other subexpressions.

Each expression (with its subexpressions) can be represented as a tree.
	- Combination is represented by a node. 
	- Branches correspond to the operator and operands stemming from node.
	- Leaves represents operators or values.
	- Values of operands perlocate upwards (generel kind of process known as _tree accumulation_).

**Primitive cases are taken care as follows:**
1. the value sof primitive data are primitive data they name
2. the value of operators are machine instruction sequences
	- special case of _third rule_
3. the value of other names are defined by name-object pairs in global environment.
