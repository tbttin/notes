[CommonMark Spec Version 0.30 (2021-06-19)](https://spec.commonmark.org/0.30/)

# Introduction

## What is Markdown?

## Why is a spec needed?

## About this document

# Preliminaries

## Characters and lines

## Tabs

Tabs will be expanded to four spaces when it help to define block structures

- Why two spaces [here](https://spec.commonmark.org/0.30/#example-5)?

  + Two space is enough to belong to this list item

- Two tabs after `>`. Why two spaces [here](https://spec.commonmark.org/0.30/#example-6)?

  + Six spaces inside block quote = code block + two space

## Insecure characters

## Backslash escapes

- When it work? and when it does not work?

  + ASCII punctuation characters

  + Code blocks, code spans, autolinks, or raw HTML

  + Other contexts (URLs, link titles, link references, .etc)

## Entity and numeric character references

# Blocks and inlines

## Precedence

- **Blocks > inlines** - indicators of block structures always take precedence over indicators of
  inline structures. So

  ```
    - `one
    - two`

  ```
  is a list of two items

## Container blocks and leaf blocks

# Leaf blocks

## Thematic breaks

- **Setext headings > thematic breaks** WHEN (between paragraphs, anything else?):


  ```
    Foo
    ---
    bar
  ```

- **Thematic breaks > list item indicators**

  ```
    * Foo
    ***
    * Bar
  ```

## ATX headings

## Setext headings

**Compatibility note**: Most existing Markdown implementations do not allow the
text of setext headings to span multiple lines. But there is no consensus about
how to interpret:

  ```
    Foo
    bar
    ----
    baz
  ```

One can find four different interpretations:

  1. paragraph “Foo”, heading “bar”, paragraph “baz”
  2. paragraph “Foo bar”, thematic break, paragraph “baz”
  3. paragraph “Foo bar — baz”
  4. heading “Foo bar”, paragraph “baz”

How to achive them?

## Indented code blocks

- An indented code block cannot interrupt a paragraph (yeah, ofcouse, blank
  line can). This allows hanging indents and the like 

  ```
    Foo
    ....bar
  ```

- **List items > code block indentations**

  ```
     ..-.Foo

       ....bar
  ```

- Any non-blank line with less than four spces of indentation will break a code
  block

  ```
    ....Foo
    Bar
  ```

# Heading

## Fenced code blocks

## HTML blocks

## Link reference definitions

## Paragraphs

## Blank lines

# Container blocks

## Block quotes

## List items

### Motivation

## Lists

# Inlines

## Code spans

## Emphasis and strong emphasis

## Links

## Images

## Autolinks

## Raw HTML

## Hard line breaks

## Soft line breaks

## Textual content

# Appendix: A parsing strategy

## Overview

## Phase 1: block structure

## Phase 2: inline structure

### An algorithm for parsing nested emphasis and links

#### *look for link or image*

#### *process emphasis*

