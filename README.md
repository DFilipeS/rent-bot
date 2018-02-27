# Rent Bot

## Configure Facebook Messenger Bot

* Create a page in Facebook.
* Create a new application in Facebook Developers (https://developers.facebook.com/apps/)
* Get verify and access token for Facebook Messenger Bot API.
* Change verify and access token in `apps/rent_bot_web/config/config.exs`.

## Customize crawler queries

To get a customized query, first go to each website and make your search. Search parameters will displayed in the address bar. Simply change the URL in each file to match your search.

* `apps/crawler/lib/custo_justo.ex` - URL at top of the file
* `apps/crawler/lib/idealista.ex` - URL at top of the file
* `apps/crawler/lib/imovirtual.ex` - URL at top of the file

## License

[MIT](https://github.com/DFilipeS/rent-bot/blob/master/LICENSE)
