node /^test/ {

  include autofs
  autofs::include {'test': }

}
