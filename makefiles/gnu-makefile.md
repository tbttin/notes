# Overview of make
## How to Read This Manual
## Problems and Bugs
# An Introduction to Makefiles
## What a Rule Looks Like

- A `rule` looks like this:

  ```
    target ... : prerequisites ...
            recipe
            ...
            ...
  ```

  Remember to put one tab character (or `.RECIPEPREFIX` value) at the beginning
  of every recipe line!

## A Simple Makefile
## How make Processes a Makefile

- The `default goal` is the first target (not targets whose names start with
  `.`) or the `.DEFAULTGOAL` value.

- *Automatically generated C program*s made by **Bison** and **Yacc**.

## Variables Make Makefiles Simpler
## Letting make Deduce the Recipes

- `Implicit rule`s:

  ```makefile
    main.o : defs.h
    utils.o : utils.h
  ```

## Another Style of Makefile
## Rules for Cleaning the Directory
# Writing Makefiles
## What Makefiles Contain

- Makefile contain five kinds of things:

  + Explicit rules.

  + Implicit rules.

  + Variable definitions.

  + Directives.

    * Reading other makefiles.

    * Deciding (based on the values of variables) whether to use or ignore a
      part of the makefile.

    * Defining a variable from a verbatim string containing multiple lines.

  + Comments.

### Splitting Long Lines

- `Physical line`s is a single line ending with a newline (regardless of
  whether it is escaped).

- `Logical line`s being a complete statement including all escaped newlines up
  to the first non-escaped newline.

- Outside of recipe lines, backslash/newlines are *converted* into a single space
  character.

- All whitespace around the backslash/newline is *condensed* into a single space.

- **Splitting without adding whitespace**: dollar sign/backslash/newline instead of
  backslash/newline:

  ```makefile
    var := one$\
           word
  ```

  After `make` remove backslash/newline and condenses the following space:

  ```makefile
    var := one$ word
  ```

  Because the variable '$ ' which does not exist, and so it will expand to
  the empty string (`oneword`).

## What Name to Give Your Makefile

- By default, when `make` looks for the makefile, it tries the following names,
  in order: `GNUmakefile`, `makefile` and `Makefile`.

## Including Other Makefiles

```makefile
  include foo *.mk $(bar)
```

- If an included makefile cannot be found in any of these directories, a
  warning message is generated, but it is not an immediately fatal error;
  processing of the makefile containing the `include` continues.

  Once it has finished reading makefiles, `make` will try to *remake* any that
  are out of date or don't exist.

  Only after it has tried to find a way to remake a makefile and failed, will
  `make` diagnose the missing makefile as a fatal error.

- For compatibility with some other `make` implementations, `sinclude` is
  another name for `-include`.

## The Variable MAKEFILES

- If the environment variable `MAKEFILES` is defined, `make` considers its
  value as a list of names (separated by whitespace) of additional makefiles to
  be read before the others.

- The main use of `MAKEFILES` is in communication between recursive invocations
  of `make`.

## How Makefiles Are Remade

- After reading in all makefiles `make` will consider each as a goal target and
  attempt to update it (explicit or implicit rules).

- Prevent implicit rule look-up: you can write an explicit rule with the
  makefile as the target, and an empty recipe.

- The `-t` (or `--touch`), `-q` (or `--question`) and `-n` (or `--just-print`)
  do not prevent updating makefiles.

- Prevent update makefiles: specify the makefiles as goals in the command line
  as well as specifying them as makefiles.

  Thus, '`make -f mfile -n mfile foo`' would read the makefile `mfile`, print
  the recipe needed to update it without actually running it, and then print
  the recipe needed to update `foo` without running that.

## Overriding Part of Another Makefile

- For example, if you have a makefile called `Makefile` that says how to make
  the target 'foo' (and other targets), you can write a makefile called
  `GNUmakefile` that contains:

  ```makefile
    foo:
            frobnicate > foo

    %: force
            @$(MAKE) -f Makefile $@
    force: ;
  ```

  Then,

  ```sh
    $ make foo

    $ make bar
  ```

