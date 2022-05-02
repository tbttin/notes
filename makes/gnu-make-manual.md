# ABOUT THIS NOTE

- This is a **shortened** version of [GNU `make` manual].

- This note is created by me, for me who know a little basic about
  `make` and for someone who at least at the same level.

  But, it's still very basic. I'll try keep the information detail as
  much as possible.

- Why I create this note?

  + Learning `make`. To note every thing new to me or I can not
    understand.

  + A note for myself for reference purpose.

  + Sharing.

# Overview of `make`

[#Overview]

## How to Read This Manual

[#Reading]

## Problems and Bugs

[#Bugs]

# An Introduction to Makefiles

[#Introduction]

## What a Rule Looks Like

See [Rule Syntax].

[#Rule-Introduction]

## A Simple Makefile

[#Simple-Makefile]

## How `make` Processes a Makefile

- `make` would update *automatically generated* C programs, such as
  those made by Bison or Yacc, by their own rule.

[#How-Make-Works]

## Variables Make Makefiles Simpler

[#Variables-Simplify]

## Letting `make` Deduce the Recipes

- `make` has an *implicit rule* for updating a `.o` file from a
  correspondingly named `.c` file using a `cc -c`{.bash} command:

  ```bash
  $ cc -c -o main.o main.c
  ```

  Therefore, `.c` files can be omitted from the prerequisites, provided
  we omit the recipe:

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

[#make-Deduces]

## Another Style of Makefile

- In this style of makefile, you group entries by their prerequisites
  instead of by their targets:

  ```makefile
  objects = main.o kbd.o command.o display.o \
            insert.o search.o files.o utils.o

  edit : $(objects)
          cc -o edit $(objects)

  $(objects) : defs.h
  kbd.o command.o files.o : command.h
  display.o insert.o search.o files.o : buffer.h
  ```

[#Combine-By-Prerequisite]

## Rules for Cleaning the Directory

[#Cleanup]

# Writing Makefiles

[#Makefiles]

## What Makefiles Contain

- Makefiles contain five kinds of things:

  1. Explicit rules.

  2. Implicit rules.

  3. Variable definitions.

  4. Directives.

     + Reading other makefiles.

     + Deciding (based on the values of variables) whether to use or
       ignore a part of the makefile.

     + Defining a variable from a verbatim string containing multiple
       lines.

  5. Comments.

[#Makefile-Contents]

### Splitting Long Lines

- Makefiles use a *line-based* syntax in which the newline character is
  special and marks the end of a statement.

  GNU `make` has no limit on the length of a statement line, up to the
  amount of memory in your computer.

- *Physical line*s is a single line ending with a newline (regardless of
  whether it is escaped).

- *Logical line*s being a complete statement including all escaped
  newlines up to the first non-escaped newline.

- *Outside of recipe line*s, backslash/newline**s** are converted into a
  *single space* character.

  Then all whitespace around the backslash/newline is condensed into a
  *single space*.

- *Splitting without adding whitespace*: dollar sign/backslash/newline
  instead of backslash/newline:

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

  Because the variable '`$ `' which does not exist, and so it will
  expand to the empty string ('`oneword`').

[#Splitting-Lines]

## What Name to Give Your Makefile

- By default, when `make` looks for the makefile, it tries the following
  names, in order: `GNUmakefile` (specific to GNU `make`), `makefile`
  and `Makefile` (recommended).

- If you use more than one `-f` or `--file` option, you can specify
  several makefiles. All the makefiles are effectively *concatenated* in
  the *order* specified.

[#Makefile-Names]

## Including Other Makefiles

- Include directive syntax:

  ```makefile
  include foo *.mk $(bar)
  ```

  Extra spaces are allowed and ignored at the beginning of the line, but
  the first character must *not* be a tab (or the value of
  `.RECIPEPREFIX`)

- If the specified name does not start with a slash, and the file is not
  found in the current directory, several other directories are
  searched:

  + First, any directories you have specified with the `-I` or
    `--include-dir` option are searched.

  + Then the following directories (if they exist) are searched, in this
    order: `prefix/include` (normally `/usr/local/include`)
    `/usr/gnu/include`, `/usr/local/include`, `/usr/include`.

- If an included makefile cannot be found in any of these directories, a
  warning message is generated, but it is not an immediately fatal
  error; processing of the makefile containing the `include` continues.

  Once it has finished reading makefiles, `make` will try to *remake*
  any that are out of date or don't exist (now, if `make` failed it's a
  fatal error).

- For compatibility with some other `make` implementations, `sinclude`
  is another name for `-include`.

[#Include]

## The Variable `MAKEFILES`

- If the environment variable `MAKEFILES` is defined, `make` considers
  its value as a list of names (separated by whitespace) of additional
  makefiles to be read *before* the others.

  This works much like the `include` directive: various directories are
  searched for those files (see [Including Other Makefiles]).

  In addition, the default goal is never taken from one of these
  makefiles (or any makefile included by them) and it is not an error if
  the files listed in MAKEFILES are not found.

- The main use of `MAKEFILES` is in communication between recursive
  invocations of `make`.

[#MAKEFILES-Variable]

## How Makefiles Are Remade

- After reading in all makefiles `make` will consider each as a *goal
  target* and attempt to update it (via explicit or implicit rules).

  After all makefiles have been **checked**, if any have actually been
  **changed**, make starts with a **clean slate** and reads all the
  makefiles over again?

- Prevent implicit rule look-up: you can write an explicit rule with the
  makefile as the target, and an empty recipe.

- `make` will not attempt to remake makefiles which are specified as
  targets of a double-colon rule with a recipe but no prerequisites (cos
  of infinite loop).

- The `-t` (or `--touch`), `-q` (or `--question`) and `-n` (or
  `--just-print`) do not prevent updating makefiles.

- Prevent update makefiles: specify the makefiles as goals in the
  command line as well as specifying them as makefiles.

  Thus, `make -f mfile -n mfile foo` would read the makefile `mfile`,
  print the recipe needed to update it without actually running it, and
  then print the recipe needed to update `foo` without running that.

[#Remaking-Makefiles]

## Overriding Part of Another Makefile

- For example, if you have a makefile called `Makefile` that says how to
  make the target 'foo' (and other targets), you can write a makefile
  called `GNUmakefile` that contains:

  ```makefile
  foo:
          frobnicate > foo

  %: force
          @echo 'Running $@'
          @$(MAKE) -f Makefile $@
  force: ;
  ```

  Then,

  ```bash
  $ make foo

  $ make bar
  ```

  Why "Running GNUmakefile" is echoed?

- The rule specifies a prerequisite `force`, to guarantee that the
  recipe will be run even if the target file already exists.

  We give the `force` target an empty recipe to prevent `make` from
  searching for an implicit rule to build it-otherwise it would apply
  the same match-anything rule to force itself and create a prerequisite
  loop!

  See [Rules without Recipes or Prerequisites].

[#Overriding-Makefiles]

## How `make` Reads a Makefile

- GNU `make` does its work in *two* distinct phases:

  1. During the *first phase*:

     + Reads all the makefiles, included makefiles.

     + Internalizes all the variables and implicit and explicit rules.

     + Builds a dependency graph of all the targets and theirs
       prerequisites.

  2. During the *second phase*, `make` use this internalized data to
     determine which targets need to be updated and run the recipes
     necessary to update them.

- It's important to understand this two-phase approach because it has a
  direct impact on how variable and function expansion happens.

- We say that expansion is *immediate* if it happens during the first
  phase: `make` will expand that part of the construct as the makefile
  is *parsed*.

  We say that expansion is *deferred* if it is not immediate.

- Expansion of a *deferred* construct part is delayed until the
  expansion is *used*: either when it is referenced in an immediate
  context, or when it is needed during the second phase.

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

   For the append operator '`+=`', the right-hand side is considered
   immediate if the variable was previously set as a simple variable
   ('`:=`' or '`::=`'), and deferred otherwise.

2. Conditional directives:

   + Conditional directives are parsed immediately.

   + Automatic variables cannot be used in conditional directives, as
     automatic variables are not set until the recipe for that rule is
     invoked.

   + If you need to use automatic variables in a conditional directive
     you must move the condition into the recipe and use shell
     conditional syntax instead.

3. Rule definition:

   A rule is always expanded the same way, regardless of the form:

   ```makefile
   immediate : immediate ; deferred
           deferred
   ```

   This is true for explicit rules, pattern rules, suffix rules, static
   pattern rules, and simple prerequisite definitions.

[#Reading-Makefiles]

## How Makefiles Are Parsed

- GNU `make` parses makefiles line-by-line. Parsing proceeds using the
  following steps:

  1. Read in a full logical line, including backslash-escaped lines (see
     [Splitting Long Lines]).

  2. Remove comments (see [What Makefiles Contain]).

  3. If the line begins with the recipe prefix character and we are in a
     rule context, add the line to the current recipe and read the next
     line (see [Recipe Syntax]).

  4. Expand elements of the line which appear in an immediate expansion
     context (see [How `make` Reads a Makefile]).

  5. Scan the line for a separator character, such as `:` or `=`, to
     determine whether the line is a macro assignment or a rule (see
     [Recipe Syntax]).

  6. Internalize the resulting operation and read the next line.

- An important consequence of this is that a macro can expand to an
  entire rule, *if it is one line long*. This will work:

  ```makefile
  myrule = target : ; echo built

  $(myrule)
  ```

- However, this will *not* work because `make` does not re-split lines
  after it has expanded them:

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

  Newlines still present in a line after expansion is complete are
  ignored as normal whitespace.

  In order to properly expand a multi-line macro you must use the `eval`
  function: this causes the `make` parser to be run on the results of
  the expanded macro.

[#Parsing-Makefiles]

## Secondary Expansion

- GNU `make` works in two distinct phases: a read-in phase and a
  target-update phase.

  GNU `make` also has the ability to enable a second expansion of the
  *prerequisite*s (only) for some or all targets defined in the
  makefile.

- An example of escaped variables and escaped functions:

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

- They will become even stronger when combine with *automatic
  variable*s:

  ```makefile
  .SECONDEXPANSION:
  main_OBJS := main.o try.o test.o
  lib_OBJS := lib.o api.o

  main lib: $$($$@_OBJS)
  ```

- Evaluation of automatic variables during the secondary expansion
  phase.

- Secondary expansion and the different types of rule definitions:

  + **Explicit rules**.

    * `$$@` evaluates to the file name of the target.

    * `$$%` evaluates to the target member name when the target is an
      archive member.

    * `$$<` variable evaluates to the *first prerequisite* in the *first
      rule* for this target.

    * `$$+` (with repetitions) and `$$^` (without repetitions) evaluate
      to the list of all prerequisites of rules *that have already
      appeared* for the same target.

    * The variables `$$?` and `$$*` are not available and expand to the
      empty string.

    This example will help illustrate these behaviors:

    ```makefile
    .SECONDEXPANSION:

    foo: foo.1 bar.1 $$< $$^ $$+    # line #1

    foo: foo.2 bar.2 $$< $$^ $$+    # line #2

    foo: foo.3 bar.3 $$< $$^ $$+    # line #3
    ```

    * `line #1`: all three variables (`$$<`, `$$^`, and `$$+`) expand to
      the empty string (current rule's excluded).

    * `line #2`: `foo.1`, `foo.1 bar.1`, and `foo.1 bar.1` respectively.

    * `line #3`: `foo.1`, `foo.1 bar.1 foo.2 bar.2`, and `foo.1 bar.1
      foo.2 bar.2 foo.1 foo.1 bar.1 foo.1 bar.1` respectively.

  + **Static pattern rules** are identical to those for *explicit
    rules*, with one exception:

    * `$$*` variable is set to the pattern *stem*.

  + **Implicit rules** in the same fashion as *static pattern rules*.

[#Secondary-Expansion]

# Writing Rules

- The `default goal` is the *first target* (not targets whose names
  start with *dot*, `.`) of the *first rule* in the *first makefile* or
  the `.DEFAULTGOAL` value.

  Of course, you can override this rule by using command line to specify
  a goal:

  ```bash
  $ make foo
  ```

- There are two exceptions of the above rule:

  + A target starting with a period is not a default unless it contains
    one or more slashes, `/`, as well.

  + A target that defines a *pattern rule* has no effect on the default
    goal.

[#Rules]

## Rule Example

[#Rule-Example]

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

  Remember to put one *tab* character (or the the *first* character in
  the value of the `.RECIPEPREFIX` variable) at the beginning of every
  `recipe` line!

- A `target` is *out of date* when it does not exist or if it is older
  than any prerequisites.

[#Rule-Syntax]

## Types of Prerequisites

- Two types of prerequisites of GNU `make`:

  + *Normal prerequisite*s such as described in the previous section. It
    impose:

    * An **order** in which recipes will be invoked: prerequisites'
      recipes, then targets'.

    * A dependency relationship (when targets are out-dated).

  + *Order-only prerequisite*s:

    ```makefile
    targets : normal-prerequisites | order-only prerequisites
    ```

    * Impose a specific ordering on the rules to be invoked *without*
      forcing the target to be updated if one of those rules is
      executed.

[#Prerequisite-Types]

## Using Wildcard Characters in File Names

- The wildcard characters in make are `*`, `?` and `[...]`, the same as
  in the Bourne shell.

  And, of course, `~` expansion is supported too.

- Wildcard expansion is performed by make *automatically* in targets and
  in prerequisites.

- In recipes, the shell is responsible for wildcard expansion.

- In other contexts, wildcard expansion happens only if you request it
  explicitly with the `wildcard` function.

[#Wildcards]

### Wildcard Examples

[#Wildcard-Examples]

### Pitfalls of Using Wildcards

- Wildcard expansion base on *existing* filenames. But what if you
  delete all these files?

- When a wildcard matches no files, it is left as it is, so then `foo`
  will depend on the oddly-named file `*.o`:

  ```makefile
  objects = *.o

  foo : $(objects)
          cc -o foo $(CFLAGS) $(objects)
  ```

[#Wildcard-Pitfall]

### The Function `wildcard`

- Wildcard expansion does not normally take place when a variable is
  set, or inside the arguments of a function, we use `wildcard`
  function.

- If no existing file name matches a pattern, then that pattern is
  *omitted* from the output of the `wildcard` function.

[#Wildcard-Function]

## Searching Directories for Prerequisites

- When you redistribute the files among directories, you do not need to
  change the individual rules, just the search paths.

[#Directory-Search]

### `VPATH`: Search Path for All Prerequisites

- `make` uses `VPATH` as a search list for both *prerequisite*s and
  *target*s of rules (when they do not exist in current directory).

- In the `VPATH` variable, directory names are separated by *colons* or
  *blanks*.

[#General-Search]

### The `vpath` Directive

- There are three forms of the `vpath` directive:

  + `vpath` *`pattern`* *`directories`*

    Specify the search path `directories` for file names that match
    *pattern*.

    The search path, *directories*, is a list of directories to be
    searched, separated by colons (semi-colons on MS-DOS and MS-Windows)
    or blanks, just like the search path used in the `VPATH` variable.

  + `vpath` *`pattern`*

    Clear out the search path associated with pattern.

  + `vpath`

    Clear all search paths previously specified with vpath directives.

- A `vpath` `pattern` is a string containing a '`%`' character.

  The `%` character matching any sequence of *zero* or more characters.

- When a prerequisite fails to exist in the current directory, if the
  *pattern* in a `vpath` directive matches the name of the prerequisite
  file, then the *directories* in that directive are searched just like
  (and *before*) the directories in the `VPATH` variable.

[#Selective-Search]

### How Directory Searches are Performed

- The algorithm `make` uses to decide whether to *keep* or *abandon* a
  path found via directory search is as follows:

  1. If a target file does not exist at the path specified in the
     makefile, directory search is performed.

  2. If the directory search is successful, that path is kept and this
     file is tentatively stored as the target.

  3. All prerequisites of this target are examined using this same
     method.

  4. After processing the prerequisites, the target may or may not need
     to be rebuilt:

     1. If the target does *not* need to be rebuilt, the path to the
        file found during directory search is used for any prerequisite
        lists which contain this target.

        In short, if `make` doesn't need to rebuild the target then you
        use the path found via directory search.

     2. If the target *does* need to be rebuilt (is out-of-date), the
        pathname found during directory search is *thrown away*, and the
        target is rebuilt using the file name specified in the makefile.

        In short, if `make` must rebuild, then the target is rebuilt
        locally, not in the directory found via directory search.

- Use `GPATH` variable to use a simpler algorithm of other versions of
  `make`.

  If the file does not exist, and it is found via directory search, then
  that pathname is always used whether or not the target needs to be
  built.

[#Search-Algorithm]

### Writing Recipes with Directory Search

- Just use *automatic variable*s in recipes (`$^`, `$@`, etc.).

[#Recipes_002fSearch]

### Directory Search and Implicit Rules

- The search through the directories specified in `VPATH` or with
  `vpath` also happens during consideration of implicit rules.

[#Implicit_002fSearch]

### Directory Search for Link Libraries

- When a prerequisite's name has the form `-lname`, make handles it
  specially by searching for the file `libname.so`, and, if it is not
  found, for the file `libname.a` in:

  + The current directory,

  + The directories specified by matching `vpath` search paths and

  + The `VPATH` search path,

  + And then in the directories `/lib`, `/usr/lib`, and `prefix/lib`
    (normally `/usr/local/lib`).

- For example, if there is a `/usr/lib/libcurses.a` library on your
  system (and no `/usr/lib/libcurses.so` file), then

    ```makefile
  foo : foo.c -lcurses
          cc $^ -o $@
    ```

  would cause the command `cc foo.c /usr/lib/libcurses.a -o foo` to be
  executed when foo is older than `foo.c` or than
  `/usr/lib/libcurses.a`.

- The default value for `.LIBPATTERNS` is `lib%.so lib%.a`, which
  provides the default behavior described above.

  You can turn off link library expansion completely by setting this
  variable to an empty value.

[#Libraries_002fSearch]

## Phony Targets

- There are two reasons to use a phony target:

  + To avoid a conflict with a file of the same name.

  + To improve performance (the implicit rule search is skipped for
    `.PHONY` targets).

- Phony targets are also useful in conjunction with *recursive*
  invocations of `make`.

  A loop in recipe method is suck:

  + The loop will continue to build the rest of the directories even
    when one fails (`-k` option makes shell exit code handling suck).

  + We cannot take advantage of `make`s ability to build targets in
    *parallel*, since there is only one rule.

- The *phony* sub-directories way:

  ```makefile
  SUBDIRS = foo bar baz

  .PHONY: subdirs $(SUBDIRS)

  subdirs: $(SUBDIRS)

  $(SUBDIRS):
          $(MAKE) -C $@

  foo: baz
  ```

  Here we've also declared that the `foo` sub-directory cannot be built
  until after the `baz` sub-directory is complete; this kind of
  relationship declaration is particularly important when attempting
  *parallel* builds.

[#Phony-Targets]

## Rules without Recipes or Prerequisites

- If a rule has no prerequisites or recipe, and the target of the rule
  *is* a nonexistent file, then make imagines this target to have been
  updated whenever its rule is run.

  This implies that all targets depending on this one will *always* have
  their recipe run.

- An example will illustrate this:

    ```makefile
    clean: FORCE
            rm $(objects)
    FORCE:
    ```

- Using `.PHONY` is more explicit and more efficient.

[#Force-Targets]

## Empty Target Files to Record Events

- The *empty target* is a variant of the *phony target*.

- The purpose of the empty target file is to record, with its
  last-modification time, when the rule's recipe was last executed.

  ```makefile
  print: foo.c bar.c
          lpr -p $?
          touch print
  ```
[#Empty-Targets]

## Special Built-in Target Names

[#Special-Targets]

## Multiple Targets in a Rule

- When an explicit rule has multiple targets they can be treated in one
  of two possible ways:

  + As independent targets.

    * The *colon* (`:`) is standard target separator.

      ```makefile
      bigoutput littleoutput : text.g
              generate text.g -$(subst output,,$@) > $@
      ```

  + As grouped targets.

    * A grouped target rule uses the separator `&:` (the `&` here is
      used to imply "all").

    * When make builds any one of the grouped targets, it understands
      that all the other targets in the group are also created as a
      result of the invocation of the recipe.

      Furthermore, if only some of the grouped targets are out of date
      or missing `make` will realize that running the recipe will update
      all of the targets.

      ```makefile
      foo bar biz &: baz boz
              echo $^ > foo
              echo $^ > bar
              echo $^ > biz
      ```

    * Caution must be used if relying on `$@` variable in the recipe of
      a grouped target rule.

    * A grouped target rule *must* include a recipe.

      - However, targets that are members of a grouped target may also
        appear in independent target rule definitions that do *not* have
        recipes.

      - If a grouped target appears in either an independent target rule
        or in another grouped target rule with a recipe, you will get a
        warning and the *latter* recipe will replace the former recipe.

        Additionally the target will be removed from the previous group
        and appear only in the new group.

      - If you would like a target to appear in multiple groups, then
        you must use the *double-colon grouped target* separator, `&::`.

        Grouped double-colon targets are each considered independently,
        and each grouped double-colon rule's recipe is executed at most
        once, if at least one of its multiple targets requires updating.

[#Multiple-Targets]

## Multiple Rules for One Target

- All the prerequisites mentioned in all the rules are merged into one
  list of prerequisites for the target.

- If more than one rule gives a recipe for the same file, `make` uses
  the last one given and prints an error message.

- Occasionally it is useful to have the same target invoke multiple
  recipes which are defined in different parts of your makefile; you can
  use *double-colon rules* for this.

- The command `make extradeps=foo.h` will consider `foo.h` as a
  prerequisite of each object file, but plain `make` will not:

  ```makefile
  extradeps=
  $(objects) : $(extradeps)
  ```

[#Multiple-Rules]

## Static Pattern Rules

- It's just a *pattern rule* but it is limited in a list provided by
  `targets`.

[#Static-Pattern]

### Syntax of Static Pattern Rules

- Here is the syntax of a *static pattern rule*:

  ```makefile
  targets ... : target-pattern: prereq-patterns ...
          recipe
          ...
  ```

- Again, the `targets` list specifies the targets that the rule applies
  to.

  Each target is matched against the `target-pattern` to extract a part
  of the target name, called the *stem*.

  The prerequisite names for each target are made by substituting the
  stem for the `%` in each *prerequisite pattern*.

- Each target specified *must* match the target pattern; a warning is
  issued for each target that does not (use `filter` function).

- Another example shows how to use `$*` in static pattern rules:

  ```makefile
  bigoutput littleoutput : %output : text.g
          generate text.g -$* > $@
  ```

[#Static-Usage]

### Static Pattern Rules versus Implicit Rules

- The difference is in how `make` decides *when* the rule applies.

  1. An implicit rule *can* apply to any target that matches its
     pattern, but it *does* apply only when the target has no recipe
     otherwise specified, and *only* when the prerequisites can be
     found.

     If more than one implicit rule appears applicable, *only* one
     applies; the choice depends on the *order* of rules.

  2. By contrast, a static pattern rule applies to the precise list of
     targets that you specify in the rule. It cannot apply to any other
     target and it invariably does apply to each of the targets
     specified.

     If two conflicting rules apply, and both have recipes, that's an
     error.

- The static pattern rule can be *better* than an implicit rule for
  these reasons:

  + You may wish to override the usual implicit rule for a few files
    whose names cannot be categorized syntactically but can be given in
    an explicit list.

  + If you cannot be sure of the precise contents of the directories you
    are using, you may not be sure which other irrelevant files might
    lead `make` to use the wrong implicit rule. The choice might depend
    on the order in which the implicit rule search is done.

    With static pattern rules, there is no uncertainty: each rule
    applies to precisely the targets specified.

[#Static-versus-Implicit]

## Double-Colon Rules

- When a target appears in multiple rules, all the rules must be the
  same type: all ordinary, or all double-colon.

  Each double-colon rule is processed individually, just as rules with
  different targets are processed.

- If there are no prerequisites for that rule, its recipe is always
  executed (even if the target already exists).

- The double-colon rules for a target are executed in the order they
  appear in the makefile.

- They provide a mechanism for cases in which the method used to update
  a target differs depending on which prerequisite files caused the
  update, and such cases are rare.

- Each double-colon rule should specify a recipe; if it does not, an
  implicit rule will be used if one applies.

[#Double_002dColon]

## Generating Prerequisites Automatically

[#Automatic-Prerequisites]

# Writing Recipes in Rules

- Recipes in makefiles are always interpreted by `/bin/sh` unless the
  makefile specifies otherwise.

[#Recipes]

## Recipe Syntax

- Makefiles have the unusual property that there are really two distinct
  syntaxes in one file:

  + Most of the makefile uses *`make` syntax*.

  + However, recipes are meant to be interpreted by the shell and so
    they are written using *shell syntax*.

    `make` performs only a very few specific translations on the content
    of the recipe before handing it to the shell.

- A "*rule context*" that is, after a rule has been started until
  another rule or variable definition.

- Some consequences of these rules include:

  + A blank line that begins with a tab is *not* blank: it is an
    *empty recipe* (see [Using Empty Recipes]).

  + A comment in a recipe is not a `make` comment; it will be passed to
    the shell as-is. Whether the shell treats it as a comment or not
    depends on your shell.

  + A variable definition in a "*rule context*" which is indented by a
    tab as the first character on the line, will be considered part of
    a recipe, not a `make` variable definition, and passed to the
    shell.

  + A conditional expression (`ifdef`, `ifeq`, etc. see [Syntax of
    Conditionals]) in a "*rule context*" which is indented by a tab as
    the first character on the line, will be considered part of a
    recipe and be passed to the shell.

[#Recipe-Syntax]

### Splitting Recipe Lines

- Both the backslash and the newline characters are *preserved* and
  passed to the shell.

- Sometimes you want to split a long line inside of single quotes, but
  you don't want the backslash/newline to appear in the quoted content.

  You use `make` variables:

  ```makefile
  HELLO = 'hello \
           world'

  all : ; @echo $(HELLO)
  ```

[#Splitting-Recipe-Lines]

### Using Variables in Recipes

- The expansion occurs after make has finished reading all the makefiles
  and the target is determined to be out of date.

  So, the recipes for targets which are not rebuilt are never expanded.

- Whether the variable you want to reference is a `make` variable (use a
  single dollar sign) or a shell variable (use two dollar signs). For
  example:

  ```makefile
  LIST = one two three
  all:
          for i in $(LIST); do \
              echo $$i; \
          done
  ```

[#Variables-in-Recipes]

## Recipe Echoing

- Normally `make` prints each line of the recipe before it is executed.

- When a line starts with `@`, the echoing of that line is suppressed.

- The `-s` or `--silent` flag to make prevents all echoing, as if all
  recipes started with `@`.

  A rule in the makefile for the special target `.SILENT` without
  prerequisites has the same effect.

[#Echoing]

## Recipe Execution

- When it is time to execute recipes to *update a target*, they are
  executed by invoking a new sub-shell for  *each*  line of the recipe,
  unless the `.ONESHELL` special target is in effect (In practice,
  `make` may take shortcuts that do not affect the results).

- We can use shell AND operator (`&&`):

  ```makefile
  foo : bar/lose
          cd $(<D) && gobble $(<F) > ../$@
  ```

[#Execution]

### Using One Shell

- There are generally two situations where this is useful:

  + First, it can improve performance in makefiles where recipes consist
    of many command lines, by avoiding extra processes.

  + Second, you might want newlines to be included in your recipe
    command (for example perhaps you are using a very different
    interpreter as your SHELL).

-  If the `.ONESHELL` special target appears anywhere in the makefile
   then *all* recipe lines for *each* target will be provided to a
   single invocation of the shell.

   Newlines between recipe lines will be preserved.

   For example:

   ```makefile
   .ONESHELL:
   foo : bar/lose
           cd $(@D)
           gobble $(@F) > ../$@
   ```

- If `.ONESHELL` is provided, then *only* the first line of the recipe
  will be checked for the special prefix characters (`@`, `-`, and `+`).

- If you want your recipe to start with one of these special characters
  you'll need to arrange for them to not be the first characters on the
  first line, perhaps by adding a comment or similar.

  ```makefile
  .ONESHELL:
  SHELL = /usr/bin/perl
  .SHELLFLAGS = -e
  show :
          # Make sure "@" is not the first character
          # on the first line
          @f = qw(a b c);
          print "@f\n";
  ```

- As a special feature, if SHELL is determined to be a *POSIX-style
  shell*, the special prefix characters in "internal" recipe lines will
  be *removed* before the recipe is processed.

  This feature is intended to allow existing makefiles to add the
  `.ONESHELL` special target and still run properly without extensive
  modifications.

  ```makefile
  .ONESHELL:
  foo : bar/lose
          @cd $(@D)
          @gobble $(@F) > ../$@
  ```

- Even with this special feature, however, makefiles with `.ONESHELL`
  will behave differently in ways that could be noticeable.

- For example, normally if any line in the recipe fails, that causes the
  rule to fail and no more recipe lines are processed.

  Under `.ONESHELL` a failure of any but the final recipe line will not
  be noticed by make.

  You can modify `.SHELLFLAGS` to add the `-e` option to the shell which
  will cause any failure anywhere in the command line to cause the shell
  to fail, but this could itself cause your recipe to behave
  differently.

- Ultimately you may need to *harden* your recipe lines to allow them to
  work with `.ONESHELL`.

[#One-Shell]

### Choosing the Shell

- The program used as the shell is taken from the variable `SHELL`.

  If this variable is not set *in your makefile*, the program `/bin/sh`
  is used as the shell.

- The argument(s) passed to the shell are taken from the variable
  `.SHELLFLAGS`.

  The default value of `.SHELLFLAGS` is `-c` normally, or `-ec` in
  POSIX-conforming mode.

- Unlike most variables, the variable `SHELL` is *never* set from the
  *environment*.

- Furthermore, when you do set `SHELL` in your makefile that value is
  *not* exported in the environment to recipe lines that `make` invokes?

- Choosing a Shell in DOS and Windows.

[#Choosing-the-Shell]

## Parallel Execution

- If the `-j` option is followed by an integer, this is the number of
  recipes to execute at once; this is called the number of *job slots*.

  If there is nothing looking like an integer after the `-j` option,
  there is no limit on the number of job slots.

  The default number of job slots is one, which means serial execution
  (one thing at a time).

- You can inhibit parallelism in a particular makefile with the
  `.NOTPARALLEL` pseudo-target.

- On MS-DOS, the `-j` option has no effect, since that system doesn't
  support multi-processing.

- Handling recursive make invocations raises issues for parallel
  execution.

- When make goes to start up a job, and it already has at least one job
  running, it checks the current *load average*; if it is not lower than
  the limit given with `-l` or `--max-load`, make waits until the load
  average goes below that limit, or until all the other jobs finish.

  By default, there is no load limit.

[#Parallel]

### Output During Parallel Execution

- There are four levels of granularity when synchronizing output,
  specified by giving an argument to the option `-O` or `--output-sync`
  (see `make` manpage).

  The `line` mode can be useful for front-ends that are watching the
  output of `make` to track when recipes are started and completed.

[#Parallel-Output]

### Input During Parallel Execution

- To make sure that only one recipe tries to take input from the
  terminal at once, make will invalidate the standard input streams of
  all but one running recipe.

  If another recipe attempts to read from standard input it will usually
  incur a fatal error (a `Broken pipe` signal).

- You should not rely on any recipe using standard input at all if you
  are using the *parallel* execution feature.

[#Parallel-Input]

## Errors in Recipes

- If there is an error (the exit status is nonzero), make gives up on
  the current rule, and perhaps on all rules.

- To ignore errors in *a* recipe line, write a `-` at the beginning of
  the line's text (after the initial tab).

  ```makefile
  clean:
          -rm -f *.o
  ```

- When you run make with the `-i` or `--ignore-errors` flag, errors are
  ignored in all recipes of all rules.

  A rule in the makefile for the special target `.IGNORE` has the same
  effect, if there are no prerequisites.

- If the `-k` or `--keep-going` flag is specified, make continues to
  consider the other prerequisites of the pending targets, remaking them
  if necessary, before it gives up and returns nonzero status.

  The real purpose is to test as many of the changes made in the program
  as possible, perhaps to find several independent problems so that you
  can correct them all before the next attempt to compile.

- Usually when a recipe line fails, if it has changed the target file at
  all, the file is corrupted and cannot be used-or at least it is not
  completely updated. Yet the file's time stamp says that it is now up
  to date, so the next time make runs, it will not try to update that
  file. The situation is just the same as when the shell is killed by a
  signal.

  So generally the right thing to do is to delete the target file if the
  recipe fails after beginning to change the file.

  `make` will do this if `.DELETE_ON_ERROR` appears as a target. This is
  almost always what you want make to do, but it is not historical
  practice; so for compatibility, you must explicitly request it.

[#Errors]

## Interrupting or Killing `make`

- If make gets a fatal signal while a shell is executing, it may delete
  the target file that the recipe was supposed to update.

  This is done if the target file's last-modification time has changed
  since make first checked it.

- You can prevent the deletion of a target file in this way by making
  the special target `.PRECIOUS` depend on it.

  Some reasons why you might do this are that the target is updated in
  some atomic fashion, or exists only to record a modification-time (its
  contents do not matter), or must exist at all times to prevent other
  sorts of trouble.

- It's best to write *defensive recipe*s, which won't leave behind
  corrupted targets even if they fail. Most commonly these recipes
  create temporary files rather than updating the target directly, then
  rename the temporary file to the final target name.

  Some compilers already behave this way, so that you don't need to
  write a defensive recipe.

[#Interrupts]

## Recursive Use of `make`

```makefile
ubsystem:
        # They are equivalent
        cd subdir && $(MAKE)
        $(MAKE) -C subdir
```

- If you include files from other directories the value of `CURDIR` does
  *not* change.

  The value has the same precedence it would have if it were set in the
  makefile (by default, an environment variable `CURDIR` will not
  override this value)?

[#Recursion]

### How the `MAKE` Variable Works

- Recursive make commands should always use the variable `MAKE`, not the
  explicit command name `make`, as shown here:

  ```makefile
  subsystem:
          cd subdir && $(MAKE)
  ```

- As a special feature, whenever a recipe line of a rule contains the
  variable `MAKE`, the flags `-t` (`--touch`), `-n` (`--just-print`), or
  `-q` (`--question`) do *not* apply to that line.

  Same effect as using a `+` character at the beginning of the recipe
  line.

  If you don't "`make` recursive" how can you "touch"?

  The usual definition of `-t`, a `make -t` command in the example would
  create a file named `subsystem` and do nothing else.

- The usual `MAKEFLAGS` mechanism passes the flags to the sub-`make`
  (see [Communicating Options to a Sub-`make`]), so your request to
  touch the files, or print the recipes, is propagated to the subsystem.

[#MAKE-Variable]

### Communicating Variables to a Sub-`make`

- Environment variables are defined in the sub-`make` as defaults, but
  they do not override variables defined in the makefile used by the
  sub-`make` unless you use the `-e` switch.

- Except by explicit request, `make` exports a variable only if it is
  either defined in the environment *initially* or set on the command
  line, and if its name consists only of letters, numbers, and
  underscores.

- The value of the `make` variable `SHELL` is not exported. Instead, the
  value of the `SHELL` variable from the invoking environment is passed
  to the sub-`make`.

- The special variable `MAKEFLAGS` is always exported (unless you
  `unexport` it). `MAKEFILES` is exported if you set it to anything.

- `make` automatically passes down variable values that were defined on
  the command line, by putting them in the `MAKEFLAGS` variable. See
  [Communicating Options to a Sub-`make`].

- Variables are *not* normally passed down if they were created by
  default by `make` (see [Variables Used by Implicit Rules]). The
  sub-`make` will define these for itself.

- `export` and `unexport` example:

  ```makefile
  export variable ...
  unexport variable ...
  ```

  In both of these forms, the arguments to `export` and `unexport` are
  expanded, and so could be variables or functions which expand to a
  (list of) variable names to be (un)exported.

- Only `export` directive tells `make` that variables which are not
  explicitly mentioned in an `export` or `unexport` directive should be
  exported.

  Variables whose names contain characters other than alphanumerics and
  underscores will not be exported unless specifically mentioned in an
  `export` directive.

- Compatibility with older version GNU `make`: write a rule for special
  target `.EXPORT_ALL_VARIABLES` instead of `export`.

- The main use of `MAKELEVEL` is to test it in a conditional directive
  (see [Conditional Parts of Makefiles]); this way you can write a
  makefile that behaves one way if run recursively and another way if
  run directly by you.

  The value of `MAKELEVEL` is '`0`' for the top-level `make`; '`1`' for
  a sub-`make`, '`2`' for a sub-sub-`make`, and so on.

- Passing variables on the command line overrides assignments in the
  sub-makefile but exported variables do not override assignments in the
  sub-makefile. These two methods for passing variables to a
  sub-makefile are not equivalent and should not be confused.
  [Jonathan's
  comment](https://stackoverflow.com/questions/2826029/passing-additional-variables-from-command-line-to-make/2826178#comment51986622_2826178)

- `make` command line variable override environment variables and
  variables within makefile (unless `override` directive).

  Command line variables are environment variables.

[#Variables_002fRecursion]

### Communicating Options to a Sub-`make`

- Flags such as '`-s`' and '`-k`' are passed automatically to the
  sub-`make` through the variable `MAKEFLAGS`.

  This variable is set up automatically by `make` to contain the flag
  letters that `make` received. Thus, if you do '`make -ks`' then
  `MAKEFLAGS` gets the value '`ks`'.

- Words in the value of `MAKEFLAGS` that contain '`=`', `make` treats as
  variable definitions just as if they appeared on the command line. See
  [Overriding Variables].

- The options '`-C`{.sample}', '`-f`{.sample}', '`-o`{.sample}', and
  '`-W`{.sample}' are not put into `MAKEFLAGS`; these options are not
  passed down.

- If you do not want to pass the other flags down, you must change the
  value of `MAKEFLAGS`, like this:

  ```makefile
  subsystem:
          cd subdir && $(MAKE) MAKEFLAGS=
  ```

- The command line variable *definitions* really appear in the variable
  `MAKEOVERRIDES`, and `MAKEFLAGS` contains a *reference* to this
  variable.

  If you do want to pass flags down normally, but don't want to pass
  down the command line variable definitions, you can reset
  `MAKEOVERRIDES` to empty, like this:

  ```makefile
  MAKEOVERRIDES =
  ```

- Correct way to use `MAKEFILES`, `MFLAGS`, and `GNUMAKEFILES`.

[#Options_002fRecursion]

### The `--print-directory` Option

[#g_t_002dw-Option]

## Defining Canned Recipes

- In recipe execution, each line of a canned sequence is treated just as
  if the line appeared on its own in the rule, preceded by a tab.

- You can use the special prefix characters that affect command lines
  ('`@`', '`-`', and '`+`') on each line of a canned sequence. See
  [Writing Recipes in Rules].

  For example, using this canned sequence:

  ```makefile
  define frobnicate =
  @echo "frobnicating target $@"
  frob-step-1 $< -o $@-step-1
  frob-step-2 $@-step-1 -o $@
  endef
  ```
- On the other hand, prefix characters on the recipe line that refers to a
  canned sequence apply to every line in the sequence:

  ```makefile
  frob.out: frob.in
          @$(frobnicate)
  ```

[#Canned-Recipes]

## Using Empty Recipes

- Example:

  ```makefile
  target: ;
  ```

- One reason this is useful is to prevent a target from getting implicit
  recipes (from implicit rules or the `.DEFAULT` special target; see
  [Implicit Rules] and see [Defining Last-Resort Default Rules]).

- Empty recipes can also be used to avoid errors for targets that will
  be created as a side-effect of another recipe: if the target does not
  exist the empty recipe ensures that `make` won't complain that it
  doesn't know how to build the target, and `make` will assume the
  target is out of date.

- You may be inclined to define empty recipes for targets that are not
  actual files, but only exist so that their prerequisites can be
  remade.

  However, this is not the best way to do that, because the
  prerequisites may not be remade properly if the *target* file actually
  does exist.

[#Empty-Recipes]

# How to Use Variables

- Variables and functions in all parts of a makefile are expanded when
  read, *except* for:

  + In recipes,

  + The right-hand sides of variable definitions using '`=`', and

  + The bodies of variable definitions using the `define` directive.

- A variable name may be any sequence of characters not containing
  '`:`', '`#`', '`=`', or whitespace.

  However, variable names containing characters other than letters,
  numbers, and underscores should be considered carefully, as in some
  shells they cannot be passed through the environment to a sub-`make`.

- Variable names are case-sensitive.

- It is traditional to use upper case letters in variable names, but we
  recommend using lower case letters for variable names that serve
  internal purposes in the makefile, and reserving upper case for
  parameters that control implicit rules or for parameters that the user
  should override with command options (see [Overriding
  Variables]).

[#Using-Variables]

## Basics of Variable References

[#Reference]

## The Two Flavors of Variables

The two flavors are distinguished in how they are defined and in what
they do when expanded.

### Recursively Expanded Variables

Variables of this sort are defined by lines using '`=`' (see [Setting
Variables]) or by the `define` directive (see [Defining Multi-Line
Variables]).

The value you specify is installed *verbatim*; if it contains
*references* to other variables, these references are expanded whenever
this variable is substituted (in the course of expanding some other
string).

- Advantage:

  ```makefile
  CFLAGS = $(include_dirs) -O
  include_dirs = -Ifoo -Ibar
  ```

  will do what was intended: when '`CFLAGS`' is expanded in a recipe, it
  will expand to '`-Ifoo -Ibar -O`'.

- Disadvantages:

  + A major disadvantage is that you cannot append something on the end
    of a variable, as in

    ```makefile
    CFLAGS = $(CFLAGS) -O
    ```

    because it will cause an infinite loop in the variable expansion.
    (Actually `make` detects the infinite loop and reports an error.)

  + Another disadvantage is that any functions (see [Functions for
    Transforming Text]) referenced in the definition will be executed
    *every* time the variable is expanded.

    This makes `make` run slower; worse, it causes the `wildcard` and
    `shell` functions to give unpredictable results because you cannot
    easily control when they are called, or even *how many times*.

### Simply Expanded Variables

- *Simply expanded variables* are defined by lines using '`:=`' or
  '`::=`' (see [Setting Variables]).

  Both forms are equivalent in GNU `make`; however only the '`::=`' form
  is described by the POSIX standard (support for '`::=`' was added to
  the POSIX standard in 2012, so older versions of `make` won't accept
  this form either).

- The value of a simply expanded variable is scanned once and for all,
  expanding any references to other variables and functions, when the
  variable is defined.

- The actual value of the simply expanded variable is the result of
  expanding the text that you write. It does not contain any references
  to other variables; it contains their values *as of the time this
  variable was defined*.

- You can include leading spaces in a variable value by protecting them
  with variable references, like this:

  ```makefile
  nullstring :=
  space := $(nullstring) # end of the line
  ```

  The comment '`# end of the line`' is included here just for clarity.

[#Flavors]

## Advanced Features for Reference to Variables

[#Advanced]

### Substitution References

- It has the form '`$(var:a=b)`' (or '`$`') and its meaning is to take
  the value of the variable `var`, replace every `a` *at the end* of a
  word with `b` in that value, and substitute the resulting string.

  ```makefile
  foo := a.o b.o l.a c.o
  bar := $(foo:.o=.c)
  ```

  A substitution reference is shorthand for the `patsubst` expansion
  function (see [Functions for String Substitution and Analysis]):
  '`$(var:a=b)`' is equivalent to '`$(patsubst %a,%b,var)`'.

- Another type of substitution reference lets you use the full power of
  the `patsubst` function.

  ```makefile
  foo := a.o b.o l.a c.o
  bar := $(foo:%.o=%.c)
  ```

[#Substitution-Refs]

### Computed Variable Names

- Variables may be *referenced* inside the *name* of a variable. This is
  called a *computed variable name* or a *nested variable reference*.
  For example,

  ```makefile
  x = y
  y = z
  a := $($(x))
  ```

  defines `a` as '`z`': the '`$(x)`' inside '`$($(x))`' expands to
  '`y`', so '`$($(x))`' expands to '`$(y)`' which in turn expands to
  '`z`'.

  Here the name of the variable to reference is not stated explicitly; it
  is *computed* by expansion of '`$(x)`'.

- The previous example shows two levels of nesting, but any number of
  levels is possible. For example, here are three levels:

  ```makefile
  x = y
  y = z
  z = u
  a := $($($(x)))
  ```

- References to recursively-expanded variables within a variable name
  are re-expanded in the usual fashion. For example:

  ```makefile
  x = $(y)
  y = z
  z = Hello
  a := $($(x))
  ```

  defines `a` as '`Hello`': '`$($(x))`' **becomes** '`$($(y))`' which
  becomes '`$(z)`' which becomes '`Hello`'.

- Nested variable references can also contain modified references and
  function invocations, just like any other reference.

  ```makefile
  x = variable1
  variable2 := Hello
  y = $(subst 1,2,$(x))
  z = y
  a := $($($(z)))
  ```

  eventually defines `a` as '`Hello`': '`$($($(z)))`' expands to
  '`$($(y))`' which becomes '`$($(subst 1,2,$(x)))`'. This gets the
  value '`variable1`' from `x` and changes it by substitution to
  '`variable2`', so that the entire string becomes '`$(variable2)`', a
  simple variable reference whose value is '`Hello`'.

- The only *restriction* on this sort of use of nested variable
  references is that they cannot specify part of the name of a function
  to be called.

  This is because the test for a recognized function name is done
  *before* the expansion of nested references. For example,

  ```makefile
  ifdef do_sort
  func := sort
  else
  func := strip
  endif

  bar := a d b g q c

  foo := $($(func) $(bar))
  ```

  attempts to give '`foo`' the value of the variable '`sort a d b g q
  c`' or '`strip a d b g q c`', rather than giving '`a d b g q c`' as
  the argument to either the `sort` or the `strip` function.

  This restriction could be removed in the future if that change is
  shown to be a good idea.

- You can also use computed variable names in the *left-hand side* of a
  variable assignment, or in a `define` directive, as in:

  ```makefile
  dir = foo
  $(dir)_sources := $(wildcard $(dir)/*.c)
  define $(dir)_print =
  lpr $($(dir)_sources)
  endef
  ```

[#Computed-Names]

## How Variables Get Their Values

Variables can get values in several different ways:

- You can specify an overriding value when you run `make`. See
  [Overriding Variables].

- You can specify a value in the makefile, either with an assignment
  (see [Setting Variables]) or with a verbatim definition (see [Defining
  Multi-Line Variables]).

- Variables in the environment become `make` variables. See [Variables
  from the Environment].

- Several *automatic* variables are given new values for each rule. Each
  of these has a single conventional use. See [Automatic Variables].

- Several variables have constant initial values. See [Variables Used by
  Implicit Rules].

[#Values]

## Setting Variables

- There is no limit on the length of the value of a variable except the
  amount of memory on the computer.

- If you'd like a variable to be set to a value *only* if it's not
  already set, then you can use the shorthand operator '`?=`' instead of
  '`=`'.

  These two settings of the variable '`FOO`' are identical:

  ```makefile
  FOO ?= bar
  ```

  and

  ```makefile
  ifeq ($(origin FOO), undefined)
  FOO = bar
  endif
  ```

- The *shell assignment operator* '`!=`' can be used to execute a shell
  script and set a variable to its output.

  This operator first evaluates the right-hand side, then passes that
  result to the shell for execution.

  If the result of the execution ends in a newline, that one newline is
  removed; all other newlines are replaced by spaces.

  The resulting string is then placed into the named
  *recursively-expanded variable*. For example:

  ```makefile
  hash != printf '\043'
  file_list != find . -name '*.c'
  ```

- If the result of the execution could produce a `$`, and you don't
  intend what follows that to be interpreted as a make variable or
  function reference, then you must replace every `$` with `$$` as part
  of the execution.

  Alternatively, you can set a simply expanded variable to the result of
  running a program using the `shell` function call. For example:

  ```makefile
  hash := $(shell printf '\043')
  var := $(shell find . -name "*.c")
  ```

  As with the `shell` function, the exit status of the just-invoked shell
  script is stored in the `.SHELLSTATUS` variable.

[#Setting]

## Appending More Text to Variables

- When the variable in question has not been defined before, '`+=`' acts
  just like normal '`=`': it defines a recursively-expanded variable.

  However, when there *is* a previous definition, exactly what '`+=`'
  does depends on what flavor of variable you defined originally.

  In fact,

  ```makefile
  variable := value
  variable += more
  ```

  is exactly equivalent to:

  ```makefile
  variable := value
  variable := $(variable) more
  ```

  And

  ```makefile
  variable = value
  variable += more
  ```

  is roughly equivalent to:

  ```makefile
  temp = value
  variable = $(temp) more
  ```

[#Appending]

## The `override` Directive

- If a variable has been set with a command argument (see [Overriding
  Variables]), then ordinary assignments in the makefile are *ignored*.

  If you want to set the variable in the makefile even though it
  was set with a command argument, you can use an `override` directive,
  which is a line that looks like this:

  ```makefile
  override variable = value
  ```

  or

  ```makefile
  override variable := value
  ```

  To append more text to a variable defined on the command line, use:

  ```makefile
  override variable += more text
  ```

- Variable assignments marked with the `override` flag have a higher
  priority than all other assignments, *except* another `override`.

  *Subsequent* assignments or appends to this variable which are not
  marked `override` will be *ignored*.

- The `override` directive was not invented for escalation in the war
  between makefiles and command arguments.

  It was invented so you can *alter* and *add* to values that the user
  specifies with command arguments.

- You can also use `override` *directive*s with `define` directives.
  This is done as you might expect:

  ```makefile
  override define foo =
  bar
  endef
  ```

[#Override-Directive]

## Defining Multi-Line Variables

- This directive has an unusual syntax which allows newline characters
  to be included in the value, which is convenient for defining both
  canned sequences of commands (see [Defining Canned Recipes]), and also
  sections of makefile syntax to use with `eval`.

- The `define` directive works just like any other variable definition.

  The variable name may contain *function* and *variable references*,
  which are expanded when the directive is read to find the actual
  variable name to use.

- The final newline before the `endef` is not included in the value; in
  order to define a variable that contains a newline character you must
  use *two* empty lines, not one:

  ```makefile
  define newline


  endef
  ```
- You may omit the variable assignment operator if you prefer.

  If omitted, `make` assumes it to be '`=`' and creates a
  recursively-expanded variable (see [The Two Flavors of Variables]).

- You may nest `define` directives: `make` will keep track of nested
  directives and report an error if they are not all properly closed
  with `endef`.

  Note that lines beginning with the recipe prefix character are
  considered part of a recipe, so any `define` or `endef` strings
  appearing on such a line will not be considered `make` directives.

  ```makefile
  define two-lines
  echo foo
  echo $(bar)
  endef
  ```

  When used in a recipe, the previous example is functionally equivalent
  to this:

  ```makefile
  two-lines = echo foo; echo $(bar)
  ```

  since two commands separated by semicolon behave much like two
  separate shell commands.

[#Multi_002dLine]

## Undefining Variables

- If you want to clear a variable, setting its value to empty is usually
  sufficient.

  Expanding such a variable will yield the same result (empty string)
  regardless of whether it was set or not.

  However, if you are using the `flavor` (see [Flavor Function]) and
  `origin` (see [Origin Function]) functions, there is a difference
  between a variable that was never set and a variable with an empty
  value.

  In such situations you may want to use the `undefine` directive to
  make a variable appear as if it was never set. For example:

  ```makefile
  foo := foo
  bar = bar

  undefine foo
  undefine bar

  $(info $(origin foo))
  $(info $(flavor bar))
  ```

  This example will print "undefined" for both variables.

- If you want to undefine a command-line variable definition, you can
  use the `override` directive together with `undefine`, similar to how
  this is done for variable definitions:

  ```makefile
  override undefine CFLAGS
  ```

[#Undefine-Directive]

## Variables from the Environment

- Every environment variable that `make` sees when it starts up is
  transformed into a `make` variable with the same name and value.

  However, an explicit assignment in the makefile, or with a command
  argument, overrides the environment. (If the '`-e`' flag is specified,
  then values from the environment override assignments in the makefile.
  But this is not recommended practice.)

- When `make` runs a recipe, variables defined in the makefile are
  placed into the environment of each shell. This allows you to pass
  values to sub-`make` invocations (see [Recursive Use of `make`]).

  By default, only variables that came from the environment or the
  command line are passed to recursive invocations. You can use the
  `export` directive to pass other variables. See [Communicating
  Variables to a Sub-`make`], for full details.

[#Environment]

## Target-specific Variable Values

- This feature allows you to define different values for the same
  variable, based on the target that `make` is currently building.

  As with automatic variables, these values are only available within
  the context of a target's recipe (and in other target-specific
  assignments).

  Set a target-specific variable value like this:

  ```makefile
  target … : variable-assignment
  ```

- Multiple `target` values create a target-specific variable value for
  each member of the target list individually.

- All variables that appear within the `variable-assignment` are
  evaluated within the context of the target: thus, any
  previously-defined target-specific variable values will be in effect.

  Note that this variable is actually distinct from any "global" value:
  the two variables do not have to have the same *flavor* (recursive vs.
  simple).

- There is one more special feature of target-specific variables: when
  you define a target-specific variable that variable value is also in
  effect for all prerequisites of this target, and all their
  prerequisites, etc. (unless those prerequisites override that variable
  with their own target-specific variable value).

- Be aware that a given prerequisite will only be built once per
  invocation of make, at most.

  If the same file is a prerequisite of multiple targets, and each of
  those targets has a different value for the same target-specific
  variable, then the first target to be built will cause that
  prerequisite to be built and the prerequisite will inherit the
  target-specific value from the first target.

[#Target_002dspecific]

## Pattern-specific Variable Values

- If a target matches more than one pattern, the matching
  pattern-specific variables with longer *stems* are interpreted first.

  This results in more specific variables taking precedence over the
  more generic ones, for example:

  ```makefile
  %.o: %.c
          $(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

  lib/%.o: CFLAGS := -fPIC -g
  %.o: CFLAGS := -g

  all: foo.o lib/bar.o
  ```

- In this example the first definition of the `CFLAGS` variable will be
  used to update `lib/bar.o` even though the second one also applies to
  this target.

  Pattern-specific variables which result in the same stem length are
  considered in the order in which they were defined in the makefile.

- Pattern-specific variables are searched after any target-specific
  variables defined explicitly for that target, and before
  target-specific variables defined for the parent target.

[#Pattern_002dspecific]

## Suppressing Inheritance

- Sometimes, however, you may not want a variable to be inherited. For
  these situations, `make` provides the `private` modifier.

  Although this modifier can be used with any variable assignment, it
  makes the most sense with target- and pattern-specific variables.

- Any variable marked `private` will be visible to its local target but
  will not be inherited by prerequisites of that target.

  A global variable marked `private` will be visible in the global scope
  but will not be inherited by any target, and hence will not be visible
  in any recipe.

- As an example, consider this makefile:

  ```makefile
  EXTRA_CFLAGS =

  prog: private EXTRA_CFLAGS = -L/usr/local/lib
  prog: a.o b.o
  ```

  Due to the `private` modifier, `a.o` and `b.o` will not inherit the
  `EXTRA_CFLAGS` variable assignment from the `prog` target.

[#Suppressing-Inheritance]

## Other Special Variables

[#Special-Variables]

# Conditional Parts of Makefiles

[#Conditionals]

## Example of a Conditional

- As this example illustrates, conditionals work at the textual level:
  the lines of the conditional are treated as part of the makefile, or
  ignored, according to the condition.

- This is why the larger syntactic units of the makefile, such as rules,
  may cross the beginning or the end of the conditional.

[#Conditional-Example]

## Syntax of Conditionals

- There are four different directives that test different conditions.
  Here is a table of them:

  ```makefile
  ifeq (arg1, arg2)
  ifeq 'arg1' 'arg2'
  ifeq "arg1" "arg2"
  ifeq "arg1" 'arg2'
  ifeq 'arg1' "arg2"
  ```

- `ifdef` conditional:

  ```makefile
  ifdef variable-name
  ```

  The `ifdef` form takes the *name* of a variable as its argument, not a
  reference to a variable.

  If the value of that variable has a non-empty value, the
  `text-if-true` is effective; otherwise, the `text-if-false`, if any,
  is effective. Variables that have never been defined have an empty
  value.

  The text `variable-name` is expanded, so it could be a variable
  or function that expands to the name of a variable. For example:

  ```makefile
  bar = true
  foo = bar
  ifdef $(foo)
  frobozz = yes
  endif
  ```

  The variable reference `$(foo)` is expanded, yielding `bar`, which
  is considered to be the name of a variable. The variable `bar` is
  not expanded, but its value is examined to determine if it is
  non-empty.

  Note that `ifdef` only tests whether a variable has a value. It does
  not expand the variable to see if that value is nonempty.

  Consequently, tests using `ifdef` return true for all definitions
  except those like `foo =`. To test for an empty value, use
  `ifeq ($(foo),)`. For example,

  ```makefile
  bar =
  foo = $(bar)
  ifdef foo
  frobozz = yes
  else
  frobozz = no
  endif
  ```

  sets '`frobozz`' to '`yes`', while:

  ```makefile
  foo =
  ifdef foo
  frobozz = yes
  else
  frobozz = no
  endif
  ```

  sets '`frobozz`' to '`no`'.

- `make` evaluates conditionals when it reads a makefile.

  Consequently, you cannot use automatic variables in the tests of
  conditionals because they are not defined until recipes are run (see
  [Automatic Variables]).

[#Conditional-Syntax]

## Conditionals that Test Flags

- For example, here is how to arrange to use '`ranlib -t`' to finish
  marking an archive file up to date:

  ```makefile
  archive.a: …
  ifneq (,$(findstring t,$(MAKEFLAGS)))
          +touch archive.a
          +ranlib -t archive.a
  else
          ranlib archive.a
  endif
  ```

  The '`+`' prefix marks those recipe lines as "recursive" so that they
  will be executed despite use of the '`-t`' flag. See [Recursive Use of
  `make`].

[#Testing-Flags]

# Functions for Transforming Text

[#Functions]

## Function Call Syntax

[#Syntax-of-Functions]

## Functions for String Substitution and Analysis

[#Text-Functions]

## Functions for File Names

[#File-Name-Functions]

## Functions for Conditionals

[#Conditional-Functions]

## The `foreach` Function

[#Foreach-Function]

## The `file` Function

[#File-Function]

## The `call` Function

[#Call-Function]

## The `value` Function

[#Value-Function]

## The `eval` Function

[#Eval-Function]

## The `origin` Function

[#Origin-Function]

## The `flavor` Function

[#Flavor-Function]

## Functions That Control Make

[#Make-Control-Functions]

## The `shell` Function

[#Shell-Function]

## The `guile` Function

[#Guile-Function]

# How to Run `make`

[#Running]

## Arguments to Specify the Makefile

[#Makefile-Arguments]

## Arguments to Specify the Goals

[#Goals]

## Instead of Executing Recipes

[#Instead-of-Execution]

## Avoiding Recompilation of Some Files

[#Avoiding-Compilation]

## Overriding Variables

[#Overriding]

## Testing the Compilation of a Program

[#Testing]

## Summary of Options

[#Options-Summary]

# Using Implicit Rules

[#Implicit-Rules]

## Using Implicit Rules

[#Using-Implicit]

## Catalogue of Built-In Rules

[#Catalogue-of-Rules]

## Variables Used by Implicit Rules

[#Implicit-Variables]

## Chains of Implicit Rules

[#Chained-Rules]

## Defining and Redefining Pattern Rules

[#Pattern-Rules]

### Introduction to Pattern Rules

[#Pattern-Intro]

### Pattern Rule Examples

[#Pattern-Examples]

### Automatic Variables

[#Automatic-Variables]

### How Patterns Match

[#Pattern-Match]

### Match-Anything Pattern Rules

[#Match_002dAnything-Rules]

### Canceling Implicit Rules

[#Canceling-Rules]

## Defining Last-Resort Default Rules

[#Last-Resort]

## Old-Fashioned Suffix Rules

[#Suffix-Rules]

## Implicit Rule Search Algorithm

[#Implicit-Rule-Search]

# Using `make` to Update Archive Files

[#Archives]

## Archive Members as Targets

[#Archive-Members]

## Implicit Rule for Archive Member Targets

[#Archive-Update]

### Updating Archive Symbol Directories

[#Archive-Symbols]

## Dangers When Using Archives

[#Archive-Pitfalls]

## Suffix Rules for Archive Files

[#Archive-Suffix-Rules]

# Extending GNU `make`

[#Extending-make]

## GNU Guile Integration

[#Guile-Integration]

### Conversion of Guile Types

[#Guile-Types]

### Interfaces from Guile to `make`

[#Guile-Interface]

### Example Using Guile in `make`

[#Guile-Example]

## Loading Dynamic Objects

[#Loading-Objects]

### The `load` Directive

[#load-Directive]

### How Loaded Objects Are Remade

[#Remaking-Loaded-Objects]

### Loaded Object Interface

[#Loaded-Object-API]

### Example Loaded Object

[#Loaded-Object-Example]

# Integrating GNU `make`

[#Integrating-make]

## Sharing Job Slots with GNU `make`

[#Job-Slots]

### POSIX Jobserver Interaction

[#POSIX-Jobserver]

### Windows Jobserver Interaction

[#Windows-Jobserver]

## Synchronized Terminal Output

[#Terminal-Output]

# Features of GNU `make`

[#Features]

# Incompatibilities and Missing Features

[#Missing]

# Makefile Conventions

[#Makefile-Conventions]

## General Conventions for Makefiles

[#Makefile-Basics]

## Utilities in Makefiles

[#Utilities-in-Makefiles]

## Variables for Specifying Commands

[#Command-Variables]

## `DESTDIR`: Support for Staged Installs

[#DESTDIR]

## Variables for Installation Directories

[#Directory-Variables]

## Standard Targets for Users

[#Standard-Targets]

## Install Command Categories

[#Install-Command-Categories]

# Appendix A Quick Reference

[#Quick-Reference]

# Appendix B Errors Generated by Make

[#Error-Messages]

# Appendix C Complex Makefile Example

[#Complex-Makefile]

# Appendix D GNU Free Documentation License

[#GNU-Free-Documentation-License]

# Index of Concepts

[#Concept-Index]

# Index of Functions, Variables, & Directives

[#Name-Index]

<!----------------- Online link definitions -------------------->

[GNU `make` manual]: https://www.gnu.org/software/make/manual/make.html
[#Overview]: https://www.gnu.org/software/make/manual/make.html#Overview
[#Reading]: https://www.gnu.org/software/make/manual/make.html#Reading
[#Bugs]: https://www.gnu.org/software/make/manual/make.html#Bugs
[#Introduction]: https://www.gnu.org/software/make/manual/make.html#Introduction
[#Rule-Introduction]: https://www.gnu.org/software/make/manual/make.html#Rule-Introduction
[#Simple-Makefile]: https://www.gnu.org/software/make/manual/make.html#Simple-Makefile
[#How-Make-Works]: https://www.gnu.org/software/make/manual/make.html#How-Make-Works
[#Variables-Simplify]: https://www.gnu.org/software/make/manual/make.html#Variables-Simplify
[#make-Deduces]: https://www.gnu.org/software/make/manual/make.html#make-Deduces
[#Combine-By-Prerequisite]: https://www.gnu.org/software/make/manual/make.html#Combine-By-Prerequisite
[#Cleanup]: https://www.gnu.org/software/make/manual/make.html#Cleanup
[#Makefiles]: https://www.gnu.org/software/make/manual/make.html#Makefiles
[#Makefile-Contents]: https://www.gnu.org/software/make/manual/make.html#Makefile-Contents
[#Splitting-Lines]: https://www.gnu.org/software/make/manual/make.html#Splitting-Lines
[#Makefile-Names]: https://www.gnu.org/software/make/manual/make.html#Makefile-Names
[#Include]: https://www.gnu.org/software/make/manual/make.html#Include
[#MAKEFILES-Variable]: https://www.gnu.org/software/make/manual/make.html#MAKEFILES-Variable
[#Remaking-Makefiles]: https://www.gnu.org/software/make/manual/make.html#Remaking-Makefiles
[#Overriding-Makefiles]: https://www.gnu.org/software/make/manual/make.html#Overriding-Makefiles
[#Reading-Makefiles]: https://www.gnu.org/software/make/manual/make.html#Reading-Makefiles
[#Parsing-Makefiles]: https://www.gnu.org/software/make/manual/make.html#Parsing-Makefiles
[#Secondary-Expansion]: https://www.gnu.org/software/make/manual/make.html#Secondary-Expansion
[#Rules]: https://www.gnu.org/software/make/manual/make.html#Rules
[#Rule-Example]: https://www.gnu.org/software/make/manual/make.html#Rule-Example
[#Rule-Syntax]: https://www.gnu.org/software/make/manual/make.html#Rule-Syntax
[#Prerequisite-Types]: https://www.gnu.org/software/make/manual/make.html#Prerequisite-Types
[#Wildcards]: https://www.gnu.org/software/make/manual/make.html#Wildcards
[#Wildcard-Examples]: https://www.gnu.org/software/make/manual/make.html#Wildcard-Examples
[#Wildcard-Pitfall]: https://www.gnu.org/software/make/manual/make.html#Wildcard-Pitfall
[#Wildcard-Function]: https://www.gnu.org/software/make/manual/make.html#Wildcard-Function
[#Directory-Search]: https://www.gnu.org/software/make/manual/make.html#Directory-Search
[#General-Search]: https://www.gnu.org/software/make/manual/make.html#General-Search
[#Selective-Search]: https://www.gnu.org/software/make/manual/make.html#Selective-Search
[#Search-Algorithm]: https://www.gnu.org/software/make/manual/make.html#Search-Algorithm
[#Recipes_002fSearch]: https://www.gnu.org/software/make/manual/make.html#Recipes_002fSearch
[#Implicit_002fSearch]: https://www.gnu.org/software/make/manual/make.html#Implicit_002fSearch
[#Libraries_002fSearch]: https://www.gnu.org/software/make/manual/make.html#Libraries_002fSearch
[#Phony-Targets]: https://www.gnu.org/software/make/manual/make.html#Phony-Targets
[#Force-Targets]: https://www.gnu.org/software/make/manual/make.html#Force-Targets
[#Empty-Targets]: https://www.gnu.org/software/make/manual/make.html#Empty-Targets
[#Special-Targets]: https://www.gnu.org/software/make/manual/make.html#Special-Targets
[#Multiple-Targets]: https://www.gnu.org/software/make/manual/make.html#Multiple-Targets
[#Multiple-Rules]: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
[#Static-Pattern]: https://www.gnu.org/software/make/manual/make.html#Static-Pattern
[#Static-Usage]: https://www.gnu.org/software/make/manual/make.html#Static-Usage
[#Static-versus-Implicit]: https://www.gnu.org/software/make/manual/make.html#Static-versus-Implicit
[#Double_002dColon]: https://www.gnu.org/software/make/manual/make.html#Double_002dColon
[#Automatic-Prerequisites]: https://www.gnu.org/software/make/manual/make.html#Automatic-Prerequisites
[#Recipes]: https://www.gnu.org/software/make/manual/make.html#Recipes
[#Recipe-Syntax]: https://www.gnu.org/software/make/manual/make.html#Recipe-Syntax
[#Splitting-Recipe-Lines]: https://www.gnu.org/software/make/manual/make.html#Splitting-Recipe-Lines
[#Variables-in-Recipes]: https://www.gnu.org/software/make/manual/make.html#Variables-in-Recipes
[#Echoing]: https://www.gnu.org/software/make/manual/make.html#Echoing
[#Execution]: https://www.gnu.org/software/make/manual/make.html#Execution
[#One-Shell]: https://www.gnu.org/software/make/manual/make.html#One-Shell
[#Choosing-the-Shell]: https://www.gnu.org/software/make/manual/make.html#Choosing-the-Shell
[#Parallel]: https://www.gnu.org/software/make/manual/make.html#Parallel
[#Parallel-Output]: https://www.gnu.org/software/make/manual/make.html#Parallel-Output
[#Parallel-Input]: https://www.gnu.org/software/make/manual/make.html#Parallel-Input
[#Errors]: https://www.gnu.org/software/make/manual/make.html#Errors
[#Interrupts]: https://www.gnu.org/software/make/manual/make.html#Interrupts
[#Recursion]: https://www.gnu.org/software/make/manual/make.html#Recursion
[#MAKE-Variable]: https://www.gnu.org/software/make/manual/make.html#MAKE-Variable
[#Variables_002fRecursion]: https://www.gnu.org/software/make/manual/make.html#Variables_002fRecursion
[#Options_002fRecursion]: https://www.gnu.org/software/make/manual/make.html#Options_002fRecursion
[#g_t_002dw-Option]: https://www.gnu.org/software/make/manual/make.html#g_t_002dw-Option
[#Canned-Recipes]: https://www.gnu.org/software/make/manual/make.html#Canned-Recipes
[#Empty-Recipes]: https://www.gnu.org/software/make/manual/make.html#Empty-Recipes
[#Using-Variables]: https://www.gnu.org/software/make/manual/make.html#Using-Variables
[#Reference]: https://www.gnu.org/software/make/manual/make.html#Reference
[#Flavors]: https://www.gnu.org/software/make/manual/make.html#Flavors
[#Advanced]: https://www.gnu.org/software/make/manual/make.html#Advanced
[#Substitution-Refs]: https://www.gnu.org/software/make/manual/make.html#Substitution-Refs
[#Computed-Names]: https://www.gnu.org/software/make/manual/make.html#Computed-Names
[#Values]: https://www.gnu.org/software/make/manual/make.html#Values
[#Setting]: https://www.gnu.org/software/make/manual/make.html#Setting
[#Appending]: https://www.gnu.org/software/make/manual/make.html#Appending
[#Override-Directive]: https://www.gnu.org/software/make/manual/make.html#Override-Directive
[#Multi_002dLine]: https://www.gnu.org/software/make/manual/make.html#Multi_002dLine
[#Undefine-Directive]: https://www.gnu.org/software/make/manual/make.html#Undefine-Directive
[#Environment]: https://www.gnu.org/software/make/manual/make.html#Environment
[#Target_002dspecific]: https://www.gnu.org/software/make/manual/make.html#Target_002dspecific
[#Pattern_002dspecific]: https://www.gnu.org/software/make/manual/make.html#Pattern_002dspecific
[#Suppressing-Inheritance]: https://www.gnu.org/software/make/manual/make.html#Suppressing-Inheritance
[#Special-Variables]: https://www.gnu.org/software/make/manual/make.html#Special-Variables
[#Conditionals]: https://www.gnu.org/software/make/manual/make.html#Conditionals
[#Conditional-Example]: https://www.gnu.org/software/make/manual/make.html#Conditional-Example
[#Conditional-Syntax]: https://www.gnu.org/software/make/manual/make.html#Conditional-Syntax
[#Testing-Flags]: https://www.gnu.org/software/make/manual/make.html#Testing-Flags
[#Functions]: https://www.gnu.org/software/make/manual/make.html#Functions
[#Syntax-of-Functions]: https://www.gnu.org/software/make/manual/make.html#Syntax-of-Functions
[#Text-Functions]: https://www.gnu.org/software/make/manual/make.html#Text-Functions
[#File-Name-Functions]: https://www.gnu.org/software/make/manual/make.html#File-Name-Functions
[#Conditional-Functions]: https://www.gnu.org/software/make/manual/make.html#Conditional-Functions
[#Foreach-Function]: https://www.gnu.org/software/make/manual/make.html#Foreach-Function
[#File-Function]: https://www.gnu.org/software/make/manual/make.html#File-Function
[#Call-Function]: https://www.gnu.org/software/make/manual/make.html#Call-Function
[#Value-Function]: https://www.gnu.org/software/make/manual/make.html#Value-Function
[#Eval-Function]: https://www.gnu.org/software/make/manual/make.html#Eval-Function
[#Origin-Function]: https://www.gnu.org/software/make/manual/make.html#Origin-Function
[#Flavor-Function]: https://www.gnu.org/software/make/manual/make.html#Flavor-Function
[#Make-Control-Functions]: https://www.gnu.org/software/make/manual/make.html#Make-Control-Functions
[#Shell-Function]: https://www.gnu.org/software/make/manual/make.html#Shell-Function
[#Guile-Function]: https://www.gnu.org/software/make/manual/make.html#Guile-Function
[#Running]: https://www.gnu.org/software/make/manual/make.html#Running
[#Makefile-Arguments]: https://www.gnu.org/software/make/manual/make.html#Makefile-Arguments
[#Goals]: https://www.gnu.org/software/make/manual/make.html#Goals
[#Instead-of-Execution]: https://www.gnu.org/software/make/manual/make.html#Instead-of-Execution
[#Avoiding-Compilation]: https://www.gnu.org/software/make/manual/make.html#Avoiding-Compilation
[#Overriding]: https://www.gnu.org/software/make/manual/make.html#Overriding
[#Testing]: https://www.gnu.org/software/make/manual/make.html#Testing
[#Options-Summary]: https://www.gnu.org/software/make/manual/make.html#Options-Summary
[#Implicit-Rules]: https://www.gnu.org/software/make/manual/make.html#Implicit-Rules
[#Using-Implicit]: https://www.gnu.org/software/make/manual/make.html#Using-Implicit
[#Catalogue-of-Rules]: https://www.gnu.org/software/make/manual/make.html#Catalogue-of-Rules
[#Implicit-Variables]: https://www.gnu.org/software/make/manual/make.html#Implicit-Variables
[#Chained-Rules]: https://www.gnu.org/software/make/manual/make.html#Chained-Rules
[#Pattern-Rules]: https://www.gnu.org/software/make/manual/make.html#Pattern-Rules
[#Pattern-Intro]: https://www.gnu.org/software/make/manual/make.html#Pattern-Intro
[#Pattern-Examples]: https://www.gnu.org/software/make/manual/make.html#Pattern-Examples
[#Automatic-Variables]: https://www.gnu.org/software/make/manual/make.html#Automatic-Variables
[#Pattern-Match]: https://www.gnu.org/software/make/manual/make.html#Pattern-Match
[#Match_002dAnything-Rules]: https://www.gnu.org/software/make/manual/make.html#Match_002dAnything-Rules
[#Canceling-Rules]: https://www.gnu.org/software/make/manual/make.html#Canceling-Rules
[#Last-Resort]: https://www.gnu.org/software/make/manual/make.html#Last-Resort
[#Suffix-Rules]: https://www.gnu.org/software/make/manual/make.html#Suffix-Rules
[#Implicit-Rule-Search]: https://www.gnu.org/software/make/manual/make.html#Implicit-Rule-Search
[#Archives]: https://www.gnu.org/software/make/manual/make.html#Archives
[#Archive-Members]: https://www.gnu.org/software/make/manual/make.html#Archive-Members
[#Archive-Update]: https://www.gnu.org/software/make/manual/make.html#Archive-Update
[#Archive-Symbols]: https://www.gnu.org/software/make/manual/make.html#Archive-Symbols
[#Archive-Pitfalls]: https://www.gnu.org/software/make/manual/make.html#Archive-Pitfalls
[#Archive-Suffix-Rules]: https://www.gnu.org/software/make/manual/make.html#Archive-Suffix-Rules
[#Extending-make]: https://www.gnu.org/software/make/manual/make.html#Extending-make
[#Guile-Integration]: https://www.gnu.org/software/make/manual/make.html#Guile-Integration
[#Guile-Types]: https://www.gnu.org/software/make/manual/make.html#Guile-Types
[#Guile-Interface]: https://www.gnu.org/software/make/manual/make.html#Guile-Interface
[#Guile-Example]: https://www.gnu.org/software/make/manual/make.html#Guile-Example
[#Loading-Objects]: https://www.gnu.org/software/make/manual/make.html#Loading-Objects
[#load-Directive]: https://www.gnu.org/software/make/manual/make.html#load-Directive
[#Remaking-Loaded-Objects]: https://www.gnu.org/software/make/manual/make.html#Remaking-Loaded-Objects
[#Loaded-Object-API]: https://www.gnu.org/software/make/manual/make.html#Loaded-Object-API
[#Loaded-Object-Example]: https://www.gnu.org/software/make/manual/make.html#Loaded-Object-Example
[#Integrating-make]: https://www.gnu.org/software/make/manual/make.html#Integrating-make
[#Job-Slots]: https://www.gnu.org/software/make/manual/make.html#Job-Slots
[#POSIX-Jobserver]: https://www.gnu.org/software/make/manual/make.html#POSIX-Jobserver
[#Windows-Jobserver]: https://www.gnu.org/software/make/manual/make.html#Windows-Jobserver
[#Terminal-Output]: https://www.gnu.org/software/make/manual/make.html#Terminal-Output
[#Features]: https://www.gnu.org/software/make/manual/make.html#Features
[#Missing]: https://www.gnu.org/software/make/manual/make.html#Missing
[#Makefile-Conventions]: https://www.gnu.org/software/make/manual/make.html#Makefile-Conventions
[#Makefile-Basics]: https://www.gnu.org/software/make/manual/make.html#Makefile-Basics
[#Utilities-in-Makefiles]: https://www.gnu.org/software/make/manual/make.html#Utilities-in-Makefiles
[#Command-Variables]: https://www.gnu.org/software/make/manual/make.html#Command-Variables
[#DESTDIR]: https://www.gnu.org/software/make/manual/make.html#DESTDIR
[#Directory-Variables]: https://www.gnu.org/software/make/manual/make.html#Directory-Variables
[#Standard-Targets]: https://www.gnu.org/software/make/manual/make.html#Standard-Targets
[#Install-Command-Categories]: https://www.gnu.org/software/make/manual/make.html#Install-Command-Categories
[#Quick-Reference]: https://www.gnu.org/software/make/manual/make.html#Quick-Reference
[#Error-Messages]: https://www.gnu.org/software/make/manual/make.html#Error-Messages
[#Complex-Makefile]: https://www.gnu.org/software/make/manual/make.html#Complex-Makefile
[#GNU-Free-Documentation-License]: https://www.gnu.org/software/make/manual/make.html#GNU-Free-Documentation-License
[#Concept-Index]: https://www.gnu.org/software/make/manual/make.html#Concept-Index
[#Name-Index]: https://www.gnu.org/software/make/manual/make.html#Name-Index

