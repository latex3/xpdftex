# pdftexlua

## Experiments in emulating pdftex

This is a sketch of configuring luatex to be closer to pdftex to allow
legacy pdflatex documents to be processed while still accessing
internals via Lua for PDF Tagging, MathML or other reasons.

Some differences in formatting may still exist (different underlying
hyophenation mechanism, and some more obscure pdftex extensions are
harder to emulate.

Test documents and other documents explicitly testing definitiosn
with `\meaning` of `\ifprimitive` can detect the emulation, but most
"normal" documents should (eventually) work without error.

luatex is mostly hidden so that packages such as graphics/hyperref etc
will choose a pdftex back end. The command `\@@!directlua` is available
as a back door to Lua (and from there you can use tex.enableprimitives
to access any luatex functionality.

## Sources

 - Mostly the pdftex primitive emulations are taken from luatex85
   (they coudl be further hidden using Lua definitions.

 - The 8-bit input/output is taken from luainputenc (via dpc-inputenc-tests github)

 - The Lua definitions of the pdftex primitives are used from expl3.lua (which is loaded)
 

## NOT DONE

 -  shell escape (can steal code from shellesc)
 -  tex-xet do no `\beginL` etc  (might be doable in lua node callback,
    or fake with luatex direction primitives)
 -  logging (probably just in l3build normalisation)
 -  `\eTeXgluestretchorder`
 -  pdftex space primitives `\pdfadjustinterwordglue`,
 -  `\pdfmatch`
 -  pdftexbanner



## Usage

```
luatex -ini pdflatexlua.ini
```

should make a pdflatexlua.fmt format and

```
luatex \&pdflatexlua test-latin-latin1.tex
```

should process an example document.


