# Overview of make
## How to Read This Manual
## Problems and Bugs
# An Introduction to Makefiles

- This chapter is about a simple makefile that descripes how to compile and
  link a text editor which consists of eight C source files and three header
  files.

## What a Rule Looks Like

- A `rule` looks like this:

  ```makefile
  targets : prerequisites
          recipe
          ...
  ```

  or like this:

  ```makefile
  targets : prerequisites ; recipe
          recipe
          ...
  ```

  Remember to put one *tab character* (or the value `.RECIPEPREFIX` variable)
  at the beginning of every recipe line!

- A `target` is *out of date* when it does not exist or if it is older than any
  prerequisites.

## A Simple Makefile
## How make Processes a Makefile

- The `default goal` is the *first target* (not targets whose names start with
  *dot*, `.`) of the *first rule* in the *first makefile* or the
  *`.DEFAULTGOAL` value*.

  You can override this rule by using command line to specify a goal:

  ```bash
  $ make foo
  ```

- The exceptions of the above rule:

  + A target starting with a period is not a default unless it contains one or
    more slashes, `/`, as well.

  + A target that defines a *pattern rule* has no effect on the default goal.

- `make` would update *automatically generated* C programs, such as those made
  by Bison or Yacc, by their own rule.

## Variables Make Makefiles Simpler
## Letting make Deduce the Recipes

- `make` has an *implicit rule* for updating a `.o` file from a correspondingly
  named `.c` file using a `cc -c` command:

  ```bash
  $ cc -c -o main.o main.c
  ```

  Therefore, `.c` files can be omitted from the prerequisites.

  ```makefile
  main.o : defs.h
  utils.o : utils.h
  ```

## Another Style of Makefile
## Rules for Cleaning the Directory
# Writing Makefiles
## What Makefiles Contain

- Makefile contain five kinds of things:

  1. Explicit rules.

  2. Implicit rules.

  3. Variable definitions.

  4. Directives.

     + Reading other makefiles.

     + Deciding (based on the values of variables) whether to use or ignore a
       part of the makefile.

     + Defining a variable from a verbatim string containing multiple lines.

  5. Comments.

### Splitting Long Lines

- *Physical line*s is a single line ending with a newline (regardless of
  whether it is escaped).

- *Logical line*s being a complete statement including all escaped newlines up
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

  After `make` removes the backslash/newline and condenses the following line
  into a single space:

  ```makefile
  var := one$ word
  ```

  Because the variable '`$ `' which does not exist, and so it will expand to
  the empty string ('`oneword`').

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

## The Variable `MAKEFILES`

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

  Thus, `make -f mfile -n mfile foo` would read the makefile `mfile`, print
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

  ```bash
  $ make foo

  $ make bar
  ```

- The rule specifies a prerequisite `force`, to guarantee that the recipe will
  be run even if the target file already exists.

  We give the `force` target an empty recipe to prevent `make` from searching for
  an implicit rule to build it-otherwise it would apply the same match-anything
  rule to force itself and create a prerequisite loop!

## How make Reads a Makefile

