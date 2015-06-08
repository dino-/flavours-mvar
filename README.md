Code to explore these MVar examples [The Flavours of MVar](http://neilmitchell.blogspot.com/2012/06/flavours-of-mvar_04.html)

There's a statement on the page about implementing Once with a single MVar but it violating the "simple rules of restricted MVarS", because of the ambiguity of using the MVar empty state for two things. Could this be solved with a custom 3-state ADT? Try it.
