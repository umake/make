module greetings

  implicit none
  
  private
  public greet

contains

  subroutine greet()
    print *, "Hello, World!"
  end subroutine greet

end module greetings
