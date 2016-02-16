# Parsley :herb:

Love Parse but hate that it gets everywhere? That's why I wrote Parsley:herb:. It works much the way [Mantle](https://github.com/Mantle/Mantle) does.

You could also check out [lazerwalker's](https://github.com/lazerwalker) [MTLParseAdapter](https://github.com/lazerwalker/MTLParseAdapter). 

How to use :herb::

All your models should be subclasses of [JAMParseModel](https://github.com/thisismcgregor/Parsley/blob/master/Parsley/JAMParseModel.h).

Your models need to conform to the [JAMParseSerializer](https://github.com/thisismcgregor/Parsley/blob/master/Parsley/JAMParseSerializer.h) protocol. Much like Mantle, your models should return a dictionary that map the key values of your objects stored in parse, to the property values of your model objects.

It's a work in progress but, I've found it to be very helpful on my current side projects. If you have any issues let me know or submit a pull request.