- The rule specifies a prerequisite `force`, to guarantee that the recipe will
  be run even if the target file already exists.

  We give the `force` target an empty recipe to prevent `make` from searching for
  an implicit rule to build it-otherwise it would apply the same match-anything
  rule to force itself and create a prerequisite loop!

## How make Reads a Makefile

- GNU `make` does its work in *two distinct phases*.

- During the *first phase*:

  + Reads all the makefiles, included makefiles.

  + Internalizes all the variables and implicit and explicit rules.

  + Builds a dependency graph of all the targets and theirs prerequisites.

- During the *second phase*, `make` use this internalized data to determine which
  targets need to be updated and run the recipes necessary to update them.

- It's important to understand this two-phase approach because it has a direct
  impact on how variable and function expansion happens.

- We say that expansion is *immediate* if it happens during the first phase:
  `make` will expand that part of the construct as the makefile is parsed.

  We say that expansion is *deferred* if it is not immediate.

- Expansion of a deferred construct part is delayed until the expansion is
  used: either when it is referenced in an immediate context, or when it is
  needed during the second phase.

- Variable assignment:

  ```makefile
    immediate   = deferred
    immediate  ?= deferred
    immediate  := immediate
    immediate ::= immediate
    immediate  += deferred or immediate
    immediate  != immediate

    define immediate
      deferred
    endef

    define immediate =
      deferred
    endef

    define immediate ?=
      deferred
    endef

    define immediate :=
      immediate
    endef

    define immediate ::=
      immediate
    endef

    define immediate +=
      deferred or immediate
    endef

    define immediate !=
      immediate
    endef
  ```

  For the append operator '+=', the right-hand side is considered immediate if
  the variable was previously set as a simple variable (':=' or '::='), and
  deferred otherwise.

- Conditional directives:

  + Conditional directives are parsed immediately.

  + Automatic variables cannot be used in conditional directives, as automatic
    variables are not set until the recipe for that rule is invoked.

  + If you need to use automatic variables in a conditional directive you must
    move the condition into the recipe and use shell conditional syntax
    instead.

- Rule definition:

  A rule is always expanded the same way, regardless of the form:

  ```makefile
    immediate : immediate ; deferred
            deferred
  ```

## How Makefiles Are Parsed

- An important consequence of this is that a macro can expand to an entire
  rule, *if it is one line long*. This will work:

  ```makefile
    myrule = target : ; echo built

    $(myrule)
  ```

- However, this will not work because `make` does not re-split lines after it
  has expanded them:

  ```makefile
    define myrule
    target:
            echo built
    endef

    $(myrule)

  ```

  The above makefile results in the definition of a target '`target`' with
  prerequisites '`echo`' and '`built`', as if the makefile contained `target:
  echo built`, rather than a rule with a recipe:

  ```makefile
    target: echo built
  ```

  Newlines still present in a line after expansion is complete are ignored as
  normal whitespace.

  In order to properly expand a multi-line macro you must use the `eval`
  function: this causes the `make` parser to be run on the results of the
  expanded macro.


## Secondary Expansion

- GNU `make` works in two distinct phases: a read-in phase and a target-update
  phase.

- Variables or functions escaping:

  ```makefile
    .SECONDEXPANSION:
    varone := $$(escaped_variable)
    vartwo := $$(escaped_function foo,bar)
  ```

- Secondary expansion example:

  ```makefile
    .SECONDEXPANSION:
    AVAR = top
    onefile: $(AVAR)
    twofile: $$(AVAR)
    AVAR = bottom
  ```

- They will become even stronger when combine with *automatic variable*s:

  ```makefile
    .SECONDEXPANSION:
    main_OBJS := main.o try.o test.o
    lib_OBJS := lib.o api.o

    main lib: $$($$@_OBJS)
  ```

- Evaluation of automatic variables during the secondary expansion phase.

# Writing Rules

## Rule Example

## Rule Syntax

## Types of Prerequisites

## Using Wildcard Characters in File Names

### Wildcard Examples

### Pitfalls of Using Wildcards

### The Function wildcard

