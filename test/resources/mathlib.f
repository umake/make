!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!                                                                            !!
!!  Copyright 2015 RCF                                                        !!
!!                                                                            !!
!!  Licensed under the Apache License, Version 2.0 (the "License"); you may   !!
!!  not use this file except in compliance with the License. You may obtain   !!
!!  a copy of the License at                                                  !!
!!                                                                            !!
!!      http://www.apache.org/licenses/LICENSE-2.0                            !!
!!                                                                            !!
!!  Unless required by applicable law or agreed to in writing, software       !!
!!  distributed under the License is distributed on an "AS IS" BASIS,         !!
!!  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  !!
!!  See the License for the specific language governing permissions and       !!
!!  limitations under the License.                                            !!
!!                                                                            !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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
