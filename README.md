# vultr-cli

[Vultr](https://www.vultr.com/?ref=7845607-4F) Command Line Interface written in shell script.

### Dependencies

- `curl`
- [`jq`](https://stedolan.github.io/jq/)

### Install

```console
$ curl -LRsS https://raw.githubusercontent.com/djeeno/vultr-cli/0.0.2/vultr -o /tmp/vultr
$ chmod +x /tmp/vultr
$ sudo mv /tmp/vultr /usr/local/bin/vultr
```

### Tab completion

```console
$ eval "$(vultr complete)"

$ vultr  # <tab>
account        configure      firewall       network        os             plans          regions        server         startupscript  tools          version
```

### Set Credentials

```console
$ vultr configure
ref. https://my.vultr.com/settings/#settingsapi
Vultr API key: ************************************
```

### Run

```console
$ vultr account info
{
  "balance": "0",
  "pending_charges": "0",
  "last_payment_date": "2006-01-02 15:04:05",
  "last_payment_amount": "0"
}
```