## Searching Directories for Prerequisites

### VPATH: Search Path for All Prerequisites

### The vpath Directive

### How Directory Searches are Performed

### Writing Recipes with Directory Search

### Directory Search and Implicit Rules

### Directory Search for Link Libraries

## Phony Targets

## Rules without Recipes or Prerequisites

## Empty Target Files to Record Events

## Special Built-in Target Names

## Multiple Targets in a Rule

## Multiple Rules for One Target

## Static Pattern Rules

### Syntax of Static Pattern Rules

### Static Pattern Rules versus Implicit Rules

## Double-Colon Rules

## Generating Prerequisites Automatically

# Writing Recipes in Rules

## Recipe Syntax

### Splitting Recipe Lines

### Using Variables in Recipes

## Recipe Echoing

## Recipe Execution

### Using One Shell

### Choosing the Shell

## Parallel Execution

### Output During Parallel Execution

### Input During Parallel Execution

## Errors in Recipes

## Interrupting or Killing make

## Recursive Use of make

### How the MAKE Variable Works

### Communicating Variables to a Sub-make

### Communicating Options to a Sub-make

### The '--print-directory' Option

## Defining Canned Recipes

## Using Empty Recipes

# How to Use Variables

## Basics of Variable References

## The Two Flavors of Variables

## Advanced Features for Reference to Variables

### Substitution References

### Computed Variable Names

## How Variables Get Their Values

## Setting Variables

## Appending More Text to Variables

## The override Directive

## Defining Multi-Line Variables

## Undefining Variables

## Variables from the Environment

## Target-specific Variable Values

## Pattern-specific Variable Values

## Suppressing Inheritance

## Other Special Variables

# Conditional Parts of Makefiles

## Example of a Conditional

## Syntax of Conditionals

## Conditionals that Test Flags

# Functions for Transforming Text

## Function Call Syntax

## Functions for String Substitution and Analysis

## Functions for File Names

## Functions for Conditionals

## The foreach Function

## The file Function

## The call Function

## The value Function

## The eval Function

## The origin Function

## The flavor Function

## Functions That Control Make

## The shell Function

## The guile Function

# How to Run make

## Arguments to Specify the Makefile

## Arguments to Specify the Goals

## Instead of Executing Recipes

## Avoiding Recompilation of Some Files

## Overriding Variables

## Testing the Compilation of a Program

## Summary of Options

# Using Implicit Rules

## Using Implicit Rules

## Catalogue of Built-In Rules

## Variables Used by Implicit Rules

## Chains of Implicit Rules

## Defining and Redefining Pattern Rules

### Introduction to Pattern Rules

### Pattern Rule Examples

### Automatic Variables

### How Patterns Match

### Match-Anything Pattern Rules

### Canceling Implicit Rules

## Defining Last-Resort Default Rules

## Old-Fashioned Suffix Rules

## Implicit Rule Search Algorithm

# Using make to Update Archive Files

## Archive Members as Targets

## Implicit Rule for Archive Member Targets

### Updating Archive Symbol Directories

## Dangers When Using Archives

## Suffix Rules for Archive Files

# Extending GNU make

## GNU Guile Integration

### Conversion of Guile Types

### Interfaces from Guile to make

### Example Using Guile in make

## Loading Dynamic Objects

### The load Directive

### How Loaded Objects Are Remade

### Loaded Object Interface

### Example Loaded Object

# Integrating GNU make

## Sharing Job Slots with GNU make

### POSIX Jobserver Interaction

### Windows Jobserver Interaction

## Synchronized Terminal Output

# Features of GNU make

# Incompatibilities and Missing Features

# Makefile Conventions

## General Conventions for Makefiles

## Utilities in Makefiles

## Variables for Specifying Commands

## DESTDIR: Support for Staged Installs

## Variables for Installation Directories

## Standard Targets for Users

## Install Command Categories

# Appendix A Quick Reference

# Appendix B Errors Generated by Make

# Appendix C Complex Makefile Example

# Appendix D GNU Free Documentation License

# Index of Concepts

# Index of Functions, Variables, & Directives

