# Overview of make
## How to Read This Manual
## Problems and Bugs
# An Introduction to Makefiles
## What a Rule Looks Like

- Rules look like this:

  ```
    target ... : prerequisites ...
    	recipe
    	...
    	...
  ```

  Remember to put one tab character (or .RECIPEPREFIX value) at the beginning
  of every recipe line!

## A Simple Makefile
## How make Processes a Makefile

- `Default goal` is the first target or `.DEFAULTGOAL` variable.

## Variables Make Makefiles Simpler
## Letting make Deduce the Recipes
## Another Style of Makefile
## Rules for Cleaning the Directory
# Writing Makefiles
## What Makefiles Contain

- Makefile contain five kinds of things:

  + Explicit rules.

  + Implicit rules.

  + Variable definitions.

  + Directives.

  + Comments.

##.1 Splitting Long Lines
## What Name to Give Your Makefile
## Including Other Makefiles
## The Variable MAKEFILES
## How Makefiles Are Remade
## Overriding Part of Another Makefile
## How make Reads a Makefile
## How Makefiles Are Parsed
## Secondary Expansion
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
### The ‘--print-directory’ Option
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
## Defining [[Multi-Line.md|Multi-Line]] Variables
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

