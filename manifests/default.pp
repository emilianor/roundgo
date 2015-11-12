node 'web' {
    package { 'nginx':
        ensure => installed,
        }
    
    service { 'nginx':
        ensure => running,
        require => Package['nginx'],
        }

    file { '/etc/nginx/sites-enabled/default':
        content => "upstream roundrobin {
                    server 192.168.33.101:8484;
                    server 192.168.33.102:8484;
                    }
                    server {
                    listen 80;
                    location / {
                    proxy_pass http://roundrobin;
                    }
                    }",
        require => Package['nginx'],
        notify => Service['nginx'],
        }
}

node /^node\d+$/ {
   package { 'golang':
       ensure => installed,
       }
   
   file { ['/root/gohome', '/root/gohome/src', '/root/gohome/src/go_httpd']:
       ensure => 'directory',
       before => File ['/root/gohome/src/go_httpd/go_httpd.go'],
       }

   file { '/root/gohome/src/go_httpd/go_httpd.go':
       ensure => present,
       source => "/vagrant/go_httpd.go",
       notify => Exec['compile'], 
   }

   file { '/root/compile.sh':
       content => "#!/bin/bash
export GOPATH=/root/gohome
cd $GOPATH
go install go_httpd
killall -9 go_httpd
/root/gohome/bin/go_httpd &
",
       mode => '755',
       before => File ['/root/gohome/src/go_httpd/go_httpd.go'],
   }
   
   exec { 'compile':
       command => '/root/compile.sh',
       require => File['/root/compile.sh'],
   }
}
