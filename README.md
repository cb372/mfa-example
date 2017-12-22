# mfa-example

An example of generating MFA (multi-factor auth) tokens using the TOTP algorithm.

This is accompanying code for [this blogpost](http://tech.ovoenergy.com/mfa-tokens).

See [the RFC](https://tools.ietf.org/html/rfc6238) for all the gory details.

## How to run

Install `stack` if you don't already have it.

```
$ stack build && stack exec mfa-example-exe
816808
```

The number printed to stdout is an MFA token.
