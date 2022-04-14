[CommonMark Spec Version 0.30 (2021-06-19)](https://spec.commonmark.org/0.30/)

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

- ASCII punctuation chars (all ASCII characters except alpha-numeric and control chars).

## Tabs

- Tabs will be expanded to spaces (a tabstop of *four* characters) **only**
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
      (> + 1st tab) -> tabstop = 3 spaces; minus >'s space -> 2 spaces left
      second tab    -> tabstop = 4 spaces

      => total spaces = 6
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

- Some blocks like *block quotes* and *list items* can contain other blocks
  (container blocks).

- Others like `headings` and `paragraphs` contain `inline` content-text, links,
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

- **Thematic breaks > list item indicators**:

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

- ```
  #      Level one heading
  ##     Level two heading
  ###    Level three heading
  ####   Level four heading
  #####  Level five heading
  ###### Level six heading
  ```

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

- **Paragraphs > setext headings**. So we use blank lines:

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

- The underlining can be any length:

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

  `---` is a **thematic break** outside the block quote.

  ```
    > Foo
    bar
    ===
  ```

  `===` is **part of the paragraph** inside the block quote.

  ```
    - Foo
    ---
  ```

  `---` is a **thematic break** outside the list.

- Again, **setext headings > thematic breaks**:

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

- An `indented code block` is composed of one or more `indented chunks`
  separated by blank lines.

- An indented chunk is a sequence of non-blank lines, each preceded by four or
  more spaces of indentation.

- **List item ownership > code block indentations**:

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
    ...Bar
  ```

## Fenced code blocks

- `Code fence` is a sequence of at least three consecutive backtick characters
  (`` ` ``) or tildes (`~`) (tildes and backticks can not be mixed).

- The line with opening code fence may optionally followed by `info string`.

  + The info string usages?

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

- Link reference definition (`[foo]: https://www.google.com "google.com"`)
  consists of:

  + `Link label`.

  + Followed by a colon (`:`).

  + Optional spaces or tabs (including up to one line ending).

  + `Link destination`.

  + Optional spaces or tabs (including up to one line ending).

  + Optional `link title`.

  + No further character may occur.

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

  + So paragraphs that ends with two or more spaces will not end with a `hard line break`.

- **Again**, paragraphs > indented code blocks (any amount of space):

  ```
    aaa
    .........bbb
    ..................ccc
  ```

## Blank lines

- It play one role in determining whether a list is `tight` or `loose`.

# Container blocks

- A container block is a block that has other blocks as its contents. Two basic
  kind of container blocks:

  + Block quotes.

  + List items.

- Lists are `meta-container`s for list items.

## Block quotes

- `Block quote marker` consists of `>` character and an optional space of
  indentation.

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

- `Paragraph continuation text` is text that will be parsed as part of the
  content of a paragraph, but does not occur at the beginning of the paragraph.

