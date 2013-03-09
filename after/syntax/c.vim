" Disable spell-checking of bizarre words:
"  - Mixed alpha / numeric
"  - Mixed case (starting upper) / All upper
"  - Mixed case (starting lower)
"  - Contains strange character
syn match spellingException "\<\w*\d[\d\w]*\>"      transparent contained containedin=cComment.*\> contains=@NoSpell
syn match spellingException "\<\(\u\l*\)\{2,}\>"    transparent contained containedin=cComment.*\> contains=@NoSpell
syn match spellingException "\<\(\l\+\u\+\)\+\l*\>" transparent contained containedin=cComment.*\> contains=@NoSpell
syn match spellingException "\k\+[/\\_`.]\k\+"      transparent contained containedin=cComment.*\> contains=@NoSpell

