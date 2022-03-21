*Contents*
* [[#Block quotations]]
* [[#Verbatim (code) blocks]]
* [[#Line blocks]]

# Headings

There are two kinds of headings: Setext (`=` and `-`) and ATX (`#`).

- **blank_before_heading** extension does require a blank line before the `#` (except, the beginning of file).

    ```
      I like several of their flavors of ice cream:
      #22, for example, and #5.
    ```

- **space_in_atx_header** extension does require space between `#`s and the headings.

- **header_attributes** extension:

    ```
      # Heading {#identifier .class .class key=value key=value}
    ```

  + Headings with `.unnumbered` will not be numbered, even if `--number-sections` is specified.
  + `{-}` and `{.unnumbered}` are equivalent.
  + `.unlisted`: the heading will not be listed in a TOC.

- **implicit_header_references** extension:

    To link to a heading below:

    ```
      # Heading identifiers in HTML
    ```

    you can write

    ```
      [Heading identifiers in HTML]
    ```

    or

    ```
      [Heading identifiers in HTML][]
    ```

    or

    ```
      [the section on heading identifiers][Heading identifiers in HTML]
    ```

    instead of giving the identifier explicitly:

    ```
      [Heading identifiers in HTML](#heading-identifiers-in-html)
    ```

    If there are multiple headings with identical text, the corresponding
    reference will link to the first one only.

    The implicit link reference will always have higher priority than heading
    reference. So, in the following example the link will point to bar, not to
    #foo:

    ```
      # Foo
      [foo]: bar
      See [foo]
    ```

# Block quotations

- The > need not start at the left margin, but it should not be indented more
  than three spaces.

- "Lazy" form, which requires the `>` character only on the first line of each
  block, is also allowed:

    ```
      > This is a block quote. This
      paragraph has two lines.

      > 1. This is a list inside a block quote.
      2. Second item.
    ```

- If the `>` character is followed by an optional space, that space will be
  considered part of the block quote marker and not part of the indentation
  of contents.

- **blank_before_blockquote** extension:

    Original Markdown syntax (_markdown_strict_ format) does not require blank line before a block quote.
    Pandoc _does_ require this (except, of course, at the beginning of the document).

# Verbatim (code) blocks

- Indented code blocks (4 space or 1 tab)

- Fenced code blocks

  + **fenced_code_blocks** extension:

      Begin with 3 or more tildes (`~`).

      End with a row of tildes that must be at least as long as the starting row.
    
      If the code itself contains a row of tildes or backticks, just use a longer tildes or backticks 
      at the start and end.

  + **backtick_code_blocks** extension:

      Same as fenced_code_blocks, but uses backticks (`` ` ``) instead of tildes (`~`).

  + **fenced_code_attributes** extension:

      Optionally, you may attach attributes to fenced or backtick code block using this syntax:

      ~~~~ {#mycode .haskell .numberLines startFrom="100"}
        qsort []     = []
        qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
          qsort (filter (>= x) xs)
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      See also
      `--list-highlight-languages`,
      `--list-input-formats`,
      `--list-output-formats`,
      `--list-extensions`

      The `.numberLines` (or `number-lines`) will cause the lines of the code block to be numbered,
      starting with 1 or the value of `startFrom` attribute.

      The `lineAnchors` (or `line-anchors`) class will cause the lines to be clickable anchors in HTML output.

      A shortcut form can also be used for specifying the language of the code block:

      ~~~
        ```haskell
          qsort [] = []
        ```
      ~~~~

      This is equivalent to:

      ~~~
        ``` {.haskell}
          qsort [] = []
        ```
      ~~~

      `--no-highlight` prevent all highlight

      `--highlight-style` set highlight style

Regular/fenced code blocks must be separated from surrounding text by blank lines.

# Line blocks

- **line_block** extension:

  Line blocks are useful for address blocks, verse (poetry, song lyrics), and unadorned lists, where the structure of lines is significant.

  A line block is a sequence of lines beginning with a vertical bar (`|`) followed by a space.

    ~~~
      | 200 Main St.
      | Berkeley, CA 94718
    ~~~

  The lines can be hard-wrapped if needed, but the continuation line must begin with a space.

    ```
      | The Right Honorable Most Venerable and Righteous Samuel L.
        Constable, Jr.
      | 200 Main St.
      | Berkeley, CA 94718
    ```

  Inline formatting (such as emphasis) is allowed in the content, but not block-level formatting (such as block quotes or lists).

  This syntax is borrowed from **[reStructuredText]**

  **TODO**:
    - How to fix indentation after line blocks?
    - Can we put these in a list item?

  [reStructuredText]: https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#line-blocks "reStructuredText docs"


**SWITCHING TO COMMONMARK**