- We have a `laziness continuation line` in this case:

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
    >.> Same level quote
    Same level quote
  ```

- **Notice**, indented code block in a block quote: `>`'s one space + indented code's four
  spaces:

  ```
    >.....code

    >....not code
  ```

## List items

- `List makers` (must be followed by at least one space or tab):

  + Unordered list (bullet list): `-`, `+`, and `*`.

  + Order list: a sequent of 1-9 digits (`0-9`) followed by either `.` or `)`.

### Rules that define list items

1. Basic case:

   - Whatever you are, *first*, be come a list item!

     ```
       -..List item
       ..Not a list item
       ...List item
       ...>.Quoted list item
       .......Indented code list item
     ```

   - The spaces of indentation after the list marker determine how much
   *relative* indentation is needed. It depends on how the list item is
   embedded in other constructions.

     ```
       ...>.>.-...List item
       >>
       >>.....List item (5 spaces after the 2nd block quote marker)
     ```

     but:

     ```
       >>.-.List item
       >>
       ..>..>..Not a list item (2 space is not enough)
     ```

2. Item start with indented code:

   ```
     -.....Indented code
     ..List item paragraph
     ......more code
   ```

3. Item start with a blank line:

   - Here are some example of non-empty lists:

     ```
       -
       ..List item
       -
       ..~~~
       ..bar
       ..~~~
       -
       ......code
     ```

   - When the list items start with a blank line, the number of spaces following
   the list marker does *not* change the required indentation:

     ```
       -...
       ..List item
     ```

   - More than one blank line *does* break a list:

     ```
       -

       ..Not a list item
     ```

4. Indentation:

   ```
     .-..A paragraph
     ....with two lines

     ........indented code
     ....>.A block code
   ```

5. Laziness:

   - Example:

     ```
       .-..A paragraph
       ..of
       three lines
       ....> But, quote
       ........Indented code
     ```

     Because of `paragraph continuation text`?

     The unindented lines are called `lazy continuation line`s.

   - Laziness can work in nested structures:

     ```
       >.-.>.Blockquote
       >.continue here
       and here
       >.-.>.here too
       >>.Not in the list
     ```

6. That's all. Nothing that is not counted as a list item by rules #1-5 counts
   as a list item.

   - A list may be the first block in a list item:

     ```
       -.-.Sublist
     ```

### Motivation

- John Gruber's Markdown spec.

- The `four-spaces rules`.

## Lists

- A list is a sequent of one or more `list item`s of the same type.

- The `start number` of an `ordered list` is determined by the list number of
  its initial list item.

- A list is `loose` when:

  + Any of its constituent list items are separated by blank lines, or

  + If any of its constituent list items directly contain two block-level
    elements with a blank line between them.

- Otherwise a list is `tight`. (The difference in HTML output is that paragraphs
  in a loose list are wrapped in `<p>` tags, while paragraphs in a tight list are
  not.)

- **Lists > paragraphs**:

  ```
    Paragraphs
    - List
    - List
  ```

  The `principle of uniformity`: if a chunk of text has a certain meaning, it
  will continue to have the same meaning when put into a container block (such
  as a list item or blockquote).

  + *Exception*: to solve of unwanted list in paragraphs with hard-wrap numerals, only lists
  starting with `1` can interrupt paragraphs:

    ```
      The number of windows in my house is
      14. The number of doors is 6.
      1. This is a list!
    ```

- To separate consecutive lists of same type, or to separate a list from
  indented code block we use a blank HTML comment:

  ```
    -...foo

    ....notcode

    -...foo

    <!-- -->

    ....code
  ```

- List items need not to be indented to the same level:

  ```
    -.a
    .-.b
    ..-.c
    ...-.d
    ..-.e
    .-.f
    -.g
  ```

  However, list items may not preceded by more than three spaces of
  indentation:

  ```
    -.a
    .-.b
    ..-.c
    ...-.d
    ....-.paragraph continuation line of previous line

    ....-.just indented code
  ```

- This is a `loose list`, because there is a blank line between the list items:

  ```
    - a
    - b

    - c
  ```

- This is a `loose list`, even though there are no blank line between the
  items, because one of the items directly contain two block-level elements
  with a blank line between them:

  ```
    -.a
    -.b

    ..c
    -.d
  ```

- This is a tight list contain a loose list:

  ```
    -.a
    ..-.b

    ....c
    -.d
  ```

# Inlines

- Inlines are parsed sequentially left to right (in left-to-right languages).

## Code spans

- `Backtick string` is a string of one or more backtick characters (`` ` ``)
  that is neither preceded nor followed by a backtick.

- A code span begins with a backtick string and ends with a backtick string
  of *equal length*:

  ```
    `normal text here ``code here``
  ```

  Wen backtick string is not close by a matching backtick string, we just have
  literal backticks.

- Content normalization:

  + Line endings are converted to spaces.

  + Spaces striping:

    * The stripping happens only if space is on both sides of the string.

    * Only one space is stripped (each side).

- Backslash escapes do not work in code spans:

  ```
    `foo \`bar`
  ```

- Code span backticks have higher precedence than any other inline constructs
  except HTML tags and autolinks.

- Code spans, HTML tags and autolinks have the same precedence:

  This is a code:

  ```
    `<a href="`">`
  ```

  But this is a HTML tag:

  ```
    <a href="`">`
  ```

