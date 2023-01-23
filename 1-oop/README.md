# Code organization
---
Joachim Vandekerckhove

## Scope

---

### Basic scoping

In every programming language, we use names to refer to things -- functions, variables, objects, and so on.  This link between a name and a thing is called **name binding**.

Name bindings are context specific.  The variable `foo` can refer to one thing in one program and to another thing in another program.

Scope rules are the rules that determine where a specific name binding is valid, and constitute some of the biggest differences between programming languages.

* R

  ```R
  i <- 4
  doublei <- function() {
      i * 2
  }
  paste(doublei())
  # "8"
  ```

* Python

  ```python
  i = 4
  def doublei():
      return i * 2
  print(doublei())
  # error
  ```
  
* Python lambda function

  ```python
  i = 4
  doublei = lambda : i * 2
  print(doublei())
  # 8
  ```

* MATLAB anonymous function

  ```matlab
  i = 4;
  doublei = @() i * 2;
  doublei()
  # 8
  ```
* MATLAB function

  There's no way to construct this in a regular MATLAB function


---

### Scripts

Many languages have some for of _script_ that can be _sourced_ (Bash, R, MATLAB).  In these languages, the **workspace** is usually one scope.  Scripts work in the workspace scope.

This has mostly disadvantages.  Most importantly, running a script _twice_ can easily give different results if a variable was changed in the course of the script.

The main use case of a script is if you are automating an entire session (e.g., running a file from the command line or running in batch mode on the cluster).  Python usually works like this.  In general, try to avoid calling on script from another.

---

### Functions

In most languages, functions have their own scope (exceptions: R, various inline functions in Python or MATLAB).  You can make new variables inside a function, overwrite them and delete them, and they will not affect the workspace (unless you explicitly try, which you shouldn't, it's very rude).

MATLAB's `function-end statement` defines a scope, as does Python's `def` block.

---

### MATLAB intermediate scoping

You can define a function inside another function's `function-end statement`.  Such **nested functions** _can_ share variables with their parent function.

You can also define a second function in another function's m-file but outside the `function-end statement`.  Such **subfunctions** cannot share variables with their parent function.

Nested functions and subfunctions are only callable from the parent function.  Detailed scoping rules for nested functions get complicated very quickly, it depends on how you use them.

---

### Anonymous functions

You can also define functions "on the fly" inside a script or another function.  Such **anonymous functions** can _see_ the variables in their parent scope but can't _change_ them.  Anonymous functions can be saved as variables, which will be incredibly useful soon.

* MATLAB
  
  ```matlab
  >> myAnonFun = @(x,y) sprintf('%d^%d = %g', x,y,x^y)
  ```
  
* Python
  
  ```python
  >>> myAnonFun = lambda x, y: x+y
  ```

* R

  All R functions are like this.

#### Anonymous functions can store variables:

* Python

  ```python
  >>> i = 4
  >>> timesi = lambda k : i * k
  >>> print(timesi(3))
  # 12
  >>> i = 3
  >>> print(timesi(3))
  # 9
  ```

* R

  ```r
  > i <- 4
  > timesi <- function(k) {
  +     i * k
  + }
  > timesi(3)
  # 12
  > i <- 3
  > timesi(3)
  # 9
  ```

* MATLAB

  ```matlab
  >> i = 4;
  >> timesi = @(x) x * i;
  >> timesi(3)
  ans =
      12
  >> a = 3;
  >> timesi(3)
  ans =
      12

---
## Some things you should not do but should know about

### Forced scope

> **Warning**
> This is only for your information, you should **almost never** force scope in your own work.  

In most languages, you can force variables into another scope.  For example, you can declare `global` variables, or you can store variables somewhere where all functions can access them (e.g., in a file, in the operating system, or in the interface object).  **This is generally a bad idea and you should never break scope.**

---

### Default inputs

> **Warning**
> This is only for your information, you should **almost never** use default input values in your own work.  

* MATLAB functions start with a template line that defines the input and output variables:

  ```matlab
  function [myOut, secondOut] = thisIsFun(myIn, secondIn)
  ```
  
  There's a function, `nargin` that counts the number of input arguments (there's also `nargout`, the purpose of which I will let you figure out on your own).  So this is a common structure:

  ```matlab
  if nargin < 2
    secondIn = 1; % default in case only one was given
    if nargin < 1
      myIn = 0;  % default in case no inputs
    end
  end
  ```

  More recently MATLAB added support for `argument-end` blocks:

  ```matlab
  function [myOut, secondOut] = thisIsFun(myIn, secondIn)
  arguments
    myIn     double (1,1) {mustBeNumeric} = 1
    secondIn double (1,1) string = "-" 
  end
  ```

* R functions list only inputs in their definition, but you can assign default values right there.

  ```r
  thisIsFun <- function(myIn = 1, secondIn = "-") {
    # ... stuff
  }
  ```

* Python functions do that too.

  ```python
  def thisIsFun(myIn = 1, secondIn = "-"):
      # ... stuff
  ```
  
---
## Object-oriented programming

---

Object-oriented programming involves thinking of problems as interactions between entities.

A *class* is a set of *objects* (or _instances_) with similar features.  A typical kind of class is a `User` or a `Product`, and objects might be `Ashley` or `BananaBunch`.  Objects have _properties_ (variables that belong to it) and _methods_ (functions that belong to it)m like `firstName`, `lastName`, or `numberOfBananas`.

Classes can exist in a hierarchy, where they inherit properties or methods from superclasses.

You can think of a class as your own custom type of variable, with data fields (properties) and dedicated functions (methods).

---

### Methods

|                    | MATLAB                                                       | Python                                            |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------- |
| Constructors       | `function obj = className(input)`                            | `def __init__(self, input):`                      |
| Display            | `function disp(obj)`                                         | `def __repr__(self):`                             |
| Getters            | `function get.myProperty(obj)`                               | ` @property`<br />`def myProperty(self):`         |
| Setters            | `function set.myProperty(obj, value)`                        | `@mean.setter`<br/>`def myProperty(self, value):` |
| Ordinary methods   | `function someMethod(obj, input)`                            | `def someMethod(self, input):`                    |
| Static methods     | `function someMethod(input)`                                 | `@staticmethod`<br />`def someMethod(input):`     |
| Public properties  | `properties`<br />`    myProperty`<br />`end`                | `self.myProperty`                                 |
| Private properties | `properties (Access = private)`<br />`    myPrivateProperty`<br />`end` | `self.__myPrivateProperty`                        |
| Constants          | `properties (Constant)`<br />`    myConstantProperty` = 6<br />`end` | Class attribute                                   |


---

### Class files, class folders

There are two ways to define a MATLAB class.  You can define a class in its own file (which will get large), or you can define it in many files inside a dedicated folder that starts with an `@`.  Python classes are a little simpler, and can be defined anywhere.

Class methods and properties are _scoped to the class_; they can be _public_ (visible externally), _private_ (visible only to other methods in the class), or _protected_ (also visible to child class methods).  They can be given a number of attributes.

---

#### A MATLAB class

```matlab
classdef LabResult
     properties
        CurrentValue double (1,1) {mustBeScalar}
     end
     properties (Transient)
        Status
     end
     methods
        ...
     end
 end
