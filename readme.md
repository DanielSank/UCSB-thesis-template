This archive contains a complete template for a PhD thesis, and a class file specific to the University of California.
This template is a bit different from others in that it helps you organize your thesis by chapter.
You can build each chapter independently if you like so that it's easier to review/edit one piece at a time.
There are also some helpful macros and example "good TeX practices".
If you have questions, find errors, or you'd like to recommend improvements, please file an issue on the github issue tracker.
You can also directly submit improvements via pull requests, which is highly encouraged :-)
If you aren't comfortable with github and/or git, you can also email the author.

CLASS FILE / OPTIONS
----

The class file, ucsbthesis.cls, provides the ucsbthesis document class. This allows you to begin your document like this

`\documentclass[options]{ucsbthesis}`

The available options are defined in `ucsbthesis.cls`. The most important ones are:

* **font:** Font size for the document. The most common option is "12pt'.

* **sidedness:** Set to "twoside" if you want margins and blank pages as for binding in a book. This allows you to specify inner and outer margins such that the inner margin is always on the side of the page facing toward the book binding. The margins are actually hard coded into the class file in accordance with UC rules. The other option is "oneside", which will put the inner margin on the left and the outer margin on the right on every page.

* **spacing:** Set to "doublespace" (UC rules) or "singlespace".


BUILDABLE FILES
----

This template comes with two buildable files:

- main_department.tex

- main_UCSB_submission.tex

Build main_department.tex to get output appropriate for binding into a book. This is what you need to print out and give to the department for binding. This is just setting the "twoside" option.

Build main_UCSB_submission.tex to get output appropriate for electronic submission to the university's grad division. This uses the "oneside" option. Since the University will publish your thesis you would think that "oneside" is _not_ the right option, but I checked this explicitly and they insist this is what they want.

Each of these build files just sets a few options for the documentclass and then inputs main_content.tex.


OTHER FILES AND DIRECTORIES
----

`main_content.tex` is mostly just a bunch of include statements bringing in packages, macros, front matter, chapters, appendices, and the bibliography. Each of the other files in the root directory are specific files for each bit of front matter.

Each chapter sits in its own subdirectory. This immensely eases organization of figures etc. Note that within each chapter's directory there are at least two files. They have the same name but one has a suffix "_content". This is the actual content for the chapter which is included via main_content.tex. The point of the other file is to give you a buildable tex file which includes only the content for that chapter. This allows you to build each chapter alone during development.

The appendices work roughly the same way.
