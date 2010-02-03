//
// Sample Javascript test code
//
if ( x )
    x;
x = { f +  // foo
        q
    go
}
r +
    bar + call( foo +
            bar
        // foo
        then
        bar
    )
ntnth  // TODO: this line should be at col 0

foo = {
    at : the,
    bar : tender
}


r
if (foo)
    // then
    // do something
    bar;
yo;
if (foo)
{
    //
    // then do something
    bar;
}
if (bar)
    /*
     * Comment on something. Comment on something. Comment on something.
     * Comment on something.     Comment on something.  
     *
     */
    yo;
foo

{
    line = getline() /* comment after code but spanning multiple lines seems to
                      * work pretty well.
                      */
    foo
}

window.prototype.foo = {
    a : hole,
    dink : wad
}

document.getElementById(
    string);

/*
 * :
 */
if (go()) // do it
    foo;
while (false) /* never do it */
    ;


/*** 
 *
 * blah
 */


switch (x) {
case 'x':
    window.alert(x);
    break;
default:
    break;
}

foo +
    //and + bar(
    //another
)
r +
    bar + call( foo +
            bar
        // foo
        then
        bar
    )
foo



{
    fuction foo() {
        /* comment */
        foo();
    }
}


/*****************************************************************************
 *
 * Known broken-ness:
 *
 */

if (yo) /*
         * dude
         *
         */
blah // this should be one level in

//

//

if (
    something) /*
                */
    //
    // broken here.  This should be one level back.  But I'll argue (for now) that
    // the previous comment (which causes this) is bad style.
    //