- GNU `make` does its work in *two* distinct phases.

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

  The above makefile results in the definition of a target `target` with
  prerequisites `echo` and `built`, as if the makefile contained `target:
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

- Secondary expansion of:

  + Explicit rules.

    * `$$@` evaluate to the file name of the target.

    * When the target is an archive member, `$$%` evaluate to the target member
      name.

    * `$$<` variable evaluates to the *first prerequisite* in the *first rule*
      for this target.

    * `$$^` (without repetitions) and `$$+` (with repetitions) evaluate to the
      list of all prerequisites of rules *that have already appeared* for the
      same target.

    * The variables `$$?` and `$$*` are not available and expand to the empty
      string.

  + Static pattern rules.

    * `$$*` variable is set to the *pattern stem*.

    * `$$?` is not available and expand to the empty string.

  + Implicit rules in the same fashion as static pattern rules.

# Writing Rules

## Rule Example

## Rule Syntax

## Types of Prerequisites

- Two types of prerequisites of GNU `make`:

  + Normal prerequisites such as described in the previous section. It impose:

    * An order in which recipes will be invoked: prerequisites' recipes then
      targets'.

    * A dependency relationship (when targets are out-dated).

  + *Order-only* prerequisites:

    ```makefile
    targets : normal-prerequisites | order-only prerequisites
    ```

    * Impose a specific ordering on the rules to be invoked *without* forcing
      the target to be updated if one of those rules is executed.

## Using Wildcard Characters in File Names

- The wildcard characters in make are `*`, `?` and `[…]`, the same as in
  the Bourne shell.

- Wildcard expansion is performed by make automatically in *target*s and in
  *prerequisite*s.

  In recipes, the shell is responsible for wildcard expansion.

  In other contexts, wildcard expansion happens only if you request it
  explicitly with the `wildcard` function.

### Wildcard Examples

### Pitfalls of Using Wildcards

- Wildcard expansion base on existing filenames. But what if you delete all
  these files?

- When a wildcard matches no files, it is left as it is, so then foo will
  depend on the oddly-named file `*.o`.

### The Function `wildcard`

- If no existing file name matches a pattern, then that pattern is omitted from
  the output of the `wildcard` function.

## Searching Directories for Prerequisites

### VPATH: Search Path for All Prerequisites (general search)

- `make` uses `VPATH` as a search list for both *prerequisite*s and *target*s of
  rules (if they do not exist in current directory).

- In the `VPATH` variable, directory names are separated by colons or blanks.

### The `vpath` Directive (selective search)

- There are three forms of the vpath directive:

  + `vpath pattern directories`

    Specify the search path directories for file names that match *pattern*.

    A `vpath` pattern is a string containing a '%' character.

    The search path, directories, is a list of directories to be searched,
    separated by colons (semi-colons on MS-DOS and MS-Windows) or blanks, just
    like the search path used in the VPATH variable.

  + `vpath pattern`

    Clear out the search path associated with pattern.

  + `vpath`

    Clear all search paths previously specified with vpath directives.

### How Directory Searches are Performed

- GNU `make` directory search algorithm.

- Use `GPATH` variable to use a simpler algorithm of other versions of `make`.

### Writing Recipes with Directory Search

- Write them with *automatic variable*s.

### Directory Search and Implicit Rules

### Directory Search for Link Libraries

- When a prerequisite's name has the form `-lname`, make handles it specially
  by searching for the file `libname.so`, and, if it is not found, for the file
  `libname.a` in:

  + The current directory,

  + The directories specified by matching `vpath` search paths and the `VPATH`
    search path,

  + And then in the directories `/lib`, `/usr/lib`, and `prefix/lib` (normally
    `/usr/local/lib`).

- For example, if there is a `/usr/lib/libcurses.a` library on your system (and
  no `/usr/lib/libcurses.so` file), then

    ```makefile
  foo : foo.c -lcurses
          cc $^ -o $@
    ```

  would cause the command `cc foo.c /usr/lib/libcurses.a -o foo` to be executed
  when foo is older than `foo.c` or than `/usr/lib/libcurses.a`.

- The default value for `.LIBPATTERNS` is `lib%.so lib%.a`, which provides the
  default behavior described above.

  You can turn off link library expansion completely by setting this variable
  to an empty value.

## Phony Targets

- There are two reasons to use a phony target:

  + To avoid a conflict with a file of the same name.

  + To improve performance (the implicit rule search is skipped for `.PHONY`
    targets).

- Phony targets are also useful in conjunction with recursive invocations of
  `make`.

  A loop in recipe method is suck:

  + The loop will continue to build the rest of the directories even when one
    fails (`-k` option makes shell exit code handling suck).

  + We cannot take advantage of `make`s ability to build targets in parallel,
    since *there is only one rule*.

- The *phony* sub-directories way:

  ```makefile

  SUBDIRS = foo bar baz

  .PHONY: subdirs $(SUBDIRS)

  subdirs: $(SUBDIRS)

  $(SUBDIRS):
          $(MAKE) -C $@

  foo: baz
  ```

## Rules without Recipes or Prerequisites

- If a rule has no prerequisites or recipe, and the target of the rule is a
  *nonexistent file*, then make imagines this target to have been updated
  whenever its rule is run.

  This implies that all targets depending on this one will always have their
  recipe run.

- An example will illustrate this:

    ```makefile
    clean: FORCE
            rm $(objects)
    FORCE:
    ```

- Using `.PHONY` is more explicit and more efficient.

## Empty Target Files to Record Events

- The *empty target* is a variant of the *phony target*.

  ```makefile
  print: foo.c bar.c
          lpr -p $?
          touch print
  ```
## Special Built-in Target Names

## Multiple Targets in a Rule

- When an explicit rule has multiple targets they can be treated in one of two
  possible ways:

  + As independent targets.

    * Standard target separator, `:`, define independent targets.

      ```makefile
      bigoutput littleoutput : text.g
              generate text.g -$(subst output,,$@) > $@
      ```

  + As grouped targets.

    * Instead of independent targets you have a recipe that generates/updates
      multiple files from *a single invocation*.

    * A grouped target rule uses the separator `&:` (the `&` here is used to
      imply "all").

    * When make builds any one of the grouped targets, it understands that all
      the other targets in the group are also created as a result of the
      invocation of the recipe.

      Furthermore, if only some of the grouped targets are out of date or
      missing `make` will realize that running the recipe will update all of
      the targets.

      ```makefile
      foo bar biz &: baz boz
              echo $^ > foo
              echo $^ > bar
              echo $^ > biz
      ```

    * Caution must be used if relying on `$@` variable in the recipe of a
      grouped target rule.

    * A grouped target rule *must* include a recipe.

      A grouped target may also appear in *independent* target rule definitions
      that do not have recipes.

      If a grouped target appears in either an independent target rule or in
      another grouped target rule with a recipe, the latter recipe will replace
      the former recipe.

      The target will be removed from the previous group and appear only in the
      new group.

      If you would like a target to appear in multiple groups, then you must
      use the *double-colon grouped target* separator, `&::`.

## Multiple Rules for One Target

- All the prerequisites mentioned in all the rules are merged into one list of
  prerequisites for the target.

- If more than one rule gives a recipe for the same file, `make` uses the last
  one given and prints an error message.

- Occasionally it is useful to have the same target invoke multiple recipes
  which are defined in different parts of your makefile; you can use
  *double-colon rules* for this.

- The command `make extradeps=foo.h` will consider `foo.h` as a prerequisite of
  each object file, but plain `make` will not:

  ```makefile
  extradeps=
  $(objects) : $(extradeps)
  ```

## Static Pattern Rules

- They are more general than ordinary rules with multiple targets because the
  targets do not have to have identical prerequisites.

- Their prerequisites must be *analogous*, but not necessarily *identical*.

### Syntax of Static Pattern Rules

- Here is the syntax of a static pattern rule:

  ```makefile
  targets …: target-pattern: prereq-patterns …
          recipe
          …
  ```

  The `targets` list specifies the targets that the rule applies to.

  Each target is matched against the *target-pattern* to extract a part of the
  target name, called the *stem*.

  The prerequisite names for each target are made by substituting the stem for
  the `%` in each *prerequisite pattern*.

- Each target specified must match the target pattern; a warning is issued for
  each target that does not (use `filter` function).

- Another example shows how to use `$*` in static pattern rules:

  ```makefile
  bigoutput littleoutput : %output : text.g
          generate text.g -$* > $@
  ```

### Static Pattern Rules versus Implicit Rules (#NOPE, #REVIEW)

- The difference is in how `make` decides *when* the rule applies.

- An implicit rule *can* apply to any target that matches its pattern, but it
  *does* apply only when the target has no recipe otherwise specified, and only
  when the prerequisites can be found.

  If more than one implicit rule appears applicable, only one applies; the
  choice depends on the order of rules.

- By contrast, a static pattern rule applies to the precise list of targets
  that you specify in the rule. It cannot apply to any other target and it
  invariably does apply to each of the targets specified.

  If two conflicting rules apply, and both have recipes, that's an error.

- The static pattern rule can be better than an implicit rule for these
  reasons:

  + You may wish to override the usual implicit rule for a few files whose
    names cannot be categorized syntactically but can be given in an explicit
    list.

  + If you cannot be sure of the precise contents of the directories you are
    using, you may not be sure which other irrelevant files might lead `make`
    to use the wrong implicit rule. The choice might depend on the order in
    which the implicit rule search is done. With static pattern rules, there is
    no uncertainty: each rule applies to precisely the targets specified.

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

