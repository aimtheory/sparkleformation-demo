org-nginx Cookbook
==================

Requirements
------------
Have a development environment with Ruby 2+ installed.

Attributes
----------

#### org-nginx::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['org-nginx']['version']</tt></td>
    <td>String</td>
    <td>Version of nginx to install</td>
    <td><tt>'1.6.2'</tt></td>
  </tr>
  <tr>
    <td><tt>['org-nginx']['default_root']</tt></td>
    <td>String</td>
    <td>The default web server root directory</td>
    <td><tt>'/var/www'</tt></td>
  </tr>
  <tr>
    <td><tt>['org-nginx']['disable_access_log']</tt></td>
    <td>String</td>
    <td>Whether to disable the nginx access log</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
Just include `org-nginx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[org-nginx]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
