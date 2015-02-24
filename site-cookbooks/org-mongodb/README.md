org-mongodb Cookbook
====================
This is a demo cookbook to show what you can do with an organization specific cookbook and MongoDB.

Requirements
------------
Have a development environment with Ruby 2+ installed.

Attributes
----------

#### org-mongodb::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['org-mongodb']['config']['dbpath']</tt></td>
    <td>String</td>
    <td>The MongoDB data directory</td>
    <td><tt>'/opt/org/data'</tt></td>
  </tr>
  <tr>
    <td><tt>['org-mongodb']['config']['logpath']</tt></td>
    <td>String</td>
    <td>The MongoDB log file path</td>
    <td><tt>'/opt/org/log/mongodb.log'</tt></td>
  </tr>
  <tr>
    <td><tt>['org-mongodb']['config']['bind_ip']</tt></td>
    <td>String</td>
    <td>The MongoDB listen IP address</td>
    <td><tt>'0.0.0.0'</tt></td>
  </tr>
  <tr>
    <td><tt>['org-mongodb']['config']['port']</tt></td>
    <td>String</td>
    <td>The mongod service IP port</td>
    <td><tt>'29019'</tt></td>
  </tr>
</table>

Usage
-----
Just include `org-mongodb` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[org-mongodb]"
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
