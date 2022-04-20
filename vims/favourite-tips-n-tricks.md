- `ga`: print the ASCII value of the character under the cursor in decimal,
  hexadecimal and octal.

# Searching

- Search non-ASCII characters: `/\v[^\d0-\d127]`

- The power of `:global`

  + Search and replace in in ranges determined by *global search*:

    ````vim
    :g/```.\+/+1,/```/-1s/^  //
    ````
    Look back and look forward is another way.

