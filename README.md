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
| ospfd\_user | user of ospfd | \_ospfd |
| ospfd\_group | group of ospfd | \_ospfd |
| ospfd\_service | service name | ospfd |
| ospfd\_conf\_file | path to `ospfd.conf(5)` | /etc/ospfd.conf |
| ospfd\_flags | unused | "" |
| ospfd\_router\_id | router id | "" |
| ospfd\_password | shared secret for authentication | [] |
| ospfd\_auth\_type | | "" |
| ospfd\_auth\_md\_key\_id | | "" |
| ospfd\_redistribute | list of routes to redistribute | [] |
| ospfd\_no\_redistribute | lits of routes _NOT_ to redistribute | [] |
| ospfd\_area | dict of OSPF area (see bellow) | {} |

Created by [yaml2readme.rb](https://gist.github.com/trombik/b2df709657c08d845b1d3b3916e592d3)

## ospfd\_area

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
