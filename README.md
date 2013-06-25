A bootstrap repo for beamer presentations that include code and images.

Beamer is an awesome tool for making slides, but it's a bit too much effort to
set it up so that images and code just work. This repository contains a Makefile
that uses Pygments to syntax highlight your code, and lualatex to compile the
slides.

![Example image](http://jelzo.com/stuff/beamer-bootstrap.png)

## Usage

beamer-bootstrap contains mostly a Makefile that is responsible for syntax
highlighting code examples and then building a pdf from a .tex file.

To use it, first clone the repo:

    git clone git@github.com:ConradIrwin/beamer-bootstrap
    cd beamer-bootstrap

Then edit the presentation, run the makefile, and view the pdf:

    vi example.tex
    make
    open example.pdf

The Makefile will pick up any .tex files in the top-level directory and try to
make a pdf file out of them. If you want to start from a cleaner slate than the
default master branch (which contains an example.tex and example.pdf):

    git reset clean --keep

### Including code

To make a slide containing code, first create the file `code/example.rb`, then
add a slide that includes the built version:

```latex

\begin{frame}[fragile]

\frametitle{Example ruby code}
\input{build/code/example.rb}

\end{frame}
```

### Including images

To make a slide with a background image:

```latex
{
  \usebackgroundtemplate{
    % N.B. if your image is wider than it it tall, try
    % [width=\paperwidth] instead of [height=\paperheight]
    \includegraphics[height=\paperheight]{img/sad-panda.jpg}
  }
  \frame{

  }
}
```

## Installation

You need three things:

1. `lualatex` Ubuntu: `sudo apt-get install texlive-luatex`. Mac: get [MacTeX](http://www.tug.org/mactex/).
2. `make` Ubuntu: `sudo apt-get build-essential`. Mac: already has make installed.
3. `pygmentize` Ubuntu: `sudo apt-get install pygments`. Mac: `brew install python; pip install pygments`.

## Contributing

I'm interested in collecting useful macro definitions in the `\include` folder. I'd also like to include Makefile rules for other things that people want to use (like graphviz diagrams). Please send pull requests :).
