[CommonMark Spec Version 0.30 (2021-06-19)](https://spec.commonmark.org/0.30/)

*Contents*
* [[#Introduction]]
    * [[#Introduction#What is Markdown?|What is Markdown?]]
    * [[#Introduction#Why is a spec needed?|Why is a spec needed?]]
    * [[#Introduction#About this document|About this document]]
* [[#Preliminaries]]
    * [[#Preliminaries#Characters and lines|Characters and lines]]
    * [[#Preliminaries#Tabs|Tabs]]
    * [[#Preliminaries#Insecure characters|Insecure characters]]
    * [[#Preliminaries#Backslash escapes|Backslash escapes]]
    * [[#Preliminaries#Entity and numeric character references|Entity and numeric character references]]
* [[#Blocks and inlines]]
    * [[#Blocks and inlines#Precedence|Precedence]]
    * [[#Blocks and inlines#Container blocks and leaf blocks|Container blocks and leaf blocks]]
* [[#Leaf blocks]]
    * [[#Leaf blocks#Thematic breaks|Thematic breaks]]
    * [[#Leaf blocks#ATX headings|ATX headings]]
    * [[#Leaf blocks#Setext headings|Setext headings]]
    * [[#Leaf blocks#Indented code blocks|Indented code blocks]]
* [[#Heading]]
    * [[#Heading#Fenced code blocks|Fenced code blocks]]
    * [[#Heading#HTML blocks|HTML blocks]]
    * [[#Heading#Link reference definitions|Link reference definitions]]
    * [[#Heading#Paragraphs|Paragraphs]]
    * [[#Heading#Blank lines|Blank lines]]
* [[#Container blocks]]
    * [[#Container blocks#Block quotes|Block quotes]]
    * [[#Container blocks#List items|List items]]
        * [[#Container blocks#List items#Motivation|Motivation]]
    * [[#Container blocks#Lists|Lists]]
* [[#Inlines]]
    * [[#Inlines#Code spans|Code spans]]
    * [[#Inlines#Emphasis and strong emphasis|Emphasis and strong emphasis]]
    * [[#Inlines#Links|Links]]
    * [[#Inlines#Images|Images]]
    * [[#Inlines#Autolinks|Autolinks]]
    * [[#Inlines#Raw HTML|Raw HTML]]
    * [[#Inlines#Hard line breaks|Hard line breaks]]
    * [[#Inlines#Soft line breaks|Soft line breaks]]
    * [[#Inlines#Textual content|Textual content]]
* [[#Appendix: A parsing strategy]]
    * [[#Appendix: A parsing strategy#Overview|Overview]]
    * [[#Appendix: A parsing strategy#Phase 1: block structure|Phase 1: block structure]]
    * [[#Appendix: A parsing strategy#Phase 2: inline structure|Phase 2: inline structure]]
        * [[#Appendix: A parsing strategy#Phase 2: inline structure#An algorithm for parsing nested emphasis and links|An algorithm for parsing nested emphasis and links]]
            * [[#Appendix: A parsing strategy#Phase 2: inline structure#An algorithm for parsing nested emphasis and links#*look for link or image*|*look for link or image*]]
            * [[#Appendix: A parsing strategy#Phase 2: inline structure#An algorithm for parsing nested emphasis and links#*process emphasis*|*process emphasis*]]

# Introduction

## What is Markdown?

## Why is a spec needed?

Can you answer these questions?

## About this document

# Preliminaries

## Characters and lines

## Tabs

Tabs will be expanded to four spaces when it help to define block structures

- Why no space [here](ttps://spec.commonmark.org/0.30/#example-2)?

  + Internal tabs will be passed through as literal tabs

- Why two spaces [here](https://spec.commonmark.org/0.30/#example-5)?

  + Inside list items, to help to define block structures two tabs is needed
  + Two space is enough to belong to this list item

- Two tabs after `>`. Why two spaces [here](https://spec.commonmark.org/0.30/#example-6)?

  + Six spaces inside block quote = code block + two space
  + Why six spaces?

## Insecure characters

## Backslash escapes

- When it work? and when it does not work?

  + ASCII punctuation characters (may or may not)

  + Code blocks, code spans, autolinks, or raw HTML

  + Other contexts (URLs, link titles, link references, .etc)

## Entity and numeric character references

# Blocks and inlines

- Blocks are structural elements like paragraphs, block quotations, lists, headings,
rules, and code blocks.

  Some blocks (like block quotes and list items) contain other blocks; others
(like headings and paragraphs) contain inline content-text, links, emphasized
text, images, code spans, and so on.

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

- **Paragraphs > setext headings**. So we use blank lines

  ```
    Foo *bar*
    =========

    Foo *bar*
    ---------
  ```

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

  1. paragraph "Foo", heading "bar", paragraph "baz"
  2. paragraph "Foo bar", thematic break, paragraph "baz"
  3. paragraph "Foo bar - baz"
  4. heading "Foo bar", paragraph "baz"

How to achive them?

## Indented code blocks

- **List item ownership > code block indentations** (of course)

  ```
    ..-.Foo
    ....bar
  ```

- **Indented code blocks < paragraphs**. This allows hanging indents and the like:

  ```
    Foo
    ....bar
  ```

  And indented code can occur immediately before and after other kinds of
blocks

  ```
    # Heading
    ....foo
    Heading
    ------
    ....foo
    ----
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

- We can use angle brackets to specify an empty link destination:

  ```
    [foo]: <>

    [foo]
  ```

- If there are several matching definitions, the first one takes precedence

## Paragraphs

- Initial and final spaces in every line will be striped (paragraph's raw content are parsed as
  inlines)

  + So no _hard line break_ here

- **Again**, paragraphs > indented code blocks

  ```
    aaa
    .........bbb
    ..................ccc
  ```

## Blank lines

# Container blocks

- A container block is a block that has other blocks as its contents. Tow basic
  kind of container blocks:

  + Blockquotes

  + List items

- Lists are meta-containers for list items

## Block quotes

- Block quotes can intergrup paragraphs

  ```
    Foo
    > Bar

  ```
- Indented code block in a block quote: **five spaces** after `>`s:

  ```
    >.....code

    >....not.code
  ```

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

