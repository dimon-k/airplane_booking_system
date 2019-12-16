class Booking
  def initialize(plane)
    @plane = plane
    @arrangement = plane.arrangement
    @list_of_all_seats = set_list_of_all_seats
    @all_reservations = []
  end

  def book(name, seats_amount)
    raise 'Reservation amount should be in range of 1 to 8 people' unless seats_amount.between?(1, 8)
    raise 'An airplain is full, sorry!' unless seats_available?(seats_amount)

    comfortable_allocation(seats_amount, name) ||
      aisle_allocation(seats_amount, name) ||
        random_allocation(amount, name)
  end

  def show
    all_reservations
  end

  private

  attr_reader :plane, :arrangement, :list_of_all_seats, :all_reservations

  def seats_available?(seats_needed)
    all_available_seats.count >= seats_needed
  end

  def set_list_of_all_seats
    all_seats_holder = {} 
    1.upto(plane.rows).each do |row|
      arrangement.each do |letter|
        next if letter.eql?('_')

        all_seats_holder["#{letter}#{row}"] = true
      end
    end
    all_seats_holder
  end

  def row_and_seats_params(amount)
    return [amount, 1, 0] if amount <= 3
    return [3, (amount / 3), (amount % 3)] if amount % 2 == 1
    return [2, (amount / 2), (amount % 2)] if amount % 3 == 1
    [3, (amount / 3), (amount % 3)]
  end

  def comfortable_allocation(amount, name)
    max_in_row, full_rows, and_seats = row_and_seats_params(amount)

    draft_seats_holder = arrangement.each_with_index.map { |_v, i| arrangement[i...i+max_in_row] }
    seats_holder = draft_seats_holder.reject { |seats| seats.count < max_in_row || seats.any? { |seat| seat.eql?('_') } }
    matrix_seats_holder = []
    1.upto(plane.rows).each do |number|
      seats_holder.each do |seats|
        temp_seats_holder = []
        (0...full_rows).each do |row_number|
          temp_seats_holder << seats.map { |seat| "#{seat}#{number + row_number}" }
          unless number + row_number > plane.rows
            temp_seats_holder << seats[0...and_seats].map { |seat| "#{seat}#{number + row_number + 1}" }
          end
        end
        matrix_seats_holder << temp_seats_holder.flatten.uniq
      end
    end
    matrix_seats_holder = reject_incomplete_rows(matrix_seats_holder, amount)
    assign_seats(matrix_seats_holder, name)
  end

  def aisle_allocation(amount, name)
    aisle_seats = plane.row_arrangement.split('_').each_with_index.map { |seat, index| index.even? ? seats : seats.reverse }
    available_seats = list_of_all_seats.select { |key, value| value && key.start_with?(*aisle_seats) }.keys
    matrix_seats_holder = available_seats.each_with_index.map { |_v, i| available_seats[i...i+amount] }
    matrix_seats_holder = reject_incomplete_rows(matrix_seats_holder, amount)
    assign_seats(matrix_seats_holder, name)
  end

  def reject_incomplete_rows(matrix_seats_holder, amount)
    matrix_seats_holder.reject { |seats| seats.count < amount }
  end

  def random_allocation(amount, name)
    matrix_seats_holder = [all_available_seats[0...amount]]
    assign_seats(matrix_seats_holder, name)
  end

  def all_available_seats
    list_of_all_seats.select { |key, value| value }.keys
  end

  def assign_seats(matrix_seats, name)
    matrix_seats.each do |seats|
      next unless seats.all? { |seat| list_of_all_seats[seat] }

      seats.each { |seat| list_of_all_seats[seat] = false }
      all_reservations << { name => seats }
      return seats
    end
  end
end