- Note, opening and closing backtick string need to be equal in length:

  ```
    `foo ``bar``
  ```

## Emphasis and strong emphasis

- Nested emphasises:

    ***strong and emph***

    ***strong** in emph*

    ***emph* in strong**

    **in strong *emph***

    *in emph **strong***

- `**` means **strong**.

- `***` means one *em* and one **strong**.

- `Delimiter run` is either:

  + A sequence of one or more `*` characters that is not preceded or followed
    by a non-backslash-escaped `*` character *or*

  + A sequence of one or more `_` characters that is not preceded or followed
    by a non-backslash-escaped `_` character.

- `Left-flanking delimiter run` is a delimiter run that is:

  1. Not followed by *Unicode whitespace* **and**

  2. + Not followed by *Unicode punctuation character* **or**

     + Followed by a *Unicode punctuation character* **and** preceded by a
       *Unicode whitespace* or a *Unicode punctuation character*.

- `Right-flanking delimiter run` is a delimiter run that is:

  1. Not preceded by *Unicode white space* **and**

  2. + Not preceded by a *Unicode punctuation character* **or**

     + Preceded by a *Unicode punctuation character* **and** followed by a
       *Unicode whitespace* or a *Unicode punctuation character*.

- This is not emphasis:

  ```
   *(*foo
  ```

  But this is (em in em):

  ```
    *(*foo*)*
  ```

- This is strong in em:

  ```
    *foo**bar**baz*
  ```

  Note that in the preceding case, the interpretation (3 ems)

  ```
    <p><em>foo</em><em>bar<em></em>baz</em></p>
  ```

  **is precluded by the condition that a delimiter that can both open and
  close (like the * after foo) cannot form emphasis if the sum of the lengths
  of the delimiter runs containing the opening and closing delimiters is a
  multiple of 3 unless both lengths are multiples of 3.**

- When the lengths of the interior closing and opening delimiter runs are both
  multiples of 3, though, they can match to create emphasis:

  ```
    foo***bar***baz
  ```

  is just one em and one strong.

  ```
    foo******bar*********baz
  ```

  is triple strongs:

  ```
    <p>foo<strong><strong><strong>bar</strong></strong></strong>***baz</p>
  ```

- Note when delimiters do not match evently, Rule 11 determines the the excess
  literal `*` characters will appear ouside of the emphasis, rather than
  inside:

  ```
    **foo* <=> <p>*<em>foo</em></p>
  ```

  Why this

  ```
    **foo ** is <p>**foo bar **</p>
  ```

  but not this `*foo bar *`?

- Rule 15:

  ```
    *foo _bar* baz_ <=> <p><em>foo _bar</em> baz_</p>
  ```

- Note rule #16 and #17.

## Links

- A `link text` consists of a sequence of zero or more inline elements enclosed
  by square brackets (`[` and `]`).

- A `link destinition` consists of:

  + A sequence of *zero* or more characters between `<` and `>` that contains no
    line endings and unescaped `<` or `>` **or**

  + A nonempty sequence of characters that does not start with `<`, does not
    include space characters, and includes parentheses only if they are
    backslash-escaped or in balanced pairs.

- A `link title` consists of either:

  + A sequence of zero or more characters between *straight* double-quote
    characters (`"`), including a `"` character only if it backslash-escaped
    itselt, **or**

  + A sequence of zero or more characters between *straight* single-quote
    characters (`'`), including a `'` character only if it backslash-escaped
    itselt, **or**

  + A sequence of zero or more characters between *matching* parenthesis
    characters (`(...)`), including a `(` or `)` character only if they are
    backslash-escaped.

  Link titles can span multiple lines, but may not contain a blank line.

### Inline links

- `Inline link` consists of an *optional* `link text` followed *immediately* by a left
  parenthesis (`(`), an *optional* `link destination`, an *optional* `link title` and
  a right parenthesis (`)`).

  These four components may be separated by spaces or tabs up to one line
  ending.

  If both link destination and link title are present they must be separated by
  spaces or tabs up to one line ending.

- Link destination can contain spaces (but not line endings) and brackets when
  it enclose in pointy brackets (`<>`):

  ```
    [link](</my uri>)
    [link](</my)uri>)
  ```

- Because link titles often parsed as destination, if we try to omit link
  destination and keep link title, unexpected result will happened:

  ```
    [foo]("title")
  ```

- Link texts may contain inline content (emphasises, image, .etc):

  ```
    [![moon](moon.jpg)](/uri)
  ```

- **Link texts > emphasis grouping**:

  ```
    *[foo*](/uri)
  ```

- But **link texts < code spans, autolinks, raw HTML tags**

### Reference links

- Three kinds of reference link:

  + Full

  + Collapsed

  + Shortcut

1. - `Full reference link` consists of `link text` *immediately* followed by a
   `link label` that *match* `link reference definition` elsewhere in
   documentation.

     ```
       [foo][bar]

       [bar]: /url "title"
     ```

   - `Link label` begins with left bracket (`[`) and ends with first right bracket
     (`]`) that is not backslash-escaped. Between these brackets there must be at
     least one character that is not space, tab or line ending.

   - Label normalization:

     + Strip off the opening and closing brackets.

     + Perform *Unicode case fold*.

     + Strip leading and trailing spaces, tabs, line endings.

     + Collapse consecutive internal spaces, tabs and line endings to a single space.

2. `Collapsed reference link` consists of *link label* that matches *link
   reference definition* elsewhere in document, followed by a string `[]`.

   **The contents of first link label are parsed as inlines, which are used as
   link's text.** Thus, `[foo][]` is equivalent to `[foo][foo]`.

   ```
     [foo][]

     [foo]: /url 'title'
   ```

3. `Shortcut reference link` consists of *link label* that matches *link
   reference definition* elsewhere in document and is not followed by a string
   `[]` or a link label.

   **The contents of first link label are parsed as inlines, which are used as
   link's text.** Thus, `[foo]` and  `[foo][]` are equivalent to `[foo][foo]`.

   ```
     [foo]

     [foo]: /url 'title'
   ```

- Full and compact references take precedence over shortcut references:

  ```
    [foo][bar]

    [foo]: /url1
    [bar]: /the-chosen-one-url
  ```

  Inline link also take precedence:

  ```
    [foo]()
    [foo](not a url)

    [foo]: /not-the-chosen-one
  ```

- In the following case `[bar][baz]` is parsed as a reference, `[foo]` as
  normal text. Because `[baz]` is defined:

  ```
    [foo][bar][baz]

    [bax]: /url
  ```

- Here, though, `[foo][bar]` is parsed as a reference, since `[bar]` is defined:

  ```
    [foo][bar][baz]

    [baz]: /url1
    [bar]: /url2
  ```

- Here `[foo]` is not parsed as a shortcut reference, because it is followed by a
  link label (even though `[bar]` is not defined):

  ```
    [foo][bar][baz]

    [baz]: /url1
    [foo]: /url2
  ```

## Images

- Syntax for images is like syntax for links, with one difference. Instead of
  link text we have `image description` (`alt` attribute of `<img>` tag).

- The rules for image description are the same as for link text. Except:

  +  Image destination starts with `![` and ends with `]`.

  +  An image description may contain links.

- Note that only plain string content of image description be used (`alt="foo
  bar"` in bellow):

  ```
    ![foo [bar](/url1)](/url2)
  ```

  But in `link reference definition` the must match:

  ```
    ![*foo* bar]

    [*foo* bar]: /image-url "title"
  ```

## Autolinks

- Autolinks are absolute URIs and email addresses enclose in side `<` and `>`.

- Spaces are not allowed in autolinks.

## Raw HTML

## Hard line breaks

- A line ending (not in a code span or HTML tag) that is preceded by two or
  more spaces and does not occur at the end of a block is parsed as a hard line
  break (rendered in HTML as a `<br />` tag):

- For a more visible alternative, a backslash before the `line ending` may be
  used instead of two or more spaces:

  ```
    foo\
    bar
  ```

- More than two spaces can be used:

  ```
    foo.............
    bar
  ```

## Soft line breaks

- A regular line ending (not in a code span or HTML tag) that is not preceded
  by two or more spaces or a backslash is parsed as a softbreak.

  ```
    foo
    bar
  ```

## Textual content

- Any characters not given an interpretation by the above rules will be parsed
  as plain textual content.

  ```
    hello $.;'there
  ```

# Appendix: A parsing strategy

## Overview

## Phase 1: block structure

## Phase 2: inline structure

### An algorithm for parsing nested emphasis and links

#### *look for link or image*

#### *process emphasis*

