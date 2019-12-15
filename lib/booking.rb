class Booking
  def initialize(plane)
    @plane = plane
    @arrangement = plane.arrangement
    @list_of_all_seats = set_list_of_all_seats
    @reservations = []
  end

  def book(name, seats_amount)
    raise 'Reservation amount should be in range of 1 to 8 people' unless seats_amount.between?(1, 8)

    more_than_three_seats(seats_amount, name) ||
      assign_rest_of_seats(seats_amount, name) ||
      random_assign(amount, name)
  end

  def show
    reservations
  end

  private

  attr_reader :plane, :arrangement, :list_of_all_seats, :reservations

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

  def more_than_three_seats(amount, name)
    max_in_row, full_rows, and_seats = if amount <= 3
                                         [amount, 1, 0]
                                       elsif amount % 2 == 1
                                         [3, (amount / 3), (amount % 3)]
                                       elsif amount % 3 == 1
                                         [2, (amount / 2), (amount % 2)]
                                       else
                                         [3, (amount / 3), (amount % 3)]
                                       end

    draft_seats_holder = arrangement.each_with_index.map { |_v, i| arrangement[i...i+max_in_row] }
    seats_holder = draft_seats_holder.reject { |seats| seats.count < max_in_row || seats.any? { |seat| seat.eql?('_') } }
    matrix_seats_holder = []
    1.upto(plane.rows).each do |number|
      seats_holder.each do |seats|
        @temp_seats_holder = []
        (0...full_rows).each do |row_number|
          @temp_seats_holder << seats.map { |seat| "#{seat}#{number + row_number}" }
          unless number + row_number > plane.rows
            @temp_seats_holder << seats[0...and_seats].map { |seat| "#{seat}#{number + row_number + 1}" }
          end
        end
        matrix_seats_holder << @temp_seats_holder.flatten.uniq
      end
    end
    matrix_seats_holder = matrix_seats_holder.reject { |seats| seats.count < amount }
    matrix_seats_holder.each do |seats|
      if seats.all? { |seat| list_of_all_seats[seat] }
        seats.each { |seat| list_of_all_seats[seat] = false }
        @selected_seats = seats
        reservations << { name => seats }
        break
      end
    end
    @selected_seats
  end

  def assign_rest_of_seats(amount, name)
    aisle_seats = plane.row_arrangement.split('_').each_with_index.map do |seat, index|
                    index % 2 == 0 ? seat[-1] : seat[0]
                  end
    available_seats = list_of_all_seats.select { |key, value| value && key.start_with?(*aisle_seats) }.keys
    matrix_seats_holder = available_seats.each_with_index.map { |_v, i| available_seats[i...i+amount] }
    
    matrix_seats_holder = matrix_seats_holder.reject { |seats| seats.count < amount }
    matrix_seats_holder.each do |seats|
      if seats.all? { |seat| list_of_all_seats[seat] }
        seats.each { |seat| list_of_all_seats[seat] = false }
        @selected_seats = seats
        reservations << { name => seats }
        break
      end
    end
    @selected_seats
  end

  def random_assign(amount, name)
    available_seats = list_of_all_seats.select { |key, value| value }.keys
    matrix_seats_holder = [available_seats[0...amount]]
    matrix_seats_holder.each do |seats|
      if seats.all? { |seat| list_of_all_seats[seat] }
        seats.each { |seat| list_of_all_seats[seat] = false }
        @selected_seats = seats
        reservations << { name => seats }
        break
      end
    end
    @selected_seats
  end

end
