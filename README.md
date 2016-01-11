# Parsley

![Parsley]
(http://www.foodscout.org/web/images/food/Parsley_2849.jpg)

Love Parse but hate that it gets everywhere? That's why I wrote Parsley. Also, I wanted to play with the Objective-C runtime. Parsley sounds fancier than it is. It works much the way Mantle does. Never heard of Mantle? Check it out: https://github.com/Mantle/Mantle

You could also check out lazerwalker's MTLParseAdapter: https://github.com/lazerwalker/MTLParseAdapter I haven't used it personally but it's likely more robust than my solution.

How to use :herb::

All your models should be subclasses of JAMParseModel. Your models need to conform to the JAMParseSerializer protocol. Much like Mantle, your models should return a dictionary that map the key values of your objects stored in parse, to the property values of your model objects.

That's basically it. It's **definitely** a work in progress but, I've found it to be very helpful on my current side projects. If you have any issues let me know or submit a pull request.
