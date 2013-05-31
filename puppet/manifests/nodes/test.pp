node /^test/ {

  include autofs
  autofs::include {'test': }
  autofs::mount {'foo':
    map      => 'test',
    host     => 'localhost',
    location => '/bar',
  }

}
