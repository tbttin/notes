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
    * [[#Leaf blocks#Fenced code blocks|Fenced code blocks]]
    * [[#Leaf blocks#HTML blocks|HTML blocks]]
    * [[#Leaf blocks#Link reference definitions|Link reference definitions]]
    * [[#Leaf blocks#Paragraphs|Paragraphs]]
    * [[#Leaf blocks#Blank lines|Blank lines]]
* [[#Container blocks]]
    * [[#Container blocks#Block quotes|Block quotes]]
    * [[#Container blocks#List items|List items]]
        * [[#Container blocks#List items#Motivation|Motivation]]
    * [[#Container blocks#Lists|Lists]]
* [[#Inlines]]
    * [[#Inlines#Code spans|Code spans]]
    * [[#Inlines#Emphasis and strong emphasis|Emphasis and strong emphasis]]
    * [[#Inlines#Links|Links]]
        * [[#Inlines#Links#Inline links|Inline links]]
        * [[#Inlines#Links#Reference links|Reference links]]
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

What're ambiguous cases in the syntax of John Gruber's Markdown.

## Why is a spec needed?

How many questions can I answer?

## About this document

# Preliminaries

## Characters and lines

- Character, line, line ending.

- No encoding is specified, lines as composed of characters (Unicode) rather
  than bytes.

- Blank line.

- ASCII punctuation chars (all in ASCII except alpha-numeric, control chars).

## Tabs

- Tabs will be expanded to spaces (a tabstop of **four** characters) *only*
  when it help to define block structures.

- Why no space in [here](ttps://spec.commonmark.org/0.30/#example-2)?

  + This tab will expand to two spaces (four spaces tabstop) to define indented
    code.

- Why two spaces in [here](https://spec.commonmark.org/0.30/#example-5)?

  + Two spaces for list item.

  + Four spaces for indented code.

  + *Two spaces* left.

- Two tabs after `>`. Why two spaces in [here](https://spec.commonmark.org/0.30/#example-6)?

  + Six spaces inside block quote = indented code block + two space.

  + Why six?

    ```
      (> + first tab) -> tabstop = 3 spaces, but minus 1 >'s = 2 spaces
      second tab      -> tabstop = 4 spaces

      => total spaces = 6 spaces
    ```

## Insecure characters

## Backslash escapes

- When/What does it work? When/What does it not work?

  + ASCII punctuation characters.

  + Other characters.

  + Backslash at the end of line is a hard break.

  + Code blocks, code spans, autolinks, or raw HTML

## Entity and numeric character references

# Blocks and inlines

- Blocks are structural elements like:

  + Paragraphs

  + Block quotations

  + Lists

  + Headings

  + Rules

  + Code blocks

- Some blocks like block quotes and list items contain other blocks (container
  blocks).

- Others like headings and paragraphs contain inline content-text, links,
  emphasized text, images, code spans, and so on.

## Precedence

- **Blocks > inlines** - indicators of block structures always take precedence
  over indicators of inline structures. So the following example is a list of
  two items:

  ```
    - `one
    - two`

  ```

## Container blocks and leaf blocks

- Two types of blocks:

  + Container blocks, which can contain other blocks.

  + Leaf blocks.

# Leaf blocks

## Thematic breaks

- Three or more matching of `-`, `_` or `=` characters.

- **Setext headings > thematic breaks** WHEN (between paragraphs, anything else?):

  ```
    Foo
    ---
    bar
  ```

  but indented code blocks can not break paragraphs:

  ```
    Foo
    ....***
  ```

- **Thematic breaks > list item indicators**

  ```
    * Foo
    ***
    * Bar
  ```

  ```
    - Foo
    ***
    - Bar
  ```

## ATX headings

- At least one space is required between `#` character and heading content.

  ```
    #5 bolt

    #hastag
  ```

- **ATX headings > paragraphs** too. But again, indented code does not:

  ```
    foo
    ...# bar
  ```

  ```
    foo
    ....# bar
  ```

## Setext headings

- Setext heading indicators:
  + Level one heading: `=`.

  + Level two heading: `-`.

- **Paragraphs > setext headings**. So we use blank lines

  ```
    Foo *bar*
    =========

    Foo *bar*
    ---------
  ```

- The content of the header may span to more than one line:

  ```
    Foo *bar
    baz*
    ===
  ```

- The underlining can be **any** length:

  ```
    Foo
    --------------------

    Foo
    =
  ```

- Setext headings underline can not be a `lazy continuation line` in block quote
  and list item:

  ```
    > Foo
    ---
  ```
  is a thematic break outside block quote.

  ```
    > Foo
    ===
  ```
  `===` is part of the paragraph inside block quote.

  ```
    - Foo
    ---
  ```
  is a thematic break outside the list.

- Again, **setext headings > thematic breaks**

  ```
    Bleh bleh
    ---
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

How to get them?

## Indented code blocks

- **List item ownership > code block indentations**

  ```
    ..-.List

    ....List item
  ```

- **Indented code blocks < paragraphs**. (This allows hanging indents and the
  like):

  ```
    Foo
    ....bar
  ```

  And indented code can occur immediately before and after other kinds of blocks:

  ```
    # Heading
    ....foo
    Heading
    ------
    ....foo
    ----
  ```

- Any non-blank line with less than four spaces of indentation will break a code
  block

  ```
    ....Foo
    Bar
  ```

## Fenced code blocks

- **Code fence** is a sequence of at least three backtick (`` ` ``) or tilde (`~`)
  characters (tildes and backticks can not be mixed).

- The line with opening code fence may optionally followed by **info string**.

  + Info string usages?

- The closing code fence line must have the same type as the opening code fence
  (tildes or backticks), and at least as many as backticks or tildes as the
  opening code fence.

- **Fenced code blocks > paragraphs**.

- If code block itself contain the opening code fence string:

  use different code fence type:

  ~~~
    ```
      code
      ~~~
      code
    ```
  ~~~

  or longer code fence:

  ``````
    ~~~~
      code
      ~~~
      code
    ~~~~
  ``````

## HTML blocks

## Link reference definitions

- Link reference definition consists of:

  + *Link label* [[#Inlines#Links#Inline links|Inline links]].

  + Followed by a colon (`:`).

  + Optional spaces or tabs (including up to one line ending).

  + *Link destination*.

  + Optional spaces or tabs (including up to one line ending).

  + Optional *link title* [[#Inlines#Links#Inline links|Inline links]].

    * Must be separated from link destination by spaces or tabs.

    * Link title can expand over multiple lines but it can not contain a blank
    line.

  + No further character may occur.

  `[foo]: https://www.google.com "Visit google.com"`

- Link reference definitions can come either *before* or *after* the links that use
  them.

- We can use angle brackets to specify an empty link destination:

  ```
    [foo]: <>

    [foo]
  ```

- If there are several matching definitions, the *first* one takes precedence.

- **Link reference definitions < paragraphs**:

  ```
    Foo
    [bar]: /baz

    [bar]
  ```

## Paragraphs

- A sequent of non-blank lines that cannot interpreted as other kinds blocks.

- Initial and final spaces in every line will be striped (paragraph's raw content are parsed as
  inlines).

  + So paragraphs that ends with two or more spaces will not end with a *hard line break*.

- **Again**, paragraphs > indented code blocks (any amount of space):

  ```
    aaa
    .........bbb
    ..................ccc
  ```

## Blank lines

It play one role in determining whether a list is *tight* or *loose*.

# Container blocks

- A container block is a block that has other blocks as its contents. Two basic
  kind of container blocks:

  + Block quotes.

  + List items.

- Lists are meta-containers for list items.

## Block quotes

- *Block quote marker*: `>` character and an optional space of indentation.

- Two style of block quotes:

  + Basic case:

    ```
      > Foo
      > Bar
    ```

  + Laziness:

    ```
      > Foo
      Bar
    ```

- *Paragraph continuation text* is text that will be parsed as part of the
  content of a paragraph, but does not occur at the beginning of the paragraph.

- We have a *laziness continuation line* in this case:

  ```
    > Foo
    ....- Bar
  ```

- Block quotes can interrupt paragraphs:

  ```
    Foo
    > Bar

  ```

- Blank lines will separate block quotes. So, to get two paragraphs in one
  block quote:

  ```
    > Foo
    >
    > Bar
  ```

- Any number of initial `>`s can be omitted on a continuation line of a nested
  block quote:

  ```
    >.>.> Quote
    >.> Quote
    Quote
  ```

- **Notice**, indented code block in a block quote: `>`'s one space + indented code's four
  spaces:

  ```
    >.....code

    >....not.code
  ```

## List items

1. Basic

   The spaces of indentation after the list marker determine how much relative
   indentation is needed. It depends on how the list item is embedded in other
   constructions.

   + WTF is [that](https://spec.commonmark.org/0.30/#example-259)?

2. Item start with indented code

3. Item start with a blank line

4. Indentation

5. Laziness

6. That's all

- A list may be the first block in a list item:

  ```
    - - Sublist
  ```

### Motivation

- John Gruber's Markdown spec

- The four-spaces rules

## Lists

- Lose list vs. tight list

  A list is loose if any of its constituent list items are separated by blank
  lines, or if any of its constituent list items directly contain two
  block-level elements with a blank line between them. Otherwise a list is
  tight. (The difference in HTML output is that paragraphs in a loose list are
  wrapped in <p> tags, while paragraphs in a tight list are not.)

- **Lists > paragraphs**

  ```
    Paragraphs
    - List
    - List
  ```

- To separate consecutive lists of same type, or to separate a list from
  indented code block we use a blank HTML comment:

  ```
    -   foo

        code

    -   foo

    <!-- -->

        code
  ```

# Inlines

## Code spans

- Backtick string is a string of one or more backticks:

  ```
    `
  ```

  or

  ```
    ``
  ```

- A code span begin with a backtick string and ends with a backtick string
  of equal length.

  + Line endings are converted to spaces

  + Spaces striping

    + Striping conditions

  ```
    `` foo ` bar ``
  ```

- Code span backticks have higher precedence than any other inline constructs
  except HTML tags and autolinks.

- Code spans, HTML tags and autolinks have the same precedence.

- Note, opening and closing backtick string need to be equal in length:

  ```
    `foo ``bar``
  ```

## Emphasis and strong emphasis

- Nested emphasises

  ```
    ***strong emph***

    ***strong** in emph*

    ***emph* in strong**

    **in strong *emph***

    *in emph **strong***
  ```

- `**` means **strong**

- `***` means one *em* and one **strong**

- Note rule 15, rule 16 and rule 17

## Links

### Inline links

- Link label

- Link title

- Link destination can contain spaces and brackets (but not line endings) when
  it enclose in pointy brackets (`<>`):

  ```
    [link](</my uri>)
    [link](</my)uri>)
  ```

- Image as a link:

  ```
    [![moon](moon.jpg)](/uri)
  ```

- **Link texts > emphasis grouping**:

  ```
    *[foo*](/uri)
  ```

- But **link texts < code spans, autolinks, raw HTML tags**

### Reference links

[[#Leaf blocks#Link reference definitions|Link reference definitions]]

- Three kinds of reference links:

  + Full: **link text** follow immediately by a **link label**

  + Collapsed

  + Shortcut

- Consecutive spaces, tabs, and line endings are treated as one space

  ```
    [Foo
    ..Bar]:./url

    [Bar][Foo.Bar]
  ```

## Images

## Autolinks

- Spaces are not allowed in autolinks

## Raw HTML

## Hard line breaks

- A line ending (not in code span or HTML tag) that is preceded by two ore more
  spaces and does not occur at the end of a block.

## Soft line breaks

## Textual content

# Appendix: A parsing strategy

## Overview

## Phase 1: block structure

## Phase 2: inline structure

### An algorithm for parsing nested emphasis and links

#### *look for link or image*

#### *process emphasis*

