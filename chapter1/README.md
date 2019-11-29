# Building abstractions with procedures

## Computational processes manipulate data
- Process is an abstraction. 
	- Representing an **active** manipulator.
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

**Complex programs are constructed by building computational objects of increasing complexity.**

- **Global environment** - memory that keeps track of **name-object** pairs.

## Evaluating combinations
- evalution rule is _recursive_ :
	1. Evaluating of subexpression of combination.
	2. Application of the operator to the arguments that are other subexpressions.

Each expression (with its subexpressions) can be represented as a tree.
	- Combination is represented by a node. 
	- Branches correspond to the operator and operands stemming from node.
	- Leaves represents operators or values.
	- Values of operands perlocate upwards (general process known as _tree accumulation_).

**Primitive cases are taken care as follows:**
1. the value sof primitive data are primitive data they name
2. the value of operators are machine instruction sequences
	- special case of _third rule_
3. the value of other names is defined by name-object pairs in global environment.

## Compoud procedures

- **procedure definition** is an abstraction technique by which compound operation can be named and referred to as a unit.

```scheme
; General form of procedure definition
(define (_name_ _formal_parameters_) (_body_))

; _name_: A symbol to be associated with procedure definition
; _formal_parameters_: local names of corresponding arguments of the procedure.
; _body_: An expression yielding a value for actual arguments supplied during application.
```

## The substitution model of procedural application

- To apply compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by corresponding argument.
- Substitution model is framework to think about procedures. _It does not reflect how interpreter really works_.

- **normal-order evaluation**:  Evaluation based on _full expansion of compound entities and successive reduction of primitive ones_.
- **applicative-order evaluation**:  Evaluation based on _argument evaluation and immediate application_.

Both the normal-order and applicative-order evaluation should yield same results.

## Conditional expressions and predicates

- **Case analysis** is a rule for defining outputs based on value of the input.
- Lisp has a special form for notating _case analysis_

```scheme
; cond special form
(cond (p1 e1) ; clauses - pairs of predicate and consequent expression
      (p2 e2)
           …
      (pN eN))
```

- Conditional expressios are evaluated in top-down fashion.  If predicate in one of them is found to be true, the consequent expression is returned. _If none of them is found to be true the value of cond is undefined_.
- Comparation operators are _primitive predicates_.
- Predicate is a procedure that returns boolean.

- There may be `else`  _special form_ used in conditional expressions, thus preventing **undefined value**.  
```scheme
(cond (p1 e1)
           …
      (pN eN)
      (else eM))
```

- `if` special form may be used as well.  It follows tenary operator syntax:
```scheme
(if _predicate_ _consequent_ _alternative_) 
```
	- The diffrence between `cond` and `if` special forms is that a _predicate_ and a _consequent_ have to be single expresions for `if special form`. But sequence of special forms is allowed in `cond special form`. 

There are **logical composition operations** :
```scheme
(and e1 e2 … eN)
(or e1 e2 … eN)
(not e)
```
	- `and` and `or` are in fact special forms not operators, because _not every logical expression need to be evaluated_.

## Procedures as Black-Box abstractions
- Problem can be break into numbre of subproblems.
- The supbroblem is represented by a procedure.

A program may be viewed as **cluster of procedures** mirroring the _decomposition of the problem_.

- Each procedure should accomplish _identifiable task_

If a procedure is supposed to acomplish one well defined task. We may at the moment of use disregard its implementation. Thus using it as a black box.
_Disregarding implementation details_ of procedure while using it is called **procedural abstraction**.

```text
A user should not need to know how the procedure is implemented in order to use it. 
```

Meaning of a procedure **is independent of the parameter names** used by author .
	- Parameter names _must be local to the body of procedure_.

Name of  a **formal parameter** is called **bound variable**
	- The name itself doesn’t matter.
	- Procedure definition _binds_ its formal parameters.
	- Meaning of the procedure is unchanged if a bound variable is consistently renamed through the definition.

Variable that is not bound is **free**.

The set of expressions for which _a binding defines a name_ is a **scope of the name**. 
	- Bound variables declared as formal parameters of the procedure have its body as their scope.

Bound variables names should be distinct from names of _free variables_. The overlap might cause a bug by **capturing** free variable name, thus replacing its meaning from free to bound one. 

```text
Meaning of procedure is independent of the names of its bound variables. But is not idependent of the names of its free variables.
```

## Internal definitions and block structure
- Procedures that are just implementation details and are not importatn to the user should not be placed into the top level namespace.
- I is possible to have _internal definitions_ that are local to the procedure.
- Nesting of denitions is called **block structure**
- Block structure solves the simplest form of _name-packaging problem_

Using _block structure_ also allow **lexical scoping**
	- Disciplne of simplifying nested procedures by _using enclosing procedure’s bound variables_ as nested procedures’ _free variables_. 
	- Free variables in a procedure are taken to refer to bindings made by enclosing procedure definitions.
	- Thus effectively removing _formal parameters_ from inner function declerations.

# Procedures and processes they generate
- Procedure is a pattern for _the local evolution_ of a process.
- Procedure specifies how each stage of process is built upon previous stage.
- _global behavior_ of process is given by all _local evolutions_.

## Linear recursion and iteration
- Good practise is to use _substitution model_ to visualize procedures in action.

Note: See `exrcises.scm` for several implementations of factorial.

### Comparasion of recursion and linear iteration

1. Recursion
	-  Substitution model shows phases of _expansion_ and _contraction_.

```scheme
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720
```

	- _expansion_ occurs as the process (sic!) builds up a  chain of **deferred operations**.
	- _contraction_ occurs as the operations are actually performed by the process.

```text
Process characterized by a chain of deferred operation, hence by patterns of expansion and contractions, is called recusrsive process.
```

Carrying out _recursive process_ requires interpreter to keep track of operations to be performed latter.

**The number of deferred operations grows lineary with n**

With deffered operations, the amount of information the keep track of, as well as the number of steps, grows lineary as well.
Such process is called **linear recursive process**.

2. Iteration
	- Substitution model shows no signs of expansion or contraction.

```scheme
(factorial 6)
(iter 1 1 6)
(iter 1 2 6)
(iter 2 3 6)
(iter 6 4 6)
(iter 24 5 6)
(iter 120 6 6)
(iter 720 7 6)
720 
```

	- at each step, only information needed are current values of bound variables.
	- There is fixed number of so called _state variables_ that characterizes the process.
	- There is a fixed rule describing how the _state variables_ should be updated with every iteration.

```text
Process whose state can be sumarized by fixed number of state variable and fixed rule governing update of their values is called linear iterative process.
```

If we stop the process before finishing, all we need to do to resume the _linear iterative process_ is to supply the values of state variables.
To resume _linear recursive process_ we would need supply hidden information maintained by the interpreter and thus not contained in the program variables. Such information indicates **state of negotiating the chain of deferred operations**.

Do not cofuse **recursive process** and **recursive procedure**.
	- Recursive procedure refers to syntax (the procedure calls itself).
	- Recusrsive process refers to _pattern of evolution of such process_, characterized by contraction and expansion.

```text
Recursive procedure does not force recursive evolution of a process it governs.
```

Iterative process can be executed **in constant space** even if it is describe by _recursive procedure_.  An implementation with this property is called **tail-recursive**.
	- Some languages does not support tail-recursive implementation.
	- With tail-recursive implementation iteration can be expressed using ordinary procedure mechanisms. And _special iteration constructs are useful only as syntactic sugar_.
