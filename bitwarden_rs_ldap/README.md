# bitwarden_rs_ldap
A simple LDAP connector for [bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs)

After configuring, simply run `bitwarden_rs_ldap` and it will invite any users it finds in LDAP to your `bitwarden_rs` instance.

## Deploying

This is easiest done using Docker. See the `docker-compose.yml` file in this repo for an example. If you would like to use Docker Hub rather than building, change `build: .` to `image: vividboarder/bitwarden_rs_ldap`.

Make sure to populate and mount your `config.toml`!

## Configuration

Configuration is read from a TOML file. The default location is `config.toml`, but this can be configured by setting the `CONFIG_PATH` env variable to whatever path you would like.

Configuration values are as follows:

|Name|Type|Optional|Description|
|----|----|--------|-----------|
|`bitwarden_url`|String||The root URL for accessing `bitwarden_rs`. Eg: `https://bw.example.com`|
|`bitwarden_admin_token`|String||The value passed as `ADMIN_TOKEN` to `bitwarden_rs`|
|`ldap_host`|String||The hostname or IP address for your ldap server|
|`ldap_scheme`|String|Optional|The that should be used to connect. `ldap` or `ldaps`. This is set by default based on SSL settings|
|`ldap_ssl`|Boolean|Optional|Indicates if SSL should be used. Defaults to `false`|
|`ldap_port`|Integer|Optional|Port used to connect to the LDAP server. This will default to 389 or 636, depending on your SSL settings|
|`ldap_bind_dn`|String||The dn for the bind user that will connect to LDAP. Eg. `cn=admin,dc=example,dc=org`|
|`ldap_bind_password`|String||The password for the provided bind user.|
|`ldap_search_base_dn`|String||Base dn that will be used when searching LDAP for users. Eg. `dc=example,dc=org`|
|`ldap_search_filter`|String||Filter used when searching LDAP for users. Eg. `(&(objectClass=*)(uid=*))`|
|`ldap_mail_field`|String|Optional|Field for each user record that contains the email address to use. Defaults to `mail`|
|`ldap_sync_interval_seconds`|Integer|Optional|Number of seconds to wait between each LDAP request. Defaults to `60`|
|`ldap_sync_loop`|Boolean|Optional|Indicates whether or not syncing should be polled in a loop or done once. Defaults to `true`|

## Testing

All testing is manual right now. First step is to set up Bitwarden and the LDAP server.

```bash
docker-compose up -d bitwarden ldap ldap_admin
```

1. After that, open the admin portal on http://localhost:8001 and log in using the default account info:

    Username: cn=admin,dc=example,dc=org
    Password: admin

From there you can set up your test group and users.

2. Expand the `dc=example,dc=org` nav tree and select "Create new entry here"
3. Select "Generic: Posix Group"
4. Give it a name, eg. "Users" and then save and commit
5. Select "Create child object"
6. Select "Generic: User Account"
7. Give the user a name and select a group ID number and save and commit
8. Select "Add new attribute" and select "Email" and then add a test email address

9. Run the ldap sync

```bash
docker-compose up ldap_sync
```

## Future

* Any kind of proper logging
* Tests
