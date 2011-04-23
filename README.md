FightForNetNeutrality
=====================

This package is a Rack middleware which allow to block some IP Address.
By default the french parlement is denied.

See http://reflets.info/wp-neutalityfr-la-neutralite-du-net-expliquee-de-maniere-optimalisee-a-muriel/


Usage
-----

Install FightForNetNeutrality:

    $ gem install fight-for-net-neutrality

Then use this middleware in your `config.ru`:

    require "fight_for_net_neutrality"
    use FightForNetNeutrality

If you are using Ruby on Rails, see the [Rails on Rack](http://guides.rubyonrails.org/rails_on_rack.html) guide.

You can also define your own IP range:

    use FightForNetNeutrality, ["62.160.71.0/24"]

That's it.


Credits
-------

It's a port to Ruby world of a WSGI middleware:
https://github.com/gawel/FightForNetNeutrality

Copyright (c) 2011 Bruno Michel <bmichel@menfin.info>
Released under the MIT license
