program simple_calc

  use mathlib

  implicit none
  
  character :: op
  integer   :: lhs, rhs, io
  
  do
    read (*,'(I2 A1 I2)',iostat=io) lhs, op, rhs
    
    if (io < 0) then
      exit
    endif

    if (io > 0) then
      write (*,*) "Problem on reading!"
      exit
    endif
    
    write (*,fmt='(I2)') calculate(op, lhs, rhs)
  end do
  
contains
  
  pure function calculate(op, lhs, rhs) result(res)
    character, intent(in) :: op
    integer, intent(in)   :: lhs
    integer, intent(in)   :: rhs
    integer               :: res

    select case (op)
      case ('+')
        res = add(lhs, rhs)
      case ('-')
        res = sub(lhs, rhs)
      case ('*')
        res = mul(lhs, rhs)
      case ('/')
        res = div(lhs, rhs)
      case ('%')
        res = md(lhs, rhs)
    end select

  end function calculate

end program simple_calc
