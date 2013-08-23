# use `presentation start` in this directory to view this presentation

slide {
  title 'Ruby Programming'
  subtitle 'A simple introduction'
}

slide {
  title 'What is Ruby?'
  b 'a programming language'
  b 'lots of interpreters'
  b 'lots of fun!'
}

slide {
  title 'What does Ruby look like?'
  ruby_code "# Use up/down arrow keys to scroll\n" + File.read(__FILE__)
}

slide {
  title 'The end!'
}