# ABOUT THIS NOTE

- This is a **shortened** version of [GNU
  `make` manual](https://www.gnu.org/software/make/manual/make.html).

- This note is created by me, for me who know a little basic about `make` and
  for someone who at least at the same level.

  But, it's still very basic. I'll try keep the information detail as much as
  possible.

- Why I create this note?

  + Learning `make`.

  + Note for myself for reference purpose.

  + Sharing.

# Overview of make
## How to Read This Manual
## Problems and Bugs
# An Introduction to Makefiles
## What a Rule Looks Like

See ## Rule Syntax.

## A Simple Makefile
## How make Processes a Makefile

- `make` would update *automatically generated* C programs, such as those made
  by Bison or Yacc, by their own rule.

## Variables Make Makefiles Simpler
## Letting make Deduce the Recipes

- `make` has an *implicit rule* for updating a `.o` file from a correspondingly
  named `.c` file using a `cc -c` command:

  ```bash
  $ cc -c -o main.o main.c
  ```

  Therefore, `.c` files can be omitted from the prerequisites, provided we omit
  the recipe:

  ```makefile
  objects = main.o kbd.o command.o display.o \
            insert.o search.o files.o utils.o

  edit : $(objects)
          cc -o edit $(objects)

  main.o : defs.h
  kbd.o : defs.h command.h
  command.o : defs.h command.h
  display.o : defs.h buffer.h
  insert.o : defs.h buffer.h
  search.o : defs.h buffer.h
  files.o : defs.h buffer.h command.h
  utils.o : defs.h

  .PHONY : clean
  clean :
          rm edit $(objects)
  ```

## Another Style of Makefile

- In this style of makefile, you group entries by their prerequisites instead
  of by their targets:

  ```makefile
  objects = main.o kbd.o command.o display.o \
            insert.o search.o files.o utils.o

  edit : $(objects)
          cc -o edit $(objects)

  $(objects) : defs.h
  kbd.o command.o files.o : command.h
  display.o insert.o search.o files.o : buffer.h
  ```

## Rules for Cleaning the Directory
# Writing Makefiles
## What Makefiles Contain

- Makefiles contain five kinds of things:

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

- Makefiles use a *line-based* syntax in which the newline character is special
  and marks the end of a statement.

  GNU `make` has no limit on the length of a statement line, up to the amount
  of memory in your computer.

- *Physical line*s is a single line ending with a newline (regardless of
  whether it is escaped).

- *Logical line*s being a complete statement including all escaped newlines up
  to the first non-escaped newline.

- *Outside of recipe line*s, backslash/newline**s** are converted into a
  *single space* character.

  Then all whitespace around the backslash/newline is condensed into a *single
  space*.

- *Splitting without adding whitespace*: dollar sign/backslash/newline instead
  of backslash/newline:

  ```makefile
  var := one$\
         \
         word
  ```

  After `make` removes the backslash/newline and condenses the following
  line[s] into a single space:

  ```makefile
  var := one$ word
  ```

  Because the variable '`$ `' which does not exist, and so it will expand to
  the empty string ('`oneword`').

## What Name to Give Your Makefile

- By default, when `make` looks for the makefile, it tries the following names,
  in order: `GNUmakefile` (specific to GNU `make`), `makefile` and `Makefile`
  (recommended).

- If you use more than one `-f` or `--file` option, you can specify several
  makefiles. All the makefiles are effectively *concatenated* in the *order*
  specified.

## Including Other Makefiles

- Include directive syntax:

  ```makefile
  include foo *.mk $(bar)
  ```

  Extra spaces are allowed and ignored at the beginning of the line, but the
  first character must *not* be a tab (or the value of `.RECIPEPREFIX`)

- If the specified name does not start with a slash, and the file is not found
  in the current directory, several other directories are searched:

  + First, any directories you have specified with the `-I` or `--include-dir`
    option are searched.

  + Then the following directories (if they exist) are searched, in this order:
    `prefix/include` (normally `/usr/local/include`) `/usr/gnu/include`,
    `/usr/local/include`, `/usr/include`.

- If an included makefile cannot be found in any of these directories, a
  warning message is generated, but it is not an immediately fatal error;
  processing of the makefile containing the `include` continues.

  Once it has finished reading makefiles, `make` will try to *remake* any that
  are out of date or don't exist (now, if `make` failed it's a fatal error).

- For compatibility with some other `make` implementations, `sinclude` is
  another name for `-include`.

## The Variable `MAKEFILES`

