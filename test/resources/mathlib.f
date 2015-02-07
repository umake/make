module mathlib
  implicit none
  
  private
  public add, sub, mul, div, md

contains
  pure function add(lhs, rhs)
    integer, intent(in) :: lhs, rhs
    integer :: add

    add = lhs + rhs
  end function add

  pure function sub(lhs, rhs)
    integer, intent(in) :: lhs, rhs
    integer :: sub

    sub = lhs - rhs
  end function sub

  pure function mul(lhs, rhs)
    integer, intent(in) :: lhs, rhs
    integer :: mul

    mul = lhs * rhs
  end function mul

  pure function div(lhs, rhs)
    integer, intent(in) :: lhs, rhs
    integer :: div

    div = lhs / rhs
  end function div

  pure function md(lhs, rhs)
    integer, intent(in) :: lhs, rhs
    integer :: md

    md = mod(lhs, rhs)
  end function md

end module mathlib
