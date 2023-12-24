# HTML

- Separate block-level HTML elements with a blank line.

# List

- Unordered list:

  + Asterisks.

  + Pluses.

  + Hyphens.

- Ordered list.

  + Numbers followed by `.`s.

  + Numbers followed by `/`s.

- Items separate by blank lines = each wrapped `<p>` tags.

- Items may consist multi paragraphs, each subsequent paragraph must be
  indented by either 4 spaces or 1 tab.

  + Hanging indent is recommended.

- Blockquote's > determiners need to be indented.

- Code block inside list item needs to be indented twice (8 spaces or 2
  tabs).

# Code blocks

- Indent every line of the block by 4 spaces or 1 tab.

# Links

- Inline links.

  This is `[an example](http://example.com/ "Title")` of inline link.

- Reference links.

  + Example:

    This is `[an example][id]` reference-style link. `[id]:
    http://example.com/ "Optional Title Here"`

  + Link definition names may consist of letters, numbers, spaces and
    punctuation - but they are _not_ case sensitive.

  + Implicit link name.

    Visit `[Daring Fireball][]` for more information. `[Daring
    Fireball]: http://daringfireball.net/`

- _Link titles_ can be enclosed in double quotes, single quotes or
  parentheses.

- The link URL may, optionaly, be surround by **angle brackets**:

  `[id]: <http://example.com/>  "Optional Title Here"`

- "Automatic" links:

  ```
  <http://example.com/>
  <address@example.com>
  ```

# Emphasis

*single asterisks*

_single underscores_

**double asterisks**

__double underscores__

***triple asterisks***

___triple underscores___

# Code {#code}

- To include literal backtick use multiple backticks:

  ``There is a literal backtick (`) here.``

  A single backtick in a code span: `` ` ``

  A backtick-delimited string in a code span: `` `foo` ``

