# xpdftex

## Experiments in emulating pdftex

This is a sketch of configuring luatex to be closer to pdftex to allow
legacy pdflatex documents to be processed while still accessing
internals via Lua for PDF Tagging, MathML or other reasons.

Some differences in formatting may still exist (different underlying
hyphenation mechanism, and some more obscure pdftex extensions are
harder to emulate).

Test documents and other documents explicitly testing definitions
with `\meaning` or `\ifprimitive` can detect the emulation, but most
"normal" documents should (eventually) work without error.

luatex is mostly hidden so that packages such as graphics/hyperref etc
will choose a pdftex back end. The command `\@@!directlua` is available
as a back door to Lua (and from there you can use `tex.enableprimitives`
to access any luatex functionality).

## Sources

 - Mostly the pdftex primitive emulations are taken from luatex85
   (they could be further hidden using Lua definitions).

 - The 8-bit input/output is taken from luainputenc (via dpc-inputenc-tests github)

 - The Lua definitions of the pdftex primitives are used from expl3.lua (which is loaded)
 
 -  shell escape from the shellescape package.



## Partially implemented

 -  tex--xet so no `\beginL` etc  (Code by Marcel in xet--tex branch)

## NOT DONE

 -  logging (probably just in l3build normalisation)
 -  `\eTeXgluestretchorder`
 -  pdftex space primitives `\pdfadjustinterwordglue`,
 -  `\pdfmatch`




## Usage (without installing)

```
luatex -ini xpdflatex.ini
```

should make a `xpdflatex.fmt` format and

```
luatex \&xpdflatex test-latin-latin1.tex
```

should process an example document.


## Integration into TeXLive

* Install the files with `l3build install`

* Create binaries
   * on windows make copies from the small (2kb) `luahbtex.exe` 
    (or `luatex.exe` if you want to use that engine) in 
     `...\texlive\2022\bin\win32` and call them `xpdflatex.exe` and `xpdflatex-dev.exe`.
   * on other systems you should be able to make a symbolic link of `luahbtex` (or `luatex`)
     so in `.../texlive/2022/bin/*` execute `ln -s luahbtex xpdflatex` and 
	 `ln -s luahbtex xpdflatex-dev` or equvalent commands  for your operating system.

* Add entries to a `fmtutil.cnf` in `texmf-local/web2c` (create it if
needed):

  A sample `fmtutil.cnf` is included in the repository


The `-dev` version is optional, and instead of the engine `luahbtex`
one could use `luatex` (currently unclear which is better).

* Add search paths to a local `texmf.cnf`, e.g. the one in
`texlive/2022`:

  Sample lines are in `texmf-sample.cnf`

* Create the formats with

~~~~
fmtutil-sys --byfmt xpdflatex
fmtutil-sys --byfmt xpdflatex-dev
~~~~

   The commands `xpdflatex` and `xpdflatex-dev` should then be available.




