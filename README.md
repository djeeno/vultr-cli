# vultr-cli

[Vultr](https://www.vultr.com/?ref=7845607-4F) CLI written in shell script.

### Dependencies

- `curl`
- [`jq`](https://stedolan.github.io/jq/)

### Install

```console
$ curl -LRsS https://raw.githubusercontent.com/djeeno/vultr-cli/master/vultr -o /tmp/vultr
$ chmod +x /tmp/vultr
$ sudo mv /tmp/vultr /usr/local/bin/vultr
```

### Tab completion

```console
$ . /usr/local/bin/vultr

$ vultr  # <tab>
configure      account        os             plans          regions        server         startupscript
```

### Set Credentials

```console
$ vultr configure
ref. https://my.vultr.com/settings/#settingsapi
Vultr API key: ************************************
```

### Run

```console
$ vultr server list
  ...
```