```

---

#### `methods-end block` with a constructor

```matlab
    methods
    
       function obj = LabResult(cv)  % <- constructor method
          obj.CurrentValue = cv;
          obj = assignStatus(obj);
       end
    
       function obj = assignStatus(obj)
          if obj.CurrentValue < 10
              obj.Status = 'Too low';
          else 
              obj.Status = 'Too high';
          end
       end
    
    end
```

---

#### `methods-end block` for static methods

```matlab
    methods (Static)
       % Static methods do not take the object as input
    
       function obj = loadobj(s)
          if isstruct(s) 
              obj = LabResults(s.CurrentValue);
          else 
              obj = assignStatus(s);
          end
       end
    
    end
```

---

#### A Python class

```python
class LabResult:
    def __init__(self, cv):
        self.currentValue = cv
        self = self.assignStatus()
    def assignStatus(self):
        if (self.currentValue < 10):
            self.status = 'Too low';
        else:
            self.status = 'Too high';
    @staticmethod
    def loadObject(s):
        self = LabResult.__init__(s)
```

### Package folders and modules

MATLAB and python are very widely used and many people contribute code to thrm.  Function name clashes are somewhat inevitable.  This is where **package folders** (MATLAB) and **modules** (python) come in handy.

A package folder is a folder whose name starts with `+`. A module is just a folder.

 * MATLAB: You have to prepend the package name (i.e., you can call functions in the package with `myPackage.myFun` and you can create classes with `myPackage.myClass`), or you can but shouldn't use the `import` command to make package functions visible in the local scope.
 * Python: You can import modules the regular way.  In general, do not `from myModule import...`, just import the whole module and use `myModule.myFunction()`. That is less prone to errors.


---

### Use cases

**Classes** are most useful when you have multiple functions that operate on a similar kind of data or type of variable.

**Packages** and **modules** are most useful when you have many functions that functionally belong together but aren't necessarily associated with a particular kind of input.

---

### Console I/O

#### Getting input from the console

* MATLAB

  ```matlab
  input('Give us a number.')
  ```

* Python

  ```python
  input('Give us a number.')
  ```

#### Unformatted printing

* MATLAB

  ```matlab
  disp()
  ```

* Python

  ```python
  print()
  ```

#### Formatted printing and format strings

* MATLAB

  ```matlab
  fprintf('Here: %s', location)
  str = sprintf('Here: %s', location)
  ```

* Python (>=3.6)

  ```python
  print(f"Here: {location}")
  str = f"Here: {location}"
  ```

---

### File I/O

#### Reading and writing text files

* MATLAB

  ```matlab
  uiimport()
  readmatrix(), writematrix()
  readcell(), writecell()
  readtable(), writetable()
  ```

* Python

  ```python
  pandas.read_csv()
  ```

---

### Printing to a file

Streams and file IDs

* MATLAB

  ```matlab
  fid = fopen('file.txt', 'w');
  fprintf(fid, 'This will end up in the file.');
  fclose(fid);
  ```
  
* Python
  
  ```python
  f = open("file.txt", "wb")
  f.write("This will end up in the file.")
  f.close()
  ```
  
---

### Low-level I/O

A relatively general-purpose structure is this:

* MATLAB

  ```matlab
  fid = fopen('myFile.ext');
  while ~feof(fid)
      buffer = fgetl();  % read until next line break
      % ... do something depending on line
  end
  fclose(fid);
  ```

* Python

  ```python
  f = open('myFile.ext', 'r')
  for line in f:
      buffer = line.strip() # strip the newline character
      # ... do something depending on line
  f.close()
  ```

---

