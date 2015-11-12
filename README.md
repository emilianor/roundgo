By executing "vagrant up" in the main directory 3 vm will be launched by virtualbox.
These vm are configured by puppet with the manifest "manifests/default.pp"

The web server with nginx is accessible either locally at the address 192.168.33.100 (port 80) 
or from outside on the port 8080 (e.g. vagrant configure a port mapping from port 8080 of 
the host to port 80 of the guest with nginx)

After that you can execute:

> wget localhost:8080 -O index.html -q; cat index.html; echo
Hi there, I'm served from node1!
> wget localhost:8080 -O index.html -q; cat index.html; echo
Hi there, I'm served from node2!

And that proves that the Round Robin mechanism works well

The two nodes (192.168.33.101 and 192.168.33.102) make a local copy of the file httpd_go.go
in the main directory and after that, when the puppet manifest is executed, they compile it (if it's changed)
and execute.
