# ansible-role-ospfd

Configures OpenBSD's `ospfd(8)`

## Notes about reloading and restarting in handler

The role defaults to `ospfctl reload` when configuration has changed, instead
of restarting, because full restart disrupts the network. This would work in
most cases, but there might be rare cases where you need _full_ restart
manually.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ospfd_user` | user name of `ospfd` | `_ospfd` |
| `ospfd_group` | group name of `ospfd` | `_ospfd` |
| `ospfd_service` | service name of `ospfd` | `ospfd` |
| `ospfd_conf_file` | | `/etc/ospfd.conf` |
| `ospfd_flags` | unused | `""` |
| `ospfd_router_id` | router ID | `""` |
| `ospfd_password` | shared secret for authentication | `[]` |
| `ospfd_auth_type` | authentication type | `""` |
| `ospfd_auth_md_key_id` | `md_key_id` for authentication | `""` |
| `ospfd_redistribute` | list of routes to redistribute | `[]` |
| `ospfd_no_redistribute` | list of routes _NOT_ to redistribute | `[]` |
| `ospfd_area` | dict of OSPF area (see below) | `{}` |

## `ospfd_area`

A dict of OSPF areas. The key is OSPF area ID, and the value is a dict of interfaces.

```yaml
ospfd_area:
  0.0.0.0:
    em0: passive
```

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-ospfd
  vars:
    ospfd_password:
      - password1
      - password2
    ospfd_auth_type: crypt
    ospfd_auth_md_key_id: 1
    ospfd_redistribute:
      - static
    ospfd_no_redistribute:
      - 127.0.0.0/8
    ospfd_area:
      0.0.0.0:
        em0: passive
```

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
