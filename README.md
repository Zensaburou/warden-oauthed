# warden-oauthed

A [warden](https://github.com/hassox/warden) strategy that provides OAuth authentication to OAuth2 providers set up similarly to the [grape-doorkeeper](https://github.com/sethherr/grape-doorkeeper) template.

Check out [sinatra_oauthed_template](https://github.com/sethherr/sinatra_oauthed_template), a sinatra template that uses this strategy to set up authentication without a database.

Importantly, `sinatra_oauthed_template` sets all the environmental variables in the `.env` file so this will work.

---

Draws inspiration from [warden-github](https://github.com/atmos/warden-github/) :shipit: