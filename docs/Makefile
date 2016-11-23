.PHONY: out

all: out canvas event

clean:
	rm -Rf out/

out:
	mkdir -p out/
	cp doc.css lua.gif out/

event: event.intro event.functions
	cat event.html event.intro.html event.functions.html > out/event.html
	rm event.intro.html event.functions.html

event.intro:
	markdown event.intro.txt > event.intro.html

event.functions:
	markdown event.functions.txt > event.functions.html

canvas: canvas.intro canvas.functions
	cat canvas.html canvas.intro.html canvas.functions.html > out/canvas.html
	rm canvas.intro.html canvas.functions.html

canvas.intro:
	markdown canvas.intro.txt > canvas.intro.html

canvas.functions:
	markdown canvas.functions.txt > canvas.functions.html