- If the environment variable `MAKEFILES` is defined, `make` considers its
  value as a list of names (separated by whitespace) of additional makefiles to
  be read *before* the others.

  This works much like the `include` directive: various directories are searched
  for those files (see above, ## Including Other Makefiles).

  In addition, the default goal is never taken from one of these makefiles (or
  any makefile included by them) and it is not an error if the files listed in
  MAKEFILES are not found.

- The main use of `MAKEFILES` is in communication between recursive invocations
  of `make`.

## How Makefiles Are Remade

- After reading in all makefiles `make` will consider each as a *goal target*
  and attempt to update it (via explicit or implicit rules).

  After all makefiles have been **checked**, if any have actually been
  **changed**, make starts with a **clean slate** and reads all the makefiles
  over again?

- Prevent implicit rule look-up: you can write an explicit rule with the
  makefile as the target, and an empty recipe.

- `make` will not attempt to remake makefiles which are specified as targets of
  a double-colon rule with a recipe but no prerequisites (cos of infinite loop).

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

  We give the `force` target an empty recipe to prevent `make` from searching
  for an implicit rule to build it-otherwise it would apply the same
  match-anything rule to force itself and create a prerequisite loop!

  See ## Rules without Recipes or Prerequisites.

## How `make` Reads a Makefile

- GNU `make` does its work in *two* distinct phases:

  1. During the *first phase*:

     + Reads all the makefiles, included makefiles.

     + Internalizes all the variables and implicit and explicit rules.

     + Builds a dependency graph of all the targets and theirs prerequisites.

  2. During the *second phase*, `make` use this internalized data to determine
     which targets need to be updated and run the recipes necessary to update
     them.

- It's important to understand this two-phase approach because it has a direct
  impact on how variable and function expansion happens.

- We say that expansion is *immediate* if it happens during the first phase:
  `make` will expand that part of the construct as the makefile is *parsed*.

  We say that expansion is *deferred* if it is not immediate.

- Expansion of a *deferred* construct part is delayed until the expansion is
  *used*: either when it is referenced in an immediate context, or when it is
  needed during the second phase.

1. Variable assignment:

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

   For the append operator '`+=`', the right-hand side is considered immediate
   if the variable was previously set as a simple variable ('`:=`' or '`::=`'),
   and deferred otherwise.

2. Conditional directives:

   + Conditional directives are parsed immediately.

   + Automatic variables cannot be used in conditional directives, as automatic
     variables are not set until the recipe for that rule is invoked.

   + If you need to use automatic variables in a conditional directive you must
     move the condition into the recipe and use shell conditional syntax
     instead.

3. Rule definition:

   A rule is always expanded the same way, regardless of the form:

   ```makefile
   immediate : immediate ; deferred
           deferred
   ```

   This is true for explicit rules, pattern rules, suffix rules, static pattern
   rules, and simple prerequisite definitions.

## How Makefiles Are Parsed

- GNU `make` parses makefiles line-by-line. Parsing proceeds using the following steps:

  1. Read in a full logical line, including backslash-escaped lines (see
     Splitting Long Lines).

  2. Remove comments (see What Makefiles Contain).

  3. If the line begins with the recipe prefix character and we are in a rule
     context, add the line to the current recipe and read the next line (see
     Recipe Syntax).

  4. Expand elements of the line which appear in an immediate expansion context
     (see How make Reads a Makefile).

  5. Scan the line for a separator character, such as ‘:’ or ‘=’, to determine
     whether the line is a macro assignment or a rule (see Recipe Syntax).

  6. Internalize the resulting operation and read the next line.

- An important consequence of this is that a macro can expand to an entire
  rule, *if it is one line long*. This will work:

  ```makefile
  myrule = target : ; echo built

  $(myrule)
  ```

- However, this will *not* work because `make` does not re-split lines after it
  has expanded them:

  ```makefile
  define myrule
  target:
          echo built
  endef

  $(myrule)

  ```

  It is equivalent to:

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

  GNU `make` also has the ability to enable a second expansion of the
  *prerequisite*s (only) for some or all targets defined in the makefile.

- An example of escaped variables and functions:

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

- Secondary expansion and the different types of rule definitions:

  + **Explicit rules**.

    * `$$@` evaluates to the file name of the target.

    * `$$%` evaluates to the target member name when the target is an archive
      member.

    * `$$<` variable evaluates to the *first prerequisite* in the *first rule*
      for this target.

    * `$$+` (with repetitions) and `$$^` (without repetitions) evaluate to the
      list of all prerequisites of rules *that have already appeared* for the
      same target.

    * The variables `$$?` and `$$*` are not available and expand to the empty
      string.

    This example will help illustrate these behaviors:

    ```makefile
    .SECONDEXPANSION:

    foo: foo.1 bar.1 $$< $$^ $$+    # line #1

    foo: foo.2 bar.2 $$< $$^ $$+    # line #2

    foo: foo.3 bar.3 $$< $$^ $$+    # line #3
    ```

    * `line #1`: all three variables (`$$<`, `$$^`, and `$$+`) expand to the
      empty string (current rule's excluded).

    * `line #2`: `foo.1`, `foo.1 bar.1`, and `foo.1 bar.1` respectively.

    * `line #3`: `foo.1`, `foo.1 bar.1 foo.2 bar.2`, and `foo.1 bar.1 foo.2 bar.2
      foo.1 foo.1 bar.1 foo.1 bar.1` respectively.

  + **Static pattern rules** are identical to those for *explicit rules*, with
    one exception:

    * `$$*` variable is set to the pattern *stem*.

  + **Implicit rules** in the same fashion as *static pattern rules*.

# Writing Rules

- The `default goal` is the *first target* (not targets whose names start with
  *dot*, `.`) of the *first rule* in the *first makefile* or the `.DEFAULTGOAL`
  value.

  Of course, you can override this rule by using command line to specify a
  goal:

  ```bash
  $ make foo
  ```

- There are two exceptions of the above rule:

  + A target starting with a period is not a default unless it contains one or
    more slashes, `/`, as well.

  + A target that defines a *pattern rule* has no effect on the default goal.

## Rule Example

## Rule Syntax

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

  Remember to put one *tab* character (or the value `.RECIPEPREFIX` variable)
  at the beginning of every `recipe` line!

- A `target` is *out of date* when it does not exist or if it is older than any
  prerequisites.

## Types of Prerequisites

- Two types of prerequisites of GNU `make`:

  + *Normal prerequisite*s such as described in the previous section. It impose:

    * An **order** in which recipes will be invoked: prerequisites' recipes,
      then targets'.

    * A dependency relationship (when targets are out-dated).

  + *Order-only prerequisite*s:

    ```makefile
    targets : normal-prerequisites | order-only prerequisites
    ```

    * Impose a specific ordering on the rules to be invoked *without* forcing
      the target to be updated if one of those rules is executed.

## Using Wildcard Characters in File Names

- The wildcard characters in make are `*`, `?` and `[...]`, the same as in
  the Bourne shell.

  And, of course, `~` expansion is supported too.

- Wildcard expansion is performed by make *automatically* in targets and in
  prerequisites.

- In recipes, the shell is responsible for wildcard expansion.

- In other contexts, wildcard expansion happens only if you request it
  explicitly with the `wildcard` function.

### Wildcard Examples

### Pitfalls of Using Wildcards

- Wildcard expansion base on *existing* filenames. But what if you delete all
  these files?

- When a wildcard matches no files, it is left as it is, so then `foo` will
  depend on the oddly-named file `*.o`:

  ```makefile
  objects = *.o

  foo : $(objects)
          cc -o foo $(CFLAGS) $(objects)
  ```

### The Function `wildcard`

- Wildcard expansion does not normally take place when a variable is set, or
  inside the arguments of a function, we use `wildcard` function.

- If no existing file name matches a pattern, then that pattern is *omitted*
  from the output of the `wildcard` function.

## Searching Directories for Prerequisites

- When you redistribute the files among directories, you do not need to change
  the individual rules, just the search paths.

### `VPATH`: Search Path for All Prerequisites (general search)

- `make` uses `VPATH` as a search list for both *prerequisite*s and *target*s of
  rules (when they do not exist in current directory).

- In the `VPATH` variable, directory names are separated by *colons* or
  *blanks*.

### The `vpath` Directive (selective search)

- There are three forms of the `vpath` directive:

  + `vpath` *`pattern`* *`directories`*

    Specify the search path `directories` for file names that match *pattern*.

    The search path, *directories*, is a list of directories to be searched,
    separated by colons (semi-colons on MS-DOS and MS-Windows) or blanks, just
    like the search path used in the `VPATH` variable.

  + `vpath` *`pattern`*

    Clear out the search path associated with pattern.

  + `vpath`

    Clear all search paths previously specified with vpath directives.

- A `vpath` `pattern` is a string containing a '`%`' character.

  The `%` character matching any sequence of *zero* or more characters.

- When a prerequisite fails to exist in the current directory, if the *pattern*
  in a `vpath` directive matches the name of the prerequisite file, then the
  *directories* in that directive are searched just like (and *before*) the
  directories in the `VPATH` variable.

### How Directory Searches are Performed

- The algorithm `make` uses to decide whether to *keep* or *abandon* a path
  found via directory search is as follows:

  1. If a target file does not exist at the path specified in the makefile,
     directory search is performed.

  2. If the directory search is successful, that path is kept and this file is
     tentatively stored as the target.

  3. All prerequisites of this target are examined using this same method.

  4. After processing the prerequisites, the target may or may not need to be
     rebuilt:

     1. If the target does *not* need to be rebuilt, the path to the file found
        during directory search is used for any prerequisite lists which
        contain this target.

        In short, if `make` doesn’t need to rebuild the target then you use the
        path found via directory search.

     2. If the target *does* need to be rebuilt (is out-of-date), the pathname
        found during directory search is *thrown away*, and the target is
        rebuilt using the file name specified in the makefile.

        In short, if `make` must rebuild, then the target is rebuilt locally,
        not in the directory found via directory search.

- Use `GPATH` variable to use a simpler algorithm of other versions of `make`.

  If the file does not exist, and it is found via directory search, then that
  pathname is always used whether or not the target needs to be built.

### Writing Recipes with Directory Search

- Just use *automatic variable*s in recipes (`$^`, `$@`, etc.).

### Directory Search and Implicit Rules

- The search through the directories specified in `VPATH` or with `vpath` also
  happens during consideration of implicit rules.

### Directory Search for Link Libraries

- When a prerequisite's name has the form `-lname`, make handles it specially
  by searching for the file `libname.so`, and, if it is not found, for the file
  `libname.a` in:

  + The current directory,

  + The directories specified by matching `vpath` search paths and

  + The `VPATH` search path,

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

- Phony targets are also useful in conjunction with *recursive* invocations of
  `make`.

  A loop in recipe method is suck:

  + The loop will continue to build the rest of the directories even when one
    fails (`-k` option makes shell exit code handling suck).

  + We cannot take advantage of `make`s ability to build targets in *parallel*,
    since there is only one rule.

- The *phony* sub-directories way:

  ```makefile
  SUBDIRS = foo bar baz

  .PHONY: subdirs $(SUBDIRS)

  subdirs: $(SUBDIRS)

  $(SUBDIRS):
          $(MAKE) -C $@

  foo: baz
  ```

  Here we've also declared that the `foo` sub-directory cannot be built until
  after the `baz` sub-directory is complete; this kind of relationship
  declaration is particularly important when attempting *parallel* builds.

## Rules without Recipes or Prerequisites

- If a rule has no prerequisites or recipe, and the target of the rule *is* a
  nonexistent file, then make imagines this target to have been updated
  whenever its rule is run.

  This implies that all targets depending on this one will *always* have their
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

- The purpose of the empty target file is to record, with its last-modification
  time, when the rule’s recipe was last executed.

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

    * The *colon* (`:`) is standard target separator.

      ```makefile
      bigoutput littleoutput : text.g
              generate text.g -$(subst output,,$@) > $@
      ```

  + As grouped targets.

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

      - However, targets that are members of a grouped target may also appear
        in independent target rule definitions that do *not* have recipes.

      - If a grouped target appears in either an independent target rule or in
        another grouped target rule with a recipe, you will get a warning and
        the *latter* recipe will replace the former recipe.

        Additionally the target will be removed from the previous group and
        appear only in the new group.

      - If you would like a target to appear in multiple groups, then you must
        use the *double-colon grouped target* separator, `&::`.

        Grouped double-colon targets are each considered independently, and
        each grouped double-colon rule's recipe is executed at most once, if at
        least one of its multiple targets requires updating.

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

- It's just a *pattern rule* but it is limited in a list provided by `targets`.

### Syntax of Static Pattern Rules

- Here is the syntax of a *static pattern rule*:

  ```makefile
  targets ... : target-pattern: prereq-patterns ...
          recipe
          ...
  ```

- Again, the `targets` list specifies the targets that the rule applies to.

  Each target is matched against the `target-pattern` to extract a part of the
  target name, called the *stem*.

  The prerequisite names for each target are made by substituting the stem for
  the `%` in each *prerequisite pattern*.

- Each target specified *must* match the target pattern; a warning is issued
  for each target that does not (use `filter` function).

- Another example shows how to use `$*` in static pattern rules:

  ```makefile
  bigoutput littleoutput : %output : text.g
          generate text.g -$* > $@
  ```

### Static Pattern Rules versus Implicit Rules

- The difference is in how `make` decides *when* the rule applies.

  1. An implicit rule *can* apply to any target that matches its pattern, but it
     *does* apply only when the target has no recipe otherwise specified, and
     *only* when the prerequisites can be found.

     If more than one implicit rule appears applicable, *only* one applies; the
     choice depends on the *order* of rules.

  2. By contrast, a static pattern rule applies to the precise list of targets
     that you specify in the rule. It cannot apply to any other target and it
     invariably does apply to each of the targets specified.

     If two conflicting rules apply, and both have recipes, that's an error.

- The static pattern rule can be *better* than an implicit rule for these
  reasons:

  + You may wish to override the usual implicit rule for a few files whose
    names cannot be categorized syntactically but can be given in an explicit
    list.

  + If you cannot be sure of the precise contents of the directories you are
    using, you may not be sure which other irrelevant files might lead `make`
    to use the wrong implicit rule. The choice might depend on the order in
    which the implicit rule search is done.

    With static pattern rules, there is no uncertainty: each rule applies to
    precisely the targets specified.

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

