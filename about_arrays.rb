require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutArrays < EdgeCase::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1,2,333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2] # start from array[2] and gets 2 elements from there, defined by array[2+i] where i = 0,1
    assert_equal [:and, :jelly], array[2,20] # starts from 3rd (array[2]) element and gets 20 elements from there (it only gets up to the last element of the array actually)
    assert_equal [], array[4,0] # starts with array[4] (=> nil) and gets 0 elements from there. Therefore getting empty array []
    assert_equal [], array[4,100] # if the n in array[n,m] is EQUAL to the array.length == array.size, it will return [] regardless of m
    assert_equal nil, array[5,0] # if the n in array[n,m] reaches beyond the "length" or "size" of the array, it will return nil (not []) regardless of m
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class
    assert_not_equal [1,2,3,4,5], (1..5)
    assert_equal [1, 2, 3, 4, 5], (1..5).to_a
    assert_equal [1, 2, 3, 4], (1...5).to_a # (1..5) != (1...5)
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2] # WARNING: [0..2].size == 1; [0..2] != [0,1,2]; [1..5] == [(1..5)]
    assert_equal [:peanut, :butter], array[0...2]
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1,2,:last], array

    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1,2], array
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)
    # unshift is like push, but to the "other" side (make :first the first element)
    assert_equal [:first,1,2], array

    shifted_value = array.shift # shift is like pop, but instead removes the first element of the array, :first
    assert_equal :first, shifted_value
    assert_equal [1,2], array
  end
end
