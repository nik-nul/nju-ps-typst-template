// Environment for algorithmic pseudocode
#import "@preview/lovelace:0.3.0": *
#let pseudocode = pseudocode.with(indentation-guide-stroke: 0.5pt)
#let comment-color = gray
#let comment(body) = {
  h(1fr)
  text(size: .85em, fill: comment-color, sym.triangle.stroked.r + sym.space + body)
}

// Mitex for latex math equations
#import "@preview/mitex:0.2.5": *

// CeTZ for drawing
#import "@preview/cetz:0.3.2"
// Fletcher for drawing
#import "@preview/fletcher:0.5.5"
#import "@preview/zebraw:0.4.4": *


// Environment for sections, problems, solutions, etc
#let problem_counter = counter("problem")
#let section_counter = counter("section")
#let solsection_counter = counter("solsection")
#let default_problem_beginning = "Problem"
#let default_solution_beginning = "Solution:"

#let section(title: none) = {
  if title != none {
    align(center, text(20pt)[
      == #section_counter.step() #context [#section_counter.display()] #h(0.5em) #title
    ])
  } else {
    align(center, text(20pt)[
      == #section_counter.step() #context [#section_counter.display()]
    ])
  }
  problem_counter.update(0)
}

#let problem(
  title: none,
  beginning: default_problem_beginning,
  body
) = {
  if title != none {
    if beginning != none {
      text(14pt)[=== #beginning #problem_counter.step() #context [#problem_counter.display()] (#title)]
    } else {
      text(14pt)[=== #problem_counter.step() #title]
    }
  } else {
    text(14pt)[=== #beginning #problem_counter.step() #context [#problem_counter.display()]]
  }

  set par(first-line-indent: (amount: 2em, all: true))
  // set par(first-line-indent: 2em)

  body
}

#let solution(
  beginning: default_solution_beginning,
  body
) = {
  if beginning != none {
    v(.3em)
    text(12pt)[*#beginning*]
    // text(12pt)[=== #beginning]
  }
  
  solsection_counter.update(0)
  set par(first-line-indent: (amount: 2em, all: true))
  // set par(first-line-indent: 2em)

  v(-.5em)
  block(
    width: 100%,
    inset: 8pt,
    radius: 4pt,
    stroke: gray,
    body)
  line(length: 100%, stroke: black)
}

#let solsection(
  title: none
) = {
  if title != none {
    text(12pt)[*#solsection_counter.step() #context [#solsection_counter.display()] #h(0.5em) #title*]
  } else {
    text(12pt)[*#solsection_counter.step() #context [#solsection_counter.display()]*]
  }
}

#let argmin = [#math.arg]+[#math.min]
#let argmax = [#math.arg]+[#math.max]

// Initiate the document title, author...
#let assignment_class(title, author, student_number, due_time: datetime.today(), body) = {
  set text(font: ("New Computer Modern", "Noto Serif CJK SC", ))
  set document(title: title, author: author)

  // Basic page settings
  set page(
    paper: "a4", 
    header: context {
      if here().page() == 1 {
        none
      } else {
        let page_number = counter(page).display()
        let total_pages = counter(page).final().first()
        align(right, 
          [*#author* | *#title* | *Page #page_number of #total_pages*]
        )
      }
    },
    )


  // Title and Infomation
  align(center, text(24pt)[*#title*])

    [
      #set par(justify: true)
      #set text(14pt)
      #grid(
        columns: (20%, auto, 0.85fr, auto, 1fr, 20%),
        // rows: (50%, 50%),
        column-gutter: (0pt, 6pt, 14pt, 6pt, 0pt),
        [],
        [姓名：],
        [#align(center)[#author] #v(2pt, weak: true) #line(length: 100%, stroke: .7pt)],
        [学号：],
        [#align(center)[#student_number] #v(2pt, weak: true) #line(length: 100%, stroke: .7pt)],
        [],

      )
    ]
  // v(-4em)
  align(center, text(14pt)[*#due_time.display("[month repr:long] [day padding:zero], [year repr:full]")*])




  show: zebraw-init.with(..zebraw-themes.zebra-reverse, lang: true, lang-font-args: (),)
  show raw: it => {
    set text(font: ("DejaVu Sans Mono", "Noto Sans Mono CJK SC"))
    zebraw(it)
}
  


  // Setting link style
  show link: it => text(blue, underline(it, evade: false, offset: 2pt))


  body
  
}
